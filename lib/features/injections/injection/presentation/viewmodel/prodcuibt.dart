import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/injections/injection/data/models/diagnosemodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/ordermodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/timermodel.dart';
import 'package:cleopatra/features/injections/injection/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';

class productioncuibt extends Cubit<productiontates> {
  final productionrepoimplementation productionrepoimplementatio;

  productioncuibt({required this.productionrepoimplementatio})
      : super(productiontateintial());
  List<productionmodel> myproduction = [];

  List<Ordermodel> filterdata = [];
  String ordername = "اختر الاوردر";
  List<timermodel> timers = [];
  List<dynamic> selecteditems = [];
  List<String> diagnoses = [];
  Map timerrate = {};
  List<bool> checks = [];
  List<Ordermodel> orders = [];
  List<Ordermodel> injorders = [];
  int pageloading = 0;
  orderchange(String val) {
    ordername = val;
    emit(cahngeorder());
  }

  addproduction({required productionmodel productionmodel}) async {
    emit(productiontateloading());
    var result = await productionrepoimplementatio.addproduction(
        productionmodel: productionmodel);
    result.fold((failure) {
      emit(productiontatefailure(error_message: failure.error_message));
    }, (success) {
      emit(productiontatesuccess(success_message: success));
    });
  }

  addorder({required Ordermodel order}) async {
    emit(addorderloading());
    var result = await productionrepoimplementatio.addorder(order: order);
    result.fold((failure) {
      emit(addorderfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addordersuccess(successmessage: success));
    });
  }

  adddiagnose({required Diagnosemodel diagnose}) async {
    emit(adddiagnoseloading());
    var result =
        await productionrepoimplementatio.adddiagnose(diagnose: diagnose);
    result.fold((failure) {
      emit(adddiagnosefailure(errormessage: failure.error_message));
    }, (success) {
      emit(adddiagnosesuccess(successmessage: success));
    });
  }

  getproduction({required String date}) async {
    emit(getproductiontateloading());
    var result = await productionrepoimplementatio.getproductions(date: date);
    result.fold((failure) {
      emit(getproductiontatefailure(error_message: failure.error_message));
    }, (success) {
      checks = [];

      myproduction = success;
      myproduction.forEach((e) {
        checks.add(true);
      });

      emit(getproductiontatesuccess(
          success_message: "تم الحصول علي التقارير بنجاح"));
    });
  }

  getdiagnoses() async {
    emit(getdiagnoseloading());
    var result = await productionrepoimplementatio.getdiagnose();
    result.fold((failure) {
      emit(getdiagnosefailure(errormessage: failure.error_message));
    }, (success) {
      diagnoses.clear();
      success.forEach((e) {
        diagnoses.add(e.diagnose);
        cashhelper.setdata(key: e.diagnose, value: e.fix);
      });
      cashhelper.setdata(key: "diagnoses", value: diagnoses);
      emit(getdiagnosesuccess(successmessage: "تم الحصول علي الاعطال بنجاح"));
    });
  }

  deleteproduction({required productionmodel prduction}) async {
    emit(deleteproductiontateloadind());
    var result = await productionrepoimplementatio.deleteproduction(
        prduction: prduction);
    result.fold((failure) {
      emit(deleteproductiontatefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < myproduction.length; i++) {
        if (myproduction[i].docid == prduction.docid) {
          myproduction.removeAt(i);
          checks.removeAt(i);

          break;
        }
      }

      emit(deleteproductiontatesuccess(success_message: success));
    });
  }

  changechecbox({required bool val, required int index}) {
    checks[index] = val;
    emit(changechecboxstate());
  }

  shearchforproduction(
      {String? date, String? machinenumber, String? shift}) async {
    emit(getproductiontateloading());
    var result = await productionrepoimplementatio.searchproductions(
        date: date, machinenumber: machinenumber, shift: shift);
    result.fold((failure) {
      emit(getproductiontatefailure(error_message: failure.error_message));
    }, (success) {
      checks = [];
      myproduction = success;
      myproduction.forEach((e) {
        checks.add(true);
      });
      emit(getproductiontatesuccess(
          success_message: "تم الحصول علي التقارير بنجاح"));
    });
  }

  shearchfororder(String ordernumber) async {
    orders = [];
    for (int i = 0; i < filterdata.length; i++) {
      if (ordernumber == filterdata[i].ordernumber) {
        orders.add(filterdata[i]);
      }
    }

    emit(getordersuccess(successmessage: "success_message"));
  }

  refresorders() {
    orders = filterdata;
    emit(getordersuccess(successmessage: "success_message"));
  }

  resetordernumber() {
    ordername = "اختر الاوردر";
    selecteditems = [];
    emit(cahngeorder());
  }

  resetselecteditems() {
    selecteditems = [];
    emit(resetselected());
  }

  addtimer({required timermodel timer}) async {
    emit(AddTimerLoading());
    var result = await productionrepoimplementatio.addtimer(timer: timer);
    result.fold((failure) {
      emit(AddTimerFailure(failuremessage: failure.error_message));
    }, (success) {
      emit(AddTimerSucess(successmessage: success));
    });
  }

  update({required timermodel timer}) async {
    emit(UpdateTimerLoading());
    var result = await productionrepoimplementatio.updatetimer(timer: timer);
    result.fold((failure) {
      emit(UpdateTimerFailure(errormessage: failure.error_message));
    }, (success) {
      emit(UpdateTimerSuccess(successmessage: success));
    });
  }

  deletetimer({required timermodel timer}) async {
    emit(DeleteTimerloading());
    var result = await productionrepoimplementatio.deletetimer(timer: timer);
    result.fold((failure) {
      emit(DeleteTimerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(DeleteTimerSuccess(successmessage: success));
    });
  }

  gettimers() async {
     emit(GetTimerLoading());
    var result = await productionrepoimplementatio.gettimers();
    result.fold((failure) {
      emit(GetTimerFailure(errormessage: failure.error_message));
    }, (success) {
      timers = success;
      timerrate = {};
         List<String> mymolds = [];
    
      timers.forEach((element) {
                mymolds.add(element.moldname);

        timerrate.addAll({
          "${element.moldname}-${element.materialtype}": {
            "cycletime": element.secondsperpiece,
            "weight": element.weight,
            "sprueweight": element.sprueweight,
            "weightbysprue": (double.parse(element.weight)+(element.sprueweight/int.parse(element.numberofpieces))).toStringAsFixed(2),
            "numberofpieces": element.numberofpieces,
            "materialtype": element.materialtype
          }
        });
      });
            cashhelper.setdata(key: "mymolds", value: mymolds);

      emit(
          GetTimerSuccess(successmessage: "تم الحصول علي جميع المعدلات بنجاح"));
    });
  }
// ignore: non_constant_identifier_names
}
