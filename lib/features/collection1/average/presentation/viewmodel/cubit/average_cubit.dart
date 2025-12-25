import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';
import 'package:cleopatra/features/collection1/average/data/model/cyclemodel.dart';
import 'package:cleopatra/features/collection1/average/data/repo/averagerepoimp.dart';

part 'average_state.dart';

class AverageCubit extends Cubit<AverageState> {
  final Averagerepoimp averagerepoimp;
  List<averagemodel> averages = [];
  List<averagemodel> averageschecks = [];
  List<String> myaverages = [];
  Map averagerate = {};
  Map<String, double> averagerateprice = {};
  bool firsttime = true;
  String jobname = "اختر الوظيفه";
  List<bool> checks = [];
  List<cyclemodel> cycles = [];

  averagechange(String val) {
    jobname = val;
    emit(ChangeAverage());
  }

  resetaverage() {
    jobname = "اختر الوظيفه";
    emit(ChangeAverage());
  }

  AverageCubit(this.averagerepoimp) : super(AverageInitial());
  addaverage({required averagemodel average}) async {
    emit(AddAverageLoading());
    var result = await averagerepoimp.addaverage(average: average);
    result.fold((failure) {
      emit(AddAverageFailure(failuremessage: failure.error_message));
    }, (success) {
      emit(AddAverageSucess(successmessage: success));
    });
  }

  jobchange(String val) {
    jobname = val;
    emit(changejob());
  }

  update({required averagemodel average}) async {
    emit(UpdateAverageLoading());
    var result = await averagerepoimp.updateaverage(average: average);
    result.fold((failure) {
      emit(UpdateAverageFailure(errormessage: failure.error_message));
    }, (success) {
      emit(UpdateAverageSuccess(successmessage: success));
    });
  }

  deleteaverage({required averagemodel average}) async {
    emit(DeleteAverageloading());
    var result = await averagerepoimp.deleteaverage(average: average);
    result.fold((failure) {
      emit(DeleteAveragefailure(errormessage: failure.error_message));
    }, (success) {
      emit(DeleteAverageSuccess(successmessage: success));
    });
  }

  changechecbox(
      {required bool val, required int index, required averagemodel average}) {
    checks[index] = val;
    if (val) {
      averageschecks.add(average);
    } else {
      averageschecks.remove(average);
    }

    emit(changechecboxcyclestate());
  }

  getaverages() async {
    if (firsttime) emit(GetAverageLoading());
    var result = await averagerepoimp.getaverages();
    result.fold((failure) {
      emit(GetAverageFailure(errormessage: failure.error_message));
    }, (success) {
      checks = [];

      firsttime = false;
      averages = success;
      myaverages = [];
      averagerate = {};
      averages.forEach((element) {
        checks.add(false);

        averagerate.addAll({"${element.job}": element.secondsperpiece});
        averagerateprice
            .addAll({"${element.job}": double.parse(element.prieceofpiece)});
        myaverages.add(element.job);
      });
      emit(GetAverageSuccess(
          successmessage: "تم الحصول علي جميع المعدلات بنجاح"));
    });
  }
}
