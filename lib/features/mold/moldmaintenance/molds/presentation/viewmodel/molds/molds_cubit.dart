import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/models/maintenancemodel.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/repos/maintenancerepo.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/maintenancestate.dart';

class maintenancesCubit extends Cubit<maintenancesState> {
  final Maintenancerepoimp maintenancerepo;
  maintenancesCubit(this.maintenancerepo) : super(maintenancesInitial());
  String maintenancename = "اختر الاسطمبه";
  String maintenancestatus = "تحت الصيانه";
  String type = "خارجيه";
  List<maintenancemodel> mymaintenances = [];
  List<maintenancemodel> filtermymaintenances = [];
  String location = "نوع الصيانه";

  maintenancechange(String val) {
    maintenancename = val;
    emit(changemaintenance());
  }

  maintenancechangestatus(String val) {
    maintenancestatus = val;
    emit(changemaintenance());
  }

  changetype({required String value}) {
    type = value;
    emit(changetypestate());
  }

  changetypelocation(String value) {
    location = value;
    emit(changetypestate());
  }

  addmaintenance({required maintenancemodel maintenancemodel}) async {
    emit(addmaintenanceloading());
    var result =
        await maintenancerepo.addmaintenance(moldmodel: maintenancemodel);
    result.fold((failure) {
      emit(addmaintenancefailure(error_message: failure.error_message));
    }, (success) {
      emit(addmaintenancesuccess(success_message: success));
    });
  }

  getmaintenances() async {
    emit(getmaintenanceloading());
    var result = await maintenancerepo.getmaintenance();
    result.fold((failure) {
      emit(getmaintenancefailure(error_message: failure.error_message));
    }, (success) {
      mymaintenances = success;
      filtermymaintenances = success;
      emit(getmaintenancesuccess(
          success_message: "تم الحصول علي الاسطمبات بنجاح"));
    });
  }

  deltemaintenance({required docid}) async {
    emit(deletemaintenanceloading());
    var result = await maintenancerepo.deletemaintenance(docid: docid);
    result.fold((failure) {
      emit(deletemaintenancefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < mymaintenances.length; i++) {
        if (docid ==
            "${mymaintenances[i].godate}-${mymaintenances[i].moldname}-${mymaintenances[i].status}") {
          mymaintenances.removeAt(i);

          break;
        }
      }

      emit(deletemaintenancesuccess(success_message: success));
    });
  }

  editstatus({
    required String docid,
    required String status,
    required String notes,
    required String type,
    String? retrundate,
    required String name,
    required String location,
  }) async {
    emit(editmaintenanceskoading());
    var result = await maintenancerepo.editmentatnce(
        docid: docid,
        status: status,
        type: type,
        notes: notes,
        name: name,
        location: location,
        retrundate: retrundate);
    result.fold((failure) {
      emit(editmaintenancesfailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < mymaintenances.length; i++) {
        if (docid ==
            "${mymaintenances[i].godate}-${mymaintenances[i].moldname}-${mymaintenances[i].type}") {
          mymaintenances[i].status = status;
          mymaintenances[i].notes = notes;
          mymaintenances[i].retrundate = retrundate;
          break;
        }
      }
      emit(editmaintenancessuccess(success_message: success));
    });
  }

  searchmaintenance({String? mold, String? status, String? date}) {
    mymaintenances = [];
    bool is_mold = false;
    bool is_status = false;
    if (mold != null) {
      is_mold = true;
      filtermymaintenances.forEach((e) {
        if (e.moldname == mold) {
          mymaintenances.add(e);
        }
      });
    }
    if (status != null) {
      is_status = true;
      if (is_mold == true) {
        for (int i = 0; i < mymaintenances.length; i++) {
          if (mymaintenances[i].status != status) mymaintenances.removeAt(i);
        }
      } else
        filtermymaintenances.forEach((e) {
          if (e.status == status) {
            mymaintenances.add(e);
          }
        });
    }

    emit(searcformaintenance());
  }

  resetsearch() {
    mymaintenances = filtermymaintenances;
    emit(searcformaintenance());
  }
}
