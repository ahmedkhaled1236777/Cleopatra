import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintaveragemodel.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintcyclemodel.dart';
import 'package:cleopatra/features/paints/paintaverage/data/repo/paintaveragerepoimp.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';

class paintaverageCubit extends Cubit<paintaverageState> {
  final paintaveragerepoimp paintaveragerepoi;
  List<paintaveragemodel> paintaverages = [];
  List<paintaveragemodel> paintaverageschecks = [];
  List<String> mypaintaverages = [];
  Map paintaveragerate = {};
  Map paintaveragerateweight = {};
  bool firsttime = true;
  String jobname = "اختر المنتج";
  List<bool> checks = [];
  List<Paintcyclemodel> cycles = [];

  paintaveragechange(String val) {
    jobname = val;
    emit(Changepaintaverage());
  }

  resetpaintaverage() {
    jobname = "اختر المنتج";
    emit(Changepaintaverage());
  }

  paintaverageCubit(this.paintaveragerepoi) : super(paintaverageInitial());
  addpaintaverage({required paintaveragemodel paintaverage}) async {
    emit(AddpaintaverageLoading());
    var result =
        await paintaveragerepoi.addpaintaverage(paintaverage: paintaverage);
    result.fold((failure) {
      emit(AddpaintaverageFailure(failuremessage: failure.error_message));
    }, (success) {
      emit(AddpaintaverageSucess(successmessage: success));
    });
  }

  jobchange(String val) {
    jobname = val;
    emit(changejob());
  }

  update({required paintaveragemodel paintaverage}) async {
    emit(UpdatepaintaverageLoading());
    var result =
        await paintaveragerepoi.updatepaintaverage(paintaverage: paintaverage);
    result.fold((failure) {
      emit(UpdatepaintaverageFailure(errormessage: failure.error_message));
    }, (success) {
      emit(UpdatepaintaverageSuccess(successmessage: success));
    });
  }

  deletepaintaverage({required paintaveragemodel paintaverage}) async {
    emit(Deletepaintaverageloading());
    var result =
        await paintaveragerepoi.deletepaintaverage(paintaverage: paintaverage);
    result.fold((failure) {
      emit(Deletepaintaveragefailure(errormessage: failure.error_message));
    }, (success) {
      emit(DeletepaintaverageSuccess(successmessage: success));
    });
  }

  changechecbox(
      {required bool val,
      required int index,
      required paintaveragemodel paintaverage}) {
    checks[index] = val;
    if (val) {
      paintaverageschecks.add(paintaverage);
    } else {
      paintaverageschecks.remove(paintaverage);
    }

    emit(changechecboxcyclestate());
  }

  getpaintaverages() async {
    if (firsttime) emit(GetpaintaverageLoading());
    var result = await paintaveragerepoi.getpaintaverages();
    result.fold((failure) {
      emit(GetpaintaverageFailure(errormessage: failure.error_message));
    }, (success) {
      checks = [];

      firsttime = false;
      paintaverages = success;
      mypaintaverages = [];
      paintaveragerate = {};
      success.forEach((element) {
        checks.add(false);

        paintaveragerate.addAll({element.job: element.secondsperpiece});
        paintaveragerateweight.addAll({element.job: element.boyaweight});
        mypaintaverages.add(element.job);
      });
      emit(GetpaintaverageSuccess(
          successmessage: "تم الحصول علي جميع المعدلات بنجاح"));
    });
  }
}
