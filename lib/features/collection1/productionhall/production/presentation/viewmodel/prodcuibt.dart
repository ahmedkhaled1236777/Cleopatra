import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodstates.dart';

class productionhallcuibt extends Cubit<productionhalltates> {
  final productionhallrepoimplementation productionrepoimplementatio;
  String linename = "اختر الخط";
  bool firsttime = true;

  List<String> lines = [
    "A",
    "B",
    "C",
    "D",
  ];
  String ordername = "اختر الاوردر";
  resetordernumber() {
    ordername = "اختر الاوردر";
    emit(cahngeorder());
  }

// ignore: non_constant_identifier_names
  orderchange(String val) {
    ordername = val;
    emit(cahngeorder());
  }

  List<String> orders = [];
  Map<String, dynamic> orderscode = {};
  productionhallcuibt({required this.productionrepoimplementatio})
      : super(productiontateintial());
  List<productionhallmodel> myproduction = [];
  List<productionhallmodel> filterdata = [];
  addproduction({required productionhallmodel productionmodel}) async {
    emit(productionhalltateloading());
    var result = await productionrepoimplementatio.addproduction(
        productionmodel: productionmodel);
    result.fold((failure) {
      emit(productionhalltatefailure(error_message: failure.error_message));
    }, (success) {
      emit(productionhalltatesuccess(success_message: success));
    });
  }

  getproduction({required bool status}) async {
    emit(getproductionhalltateloading());
    var result =
        await productionrepoimplementatio.getproductions(status: status);
    result.fold((failure) {
      emit(getproductionhalltatefailure(error_message: failure.error_message));
    }, (success) {
      filterdata = success;
      myproduction = success;
      orders = [];
      firsttime = false;
      success.forEach(
        (element) {
          orders.add(element.ordernumber);
          orderscode.addAll({element.ordernumber: element.code});
        },
      );
      emit(getproductionhalltatesuccess(
          success_message: "تم الحصول علي الاوردرات بنجاح"));
    });
  }

  deleteproduction({required productionhallmodel prduction}) async {
    emit(deleteproductionhalltateloadind());
    var result = await productionrepoimplementatio.deleteproduction(
        prduction: prduction);
    result.fold((failure) {
      emit(deleteproductionhalltatefailure(
          error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < filterdata.length; i++) {
        if (filterdata[i].ordernumber == prduction.ordernumber) {
          filterdata.removeAt(i);

          break;
        }
      }
      for (int i = 0; i < myproduction.length; i++) {
        if (myproduction[i].ordernumber == prduction.ordernumber) {
          myproduction.removeAt(i);

          break;
        }
      }

      emit(deleteproductionhalltatesuccess(success_message: success));
    });
  }

  shearchforproduction(
      {String? ordernumber,
      String? datefrom,
      String? dateto,
      String? line}) async {
    emit(productionsearchloading());
    myproduction = [];
    bool linee = false;
    bool order = false;
    bool date = false;
    if (datefrom != null && dateto != null) {
      date = true;
      filterdata.forEach((element) {
        if (((DateTime.parse(element.date)
                    .isAtSameMomentAs(DateTime.parse(datefrom)) ||
                DateTime.parse(element.date)
                    .isAfter(DateTime.parse(datefrom)))) &&
            ((DateTime.parse(element.date)
                    .isAtSameMomentAs(DateTime.parse(dateto)) ||
                DateTime.parse(element.date)
                    .isBefore(DateTime.parse(dateto))))) {
          myproduction.add(element);
        }
      });
    }
    if (line != null) {
      if (date == true) {
        for (int i = 0; i < myproduction.length; i++) {
          if (line != myproduction[i].line) {
            myproduction.removeAt(i);
          }
        }
      } else
        filterdata.forEach((element) {
          if (line == element.line) {
            myproduction.add(element);
          }
        });
    }
    if (ordernumber != null) {
      if (linee == true || date == true) {
        for (int i = 0; i < myproduction.length; i++) {
          if (ordernumber != myproduction[i].ordernumber) {
            myproduction.removeAt(i);
          }
        }
      } else
        filterdata.forEach((element) {
          if (ordernumber == element.ordernumber) {
            myproduction.add(element);
          }
        });
    }

    emit(getproductionhalltatesuccess(success_message: "success_message"));
  }

// ignore: non_constant_identifier_names
  linechange(String val) {
    linename = val;
    emit(changeline());
  }

  refreshdata() {
    myproduction = filterdata;
    emit(getproductionhalltatesuccess(success_message: "success_message"));
  }
}
