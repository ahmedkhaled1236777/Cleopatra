import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel%20copy.dart';
import 'package:cleopatra/features/injections/injectionorders/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/produsagestate.dart';

class injectionusagecuibt extends Cubit<injectionusagetates> {
  final injectionhallrepoimplementation injectionrepoimplementatio;
  String type = "لا";
  double scrap = 0;
  double realprod = 0;
  double workhours = 0;
  double expecprod = 0;
  double machinestop = 0;
  List<dynamic> diagnoses = [];
  injectionusagecuibt({required this.injectionrepoimplementatio})
      : super(injectiontateintial());
  List<injectionusagemodel> myinjection = [];
  double total = 0;
  resest() {
    type = "لا";
    emit(resetstatus());
  }

  addinjection(
      {required injectionusagemodel injectionmodel,
      required String docid}) async {
    emit(injectionusagetateloading());
    var result = await injectionrepoimplementatio.addinjectionsub(
        injectionmodel: injectionmodel, docid: docid);
    result.fold((failure) {
      emit(injectionusagetatefailure(error_message: failure.error_message));
    }, (success) {
      emit(injectionusagetatesuccess(success_message: success));
    });
  }

  getinjection({required String docid}) async {
    emit(getinjectionusagetateloading());
    var result =
        await injectionrepoimplementatio.getinjectionssub(docid: docid);
    result.fold((failure) {
      emit(getinjectionusagetatefailure(error_message: failure.error_message));
    }, (success) {
      diagnoses = [];
      total = 0;
      scrap = 0;
      expecprod = 0;
      machinestop = 0;
      workhours = 0;
      myinjection = success;
      myinjection.forEach((e) {
        diagnoses.addAll(e.diagnoses);
        total = total + double.parse(e.quantity);
        scrap = scrap + double.parse(e.scrap);
        expecprod = expecprod + double.parse(e.expectedprod);
        machinestop = machinestop + double.parse(e.stoptime);
        workhours = workhours + double.parse(e.workhours);
      });

      emit(getinjectionusagetatesuccess(
          success_message: "تم الحصول علي البيانات بنجاح"));
    });
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  deleteinjections(
      {required injectionusagemodel prduction, required String docid}) async {
    emit(deleteinjectionusagetateloadind());
    var result = await injectionrepoimplementatio.deleteinjectionsub(
        prduction: prduction, docid: docid);
    result.fold((failure) {
      emit(deleteinjectionusagetatefailure(
          error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < myinjection.length; i++) {
        if (myinjection[i].ordernumber == prduction.ordernumber) {
          myinjection.removeAt(i);
          total = total - int.parse(prduction.quantity);

          break;
        }
      }

      emit(deleteinjectionusagetatesuccess(success_message: success));
    });
  }

// ignore: non_constant_identifier_names
}
