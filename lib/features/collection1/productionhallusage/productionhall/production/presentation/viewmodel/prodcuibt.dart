import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/injections/injection/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodstates.dart';

class productionusagecuibt extends Cubit<productionusagetates> {
  final productionusagerepoimplementation productionrepoimplementatio;
  String type = "لا";

  productionusagecuibt({required this.productionrepoimplementatio})
      : super(productiontateintial());
  List<productionusagemodel> myproduction = [];
  int total = 0;
  resest() {
    type = "لا";
    emit(resetstatus());
  }

  addproduction(
      {required productionusagemodel productionmodel,
      required String docid}) async {
    emit(productionusagetateloading());
    var result = await productionrepoimplementatio.addproduction(
        productionmodel: productionmodel, docid: docid);
    result.fold((failure) {
      emit(productionusagetatefailure(error_message: failure.error_message));
    }, (success) {
      emit(productionusagetatesuccess(success_message: success));
    });
  }

  getproduction({required String docid}) async {
    emit(getproductionusagetateloading());
    var result = await productionrepoimplementatio.getproductions(docid: docid);
    result.fold((failure) {
      emit(getproductionusagetatefailure(error_message: failure.error_message));
    }, (success) {
      total = 0;
      myproduction = success;
      myproduction.forEach((e) {
        total = total + int.parse(e.quantity);
      });

      emit(getproductionusagetatesuccess(
          success_message: "تم الحصول علي البيانات بنجاح"));
    });
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  deleteproduction(
      {required productionusagemodel prduction, required String docid}) async {
    emit(deleteproductionusagetateloadind());
    var result = await productionrepoimplementatio.deleteproduction(
        prduction: prduction, docid: docid);
    result.fold((failure) {
      emit(deleteproductionusagetatefailure(
          error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < myproduction.length; i++) {
        if (myproduction[i].ordernumber == prduction.ordernumber) {
          myproduction.removeAt(i);
          total = total - int.parse(prduction.quantity);

          break;
        }
      }

      emit(deleteproductionusagetatesuccess(success_message: success));
    });
  }

// ignore: non_constant_identifier_names
}
