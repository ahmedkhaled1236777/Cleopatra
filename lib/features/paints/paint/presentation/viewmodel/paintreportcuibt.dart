import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:cleopatra/features/paints/paint/data/repos/paintreportrepoimp.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportstates.dart';

class paintreportcuibt extends Cubit<paintreportstates> {
  final Paintreportrepoimp paintreportrepoimplementatio;

  paintreportcuibt({required this.paintreportrepoimplementatio})
      : super(paintreportintial());
  List<paintreportmodel> mypaintreport = [];
  String ordername = "اختر الاوردر";
  Map timerrate = {};
  bool firsttime = true;
  List<bool> checks = [];

  addpaintreport({required paintreportmodel paintreportmodel}) async {
    emit(addpaintreportloading());
    var result = await paintreportrepoimplementatio.addpaintreport(
        paintreport: paintreportmodel);
    result.fold((failure) {
      emit(addpaintreportfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addpaintreportsuccess(successmessage: success));
    });
  }

  getpaintreport({required String date}) async {
    emit(getpaintreportsloading());
    var result =
        await paintreportrepoimplementatio.getpaintsreports(date: date);
    result.fold((failure) {
      emit(getpaintreportsfailure(errormessage: failure.error_message));
    }, (success) {
      checks = [];
      mypaintreport = success;
      mypaintreport.forEach((e) {
        checks.add(true);
      });

      emit(getpaintreportssuccess(
          successmessage: "تم الحصول علي التقارير بنجاح"));
    });
  }

  deletepaintreport({required paintreportmodel prduction}) async {
    emit(deletepaintreportloading());
    var result = await paintreportrepoimplementatio.deletepaintreport(
        paintreport: prduction);
    result.fold((failure) {
      emit(deletepaintreportfailure(errormessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < mypaintreport.length; i++) {
        if (mypaintreport[i].docid == prduction.docid) {
          mypaintreport.removeAt(i);
          checks.removeAt(i);

          break;
        }
      }

      emit(deletepaintreportsuccess(successmessage: success));
    });
  }

  changechecbox({required bool val, required int index}) {
    checks[index] = val;
    emit(changechecboxstate());
  }

// ignore: non_constant_identifier_names
}
