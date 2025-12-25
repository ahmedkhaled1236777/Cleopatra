import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/model/workermodel.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/repos/workersrepoimp.dart';
part 'worker_state.dart';

class WorkerCubit extends Cubit<WorkerState> {
  List<Worker> workers = [];
  List<String> myworkers = [];
  List<String> constworkers = [];
  final Workersrepoimp workersrepoimp;
  Map<String, String> codes = {};
  String workername = "اسم العامل";
  WorkerCubit(this.workersrepoimp) : super(WorkerInitial());
  resetworkername() {
    workername = "اسم العامل";
    emit(changeworker());
  }

  addworker({required Worker workermodel}) async {
    emit(AddWorkerloading());
    var result = await workersrepoimp.addworker(Workermodel: workermodel);
    result.fold((failure) {
      emit(AddWorkerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(AddWorkersuccess(successmessage: success));
    });
  }

  deleteworker({required Worker workermodel}) async {
    emit(deleteworkerloading());
    var result = await workersrepoimp.deleteworker(Workermodel: workermodel);
    result.fold((failure) {
      emit(deleteworkerfailure(errormessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < workers.length; i++) {
        if (workers[i].workername == workermodel.workername) {
          workers.removeAt(i);
          myworkers.removeAt(i);

          break;
        }
      }
      emit(deleteworkersuccess(successmessage: success));
    });
  }

  getworkers() async {
    emit(GetWorkersLoading());
    var result = await workersrepoimp.getworkers();
    result.fold((failure) {
      emit(GetWorkersFailure(errormessage: failure.error_message));
    }, (success) {
      workers = success;
      myworkers = [];
      codes = {};
      workers.forEach((e) {
        myworkers.add(e.workername);
        codes.addAll({"${e.workername}": e.code});
      });
      emit(
          GetWorkersSuccess(successmessage: "تم الحصول علي اسامي جميع العمال"));
    });
  }

  workerchange(String val) {
    workername = val;
    emit(changeworker());
  }
}
