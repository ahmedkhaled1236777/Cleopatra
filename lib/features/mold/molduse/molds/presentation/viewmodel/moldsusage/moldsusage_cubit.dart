import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/repos/moldrepoimp.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_state.dart';

class moldusagesCubit extends Cubit<moldusagesState> {
  final moldusagerepoimp moldusagerepo;
  moldusagesCubit(this.moldusagerepo) : super(moldusagesInitial());
  String moldusagename = "اختر الاسطمبه";
  List<moldusagemodel> mymoldusages = [];
  List<moldusagemodel> filtermymoldusages = [];

  addmoldusage({required moldusagemodel moldusagemodel}) async {
    emit(addmoldusageloading());
    var result = await moldusagerepo.addmoldusage(moldmodel: moldusagemodel);
    result.fold((failure) {
      emit(addmoldusagefailure(error_message: failure.error_message));
    }, (success) {
      emit(addmoldusagesuccess(success_message: success));
    });
  }
  editmoldusage({required moldusagemodel moldusagemodel}) async {
    emit(editmoldusageloading());
    var result = await moldusagerepo.editmoldusage(moldmodel: moldusagemodel);
    result.fold((failure) {
      emit(editmoldusagefailure(error_message: failure.error_message));
    }, (success) {
      emit(editmoldusagesuccess(success_message: success));
    });
  }

  getmoldusages() async {
    emit(getmoldusageloading());
    var result = await moldusagerepo.getmoldusages();
    result.fold((failure) {
      emit(getmoldusagefailure(error_message: failure.error_message));
    }, (success) {
      mymoldusages = success;
      filtermymoldusages = success;
     
      emit(getmoldusagesuccess(
          success_message: "تم الحصول علي الاسطمبات بنجاح"));
    });
  }

  moldusagechange(String val) {
    moldusagename = val;
    emit(changemoldusage());
  }

  resetsearch() {
    mymoldusages = filtermymoldusages;
    emit(getmoldusagesuccess(success_message: "تم الحصول علي الاسطمبات بنجاح"));
  }

  searchmold({required String moldname}) {
    mymoldusages = [];
    filtermymoldusages.forEach((e) {
      if (e.moldname == moldname) {
        mymoldusages.add(e);
      }
    });
    emit(getmoldusagesuccess(success_message: "تم الحصول علي الاسطمبات بنجاح"));
  }
}
