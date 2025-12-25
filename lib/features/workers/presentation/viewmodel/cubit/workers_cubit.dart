import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/workers/data/models/workermodelrequest.dart';
import 'package:cleopatra/features/workers/data/repos/workerrepoimp.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_state.dart';

class attendanceworkersCubit extends Cubit<attendanceworkersState> {
  attendanceworkersCubit({required this.workerrepoimp})
      : super(attendanceworkersInitial());
  final attendanceWorkerrepoimp workerrepoimp;
  String? deviceip;
  String scanner = "معرف الجهاز";
  Map<String, Map<String, dynamic>> device = {};
  List<Workermodelrequest> attendanceworkers = [];
  List<String> workers = [];
  String workername = "اسم الموظف";
  changescanner(String value, BuildContext context) {
    scanner = value;
    emit(changescannerstate());
  }

  changeemployename(String value) {
    workername = value;
    emit(changeworkernamestate());
  }

  addworker({required Workermodelrequest worker}) async {
    emit(addworkerloading());
    var result = await workerrepoimp.addworker(worker: worker);
    result.fold((failure) {
      emit(addworkerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addattendanceworkersuccess(successmessage: success));
    });
  }

  deleteworker({required String workerid}) async {
    emit(deleteworkerloading());
    var result = await workerrepoimp.deletworker(workerid: workerid);
    result.fold((failure) {
      emit(deleteworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      attendanceworkers.removeWhere((e) {
        return e.name == workerid;
      });
      emit(deleteattendanceworkersuccess(successmessage: Success));
    });
  }

  updateworker({required Workermodelrequest worker, required String id}) async {
    emit(editworkerloading());
    var result = await workerrepoimp.editworker(worker: worker, id: id);
    result.fold((failure) {
      emit(editworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      emit(editattendanceworkersuccess(successmessage: Success));
    });
  }

  getattendanceworkers({Map<String, dynamic>? queryparma}) async {
    emit(getworkerloading());
    var result = await workerrepoimp.getworkers();
    result.fold((failure) {
      emit(getworkerfailure(errormessage: failure.error_message));
    }, (Success) {
      attendanceworkers = Success;
      workers.clear();
      Success.forEach((e) {
        workers.add(e.name);
        device.addAll({
          e.name: {"name": e.name, "salary": e.salary, "workhours": e.workhours}
        });
      });

      emit(getattendanceworkersuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }
}
