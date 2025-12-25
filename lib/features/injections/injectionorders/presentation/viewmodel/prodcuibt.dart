import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injectionorders/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/qc/presentation/view/qcreports.dart';

class injectionhallcuibt extends Cubit<injectionhalltates> {
  final injectionhallrepoimplementation injectionrepoimplementatio;
  String ordername = "اختر الاوردر";
    String type = "بمصب";

  List<String> orders = [];
  bool firsttime = true;
  Map ordermap = {};
  Map qcmap = {};
  List<String> orderwithname = [];
  injectionhallcuibt({required this.injectionrepoimplementatio})
      : super(injectiontateintial());
  List<injectionhallmodel> myinjection = [];
  List<injectionhallmodel> filterdata = [];
  changeordersprue({required String val}){
    type=val;emit(changeorderspruestate());
  }
  addinjection({required injectionhallmodel injectionmodel}) async {
    emit(injectionhalltateloading());
    var result = await injectionrepoimplementatio.addinjection(
        injectionmodel: injectionmodel);
    result.fold((failure) {
      emit(injectionhalltatefailure(error_message: failure.error_message));
    }, (success) {
      emit(injectionhalltatesuccess(success_message: success));
    });
  }

  updateorder({required injectionhallmodel injectionmodel}) async {
    emit(updateorderloading());
    var result = await injectionrepoimplementatio.updateorder(
        injectionmodel: injectionmodel);
    result.fold((failure) {
      emit(updateorderfailure(errormessage: failure.error_message));
    }, (success) {
      emit(updateordersuccess(successmessage: success));
    });
  }

  getinjection({required bool status}) async {
    if (firsttime) emit(getinjectionhalltateloading());
    var result = await injectionrepoimplementatio.getinjections(status: status);
    result.fold((failure) {
      emit(getinjectionhalltatefailure(error_message: failure.error_message));
    }, (success) {
      firsttime = false;
      filterdata = success;
      myinjection = success;
      orders = [];
      success.forEach((element) {
        orders.add("${element.ordernumber} - ${element.name}");
qcmap.addAll({
"${element.machine}":{
  "prodname":element.name,
  "prodcolor":element.color,
  
}
});
        ordermap.addAll({
          "${element.ordernumber} - ${element.name}": {
            "material": element.materialtype,
            "ordernumber": element.ordernumber,
            "color": element.color,
            "machine": element.machine,
            "mold": element.name,
          },
        });
      });
      emit(getinjectionhalltatesuccess(
          success_message: "تم الحصول علي الاوردرات بنجاح"));
    });
  }

  deleteinjection({required injectionhallmodel prduction}) async {
    emit(deleteinjectionhalltateloadind());
    var result =
        await injectionrepoimplementatio.deleteinjection(prduction: prduction);
    result.fold((failure) {
      emit(
          deleteinjectionhalltatefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < filterdata.length; i++) {
        if (filterdata[i].ordernumber == prduction.ordernumber) {
          filterdata.removeAt(i);
          orders.removeAt(i);
          break;
        }
      }
      for (int i = 0; i < myinjection.length; i++) {
        if (myinjection[i].ordernumber == prduction.ordernumber) {
          myinjection.removeAt(i);

          break;
        }
      }

      emit(deleteinjectionhalltatesuccess(success_message: success));
    });
  }

  shearchfororder({String? ordernumber, String? prodname}) async {
    myinjection = [];
    if (ordernumber != null && prodname != null)
      for (int i = 0; i < filterdata.length; i++) {
        if (ordernumber == filterdata[i].ordernumber &&
            filterdata[i].name.contains(prodname)) {
          myinjection.add(filterdata[i]);
        }
      }
    if (ordernumber == null && prodname != null)
      for (int i = 0; i < filterdata.length; i++) {
        if (filterdata[i].name.contains(prodname)) {
          myinjection.add(filterdata[i]);
        }
      }
    if (ordernumber != null && prodname == null)
      for (int i = 0; i < filterdata.length; i++) {
        if (ordernumber == filterdata[i].ordernumber) {
          myinjection.add(filterdata[i]);
        }
      }
    emit(getinjectionhalltatesuccess(success_message: "success_message"));
  }

  refresorders() {
    myinjection = filterdata;
    emit(getinjectionhalltatesuccess(success_message: "success_message"));
  }

  resetordernumber() {
    ordername = "اختر الاوردر";
    emit(cahngeorder());
  }

// ignore: non_constant_identifier_names
  orderchange(String val) {
    ordername = val;
    emit(cahngeorder());
  }

  refreshdata() {
    myinjection = filterdata;
    emit(getinjectionhalltatesuccess(success_message: "success_message"));
  }
}
