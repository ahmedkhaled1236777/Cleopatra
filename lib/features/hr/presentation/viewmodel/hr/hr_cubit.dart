import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/hr/data/model/absensemodel.dart';
import 'package:cleopatra/features/hr/data/model/attendancemodel.dart';
import 'package:cleopatra/features/hr/data/model/cut.dart';
import 'package:cleopatra/features/hr/data/model/holidays.dart';
import 'package:cleopatra/features/hr/data/model/waitingmodel.dart';
import 'package:cleopatra/features/hr/data/repo/hrrepoimp.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

part 'hr_state.dart';

class HrCubit extends Cubit<HrState> {
  HrCubit(
    this.hrrepoimp,
  ) : super(HrInitial());
  final Hrrepoimp hrrepoimp;
  List<Attendancemodel> attendances = [];
  List<waitingmodel> waitings = [];
  List<String> waitingstatus = [];
  List<bool> waitingstatusbool = [];
  getallattendance(
      {required String month, required BuildContext context}) async {
    emit(getallattendanceloading());

    await BlocProvider.of<attendanceworkersCubit>(context)
        .getattendanceworkers();
    var result = await hrrepoimp.getattallendence(month: month);
    result.fold((failure) {
      emit(getallattendancefailure(errormessage: failure.error_message));
    }, (success) {
      attendances = success;
      emit(getallattendancesuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  addabsense(
      {required Absensemodel absense,
      required String monthyear,
      required String workerid}) async {
    emit(addabsenseloading());
    var result = await hrrepoimp.addabsense(
        absense: absense, monthyear: monthyear, workerid: workerid);
    result.fold((l) {
      emit(addabsensefailure(errormessage: l.error_message));
    }, (r) {
      emit(addabsensesucess(successmessage: r));
    });
  }

  addmoneycut(
      {required cutmodel cut,
      required String monthyear,
      required String workerid}) async {
    emit(addcutloading());
    var result = await hrrepoimp.addcutmoney(
        cut: cut, monthyear: monthyear, workerid: workerid);
    result.fold((l) {
      emit(addcutfailure(errormessage: l.error_message));
    }, (r) {
      emit(addcutsuccess(successmessage: r));
    });
  }

  addfullholiday({required String monthyear, required holiday holiday}) async {
    emit(addfullholidayloading());
    var result =
        await hrrepoimp.addfullholiday(monthyear: monthyear, holiday: holiday);
    result.fold((l) {
      emit(addfullholidayfailure(errormessage: l.error_message));
    }, (r) {
      emit(addfullholidaysuccess(successmessage: r));
    });
  }

  getwaintings({required String monthyear}) async {
    emit(getallwaitingsloading());
    var result = await hrrepoimp.getwaitings(monthyear: monthyear);
    result.fold((failure) {
      emit(getwaitingsfailure(errormesaage: failure.error_message));
    }, (success) {
      waitings = success;
      success.forEach((e) {
        waitingstatus.add("مرفوضه");
        waitingstatusbool.add(false);
      });
      emit(getwaitingssuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  changestatus({required String status, required int index}) {
    waitingstatus[index] = status;
    emit(changewaitingstatus());
  }

  editwaintings(
      {required String monthyear,
      required waitingmodel waiting,
      required String status}) async {
    emit(deletewaitingsloading());
    var result = await hrrepoimp.deletewaiting(
        monthyear: monthyear, waiting: waiting, status: status);
    result.fold((failure) {
      emit(deletewaitingsfailure(errormessage: failure.error_message));
    }, (success) {
      waitings.removeWhere((e) {
        return e == waiting;
      });
      emit(deletewaitingssuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
