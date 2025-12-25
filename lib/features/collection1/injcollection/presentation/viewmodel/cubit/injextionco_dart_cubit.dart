import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/followordermodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workercomodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workermodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/repo/injectioncorepoimp.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';

part 'injextionco_dart_state.dart';

class InjextioncoDartCubit extends Cubit<InjextioncoDartState> {
  String status = "فردى";
  Map<String, List<dynamic>> workersdiagram = {};
  final Injectioncorepoimp injectioncorepoimp;
  Map<String, List<Map<String, dynamic>>> workerspermonth = {};
  List<Workermodel> workers = [];
  List<Followordermodel> followorders = [];
  List<Workercomodel> workersco = [];
  InjextioncoDartCubit(this.injectioncorepoimp)
      : super(InjextioncoDartInitial());
  List<injectioncomodel> injectionsco = [];
  adddatat({required injectioncomodel injec}) async {
    emit(addinjectioncoloading());
    var result = await injectioncorepoimp.adddata(injec: injec);
    result.fold((failure) {
      emit(addinjectioncofailure(errormessage: failure.error_message));
    }, (success) {
      emit(addinjectioncosuccess(successmessage: success));
    });
  }

  updatedata({required injectioncomodel injec}) async {
    emit(UpdateInjextioncoDartloading());
    var result = await injectioncorepoimp.updatedata(injec: injec);
    result.fold((failure) {
      emit(UpdateInjextioncoDartfailure(errormessage: failure.error_message));
    }, (success) {
      emit(UpdateInjextioncoDartsuccess(successmessage: success));
    });
  }

  getdata({required String date}) async {
    emit(getinjectioncoloading());
    var result = await injectioncorepoimp.getdata(date: date);
    result.fold((failure) {
      emit(getinjectioncofailure(errormessage: failure.error_message));
    }, (success) {
      injectionsco = success;
      emit(getinjectioncosuccess(
          successmessage: "تم الحصول علي جميع البيانات بنجاح"));
    });
  }

  getworkers({required String worker, required String month}) async {
    emit(Injextioncworkersloading());
    var result =
        await injectioncorepoimp.getworkerdata(month: month, worker: worker);
    result.fold((failure) {
      emit(Injextioncworkersfailure(errormessage: failure.error_message));
    }, (success) {
      workers = success;
      emit(Injextioncworkerssuccess(
          successmessage: "تم الحصول علي جميع البيانات بنجاح"));
    });
  }

  deleteproduction({required injectioncomodel prduction}) async {
    emit(deleteinjectioncoloading());
    var result = await injectioncorepoimp.deletedata(injec: prduction);
    result.fold((failure) {
      emit(deleteinjectioncofailure(errormessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < injectionsco.length; i++) {
        if (injectionsco[i].docid == prduction.docid) {
          injectionsco.removeAt(i);

          break;
        }
      }

      emit(deleteinjectioncosuccess(successmessage: success));
    });
  }

  changetype({required String value}) {
    status = value;
    emit(changetypestate());
  }

  getworkercodate(
      {required String month, required BuildContext context}) async {
    print("llllllllllllllllllllllllllllll");
    emit(getworkercodataloading());
    var result = await injectioncorepoimp.getworkercodata(month: month);
    result.fold((failure) {
      emit(getworkercodatafailure(errorrmessage: failure.error_message));
    }, (success) {
      workersco = success;
      workersdiagram = {};
      workerspermonth = {};
      BlocProvider.of<WorkerCubit>(context).myworkers.forEach((e) {
        workersdiagram.addAll({
          e: [],
          "${e}-{expected}": [],
          "${e}-{true}": [],
          "${e}-{workdays}": []
        });
        workerspermonth.addAll({e: []});
      });
      success.forEach((e) {
        num val = ((e.quantity *
                BlocProvider.of<AverageCubit>(context).averagerate[e.job]) /
            (e.time * 60));
        if (workersdiagram[e.name] != null) {
          workersdiagram[e.name]!.add(val / 100);
          workersdiagram["${e.name}-{true}"]!.add(e.quantity);
          if (!workersdiagram["${e.name}-{workdays}"]!.contains(e.date))
            workersdiagram["${e.name}-{workdays}"]!.add(e.date);
          workersdiagram["${e.name}-{expected}"]!.add((e.time * 60) /
              BlocProvider.of<AverageCubit>(context).averagerate[e.job]);
        }
      });
      print(workersdiagram);
      emit(getworkercodatasuccess(
          successmessage: "تم الحصول علي جميع البيانات"));
    });
  }
}
