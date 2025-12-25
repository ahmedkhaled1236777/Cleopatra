import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodelusage.dart';
import 'package:cleopatra/features/paints/paintorders/data/repos/paintrepoimp.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagestate.dart';

class paintusagecuibt extends Cubit<paintusagetates> {
  final paintrepoimplementation paintrepoimplementatio;
  String type = "لا";

  paintusagecuibt({required this.paintrepoimplementatio})
      : super(painttateintial());
  List<paintusagemodel> mypaint = [];
  int total = 0;
  double totalboya = 0;
  int totalscrap = 0;
  resest() {
    type = "لا";
    emit(resetstatus());
  }

  addpaint({required paintusagemodel paintmodel, required String docid}) async {
    emit(paintusagetateloading());
    var result = await paintrepoimplementatio.addpaintsub(
        paint: paintmodel, docid: docid);
    result.fold((failure) {
      emit(paintusagetatefailure(error_message: failure.error_message));
    }, (success) {
      emit(paintusagetatesuccess(success_message: success));
    });
  }

  getpaint({required String docid}) async {
    emit(getpaintusagetateloading());
    var result = await paintrepoimplementatio.getsubpaints(docid: docid);
    result.fold((failure) {
      emit(getpaintusagetatefailure(error_message: failure.error_message));
    }, (success) {
      total = 0;
      totalscrap = 0;
      totalboya = 0;
      mypaint = success;
      mypaint.forEach((e) {
        total = total + e.quantity;
        totalscrap = totalscrap + e.paintscrapquantity;

        totalboya = totalboya + double.parse(e.boyaquantity);
      });

      emit(getpaintusagetatesuccess(
          success_message: "تم الحصول علي البيانات بنجاح"));
    });
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  deletepaints({required paintusagemodel paint, required String docid}) async {
    emit(deletepaintusagetateloadind());
    var result = await paintrepoimplementatio.deletesubpaints(
        paint: paint, docid: docid);
    result.fold((failure) {
      emit(deletepaintusagetatefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < mypaint.length; i++) {
        if (mypaint[i].ordernumber == paint.ordernumber) {
          mypaint.removeAt(i);
          total = total - paint.quantity;

          break;
        }
      }

      emit(deletepaintusagetatesuccess(success_message: success));
    });
  }

// ignore: non_constant_identifier_names
}
