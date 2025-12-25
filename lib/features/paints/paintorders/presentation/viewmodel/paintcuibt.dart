import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/data/repos/paintrepoimp.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintstate.dart';

class paintcuibt extends Cubit<painttates> {
  final paintrepoimplementation paintrepo;
  String ordername = "اختر الاوردر";
  List<String> orders = [];
  bool firsttime = true;
  Map ordermap = {};
  Map orderquantity = {};
  paintcuibt({required this.paintrepo}) : super(painttateintial());
  List<Paintmodel> mypaintorders = [];
  List<Paintmodel> filterdata = [];
  addpaint({required Paintmodel paint}) async {
    emit(painttateloading());
    var result = await paintrepo.addpaintorder(paint: paint);
    result.fold((failure) {
      emit(painttatefailure(error_message: failure.error_message));
    }, (success) {
      emit(painttatesuccess(success_message: success));
    });
  }

  updateorder({required Paintmodel paint}) async {
    emit(updateorderloading());
    var result = await paintrepo.updateorder(paint: paint);
    result.fold((failure) {
      emit(updateorderfailure(errormessage: failure.error_message));
    }, (success) {
      emit(updateordersuccess(successmessage: success));
    });
  }

  getpaintorders() async {
    if (firsttime) emit(getpainttateloading());
    var result = await paintrepo.getpaintorders();
    result.fold((failure) {
      emit(getpainttatefailure(error_message: failure.error_message));
    }, (success) {
      firsttime = false;
      filterdata = success;
      mypaintorders = success;
      orders = [];
      success.forEach((element) {
        orders.add(element.ordernumber);
        ordermap.addAll({element.ordernumber: element.name});
        orderquantity.addAll({
          element.ordernumber: {
            "actprod": element.actualprod,
            "totalprod": element.quantity,
            "boyacode": element.quantity,
            "warnishcode": element.quantity,
            "prodcode": element.prodcode
          }
        });
      });
      emit(getpainttatesuccess(
          success_message: "تم الحصول علي الاوردرات بنجاح"));
    });
  }

  deletepaintorder({required Paintmodel paint}) async {
    emit(deletepainttateloadind());
    var result = await paintrepo.deletepaint(paint: paint);
    result.fold((failure) {
      emit(deletepainttatefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < filterdata.length; i++) {
        if (filterdata[i].ordernumber == paint.ordernumber) {
          filterdata.removeAt(i);
          orders.removeAt(i);
          break;
        }
      }
      for (int i = 0; i < mypaintorders.length; i++) {
        if (mypaintorders[i].ordernumber == paint.ordernumber) {
          mypaintorders.removeAt(i);

          break;
        }
      }

      emit(deletepainttatesuccess(success_message: success));
    });
  }

  shearchfororder({required String ordernumber}) async {
    mypaintorders = [];
    for (int i = 0; i < filterdata.length; i++) {
      if (ordernumber == filterdata[i].ordernumber) {
        mypaintorders.add(filterdata[i]);
      }
    }

    emit(getpainttatesuccess(success_message: "success_message"));
  }

  refresorders() {
    mypaintorders = filterdata;
    emit(getpainttatesuccess(success_message: "success_message"));
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
    mypaintorders = filterdata;
    emit(getpainttatesuccess(success_message: "success_message"));
  }
}
