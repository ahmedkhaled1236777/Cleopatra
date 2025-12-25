import 'package:bloc/bloc.dart';

import 'package:cleopatra/features/injections/injectionworkers/data/model/injectioworkermodel.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_state.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/repos/injectionworkerrepoimp.dart';


class InjectionworkersCubit extends Cubit<InjectionworkersState> {
  InjectionworkersCubit(this.injectionworkerrepoimp) : super(InjectionworkersInitial());
   final Injectionworkerrepoimp injectionworkerrepoimp;
 
List<Injectionworkermodel>injectionworkers=[];
  addinjectionworker({required Injectionworkermodel injectionworker}) async {
    emit(addInjectionworkerloading());
    var result = await injectionworkerrepoimp.addInjectionworker(Injectionworkermodel: injectionworker);
    result.fold((failure) {
      emit(addInjectionworkerfailure(error_message: failure.error_message));
    }, (success) {
      emit(addInjectionworkersuccess(success_message: success));
    });
  }

  getinjectionworkers() async {
    emit(getInjectionworkerloading());
    var result = await injectionworkerrepoimp.getInjectionworkers();
    result.fold((failure) {
      emit(getInjectionworkerfailure(error_message: failure.error_message));
    }, (success) {
      injectionworkers = success;
      emit(getInjectionworkersuccess(success_message: "تم الحصول علي العمال بنجاح"));
    });
  }

  updatinjectionworkers({required Injectionworkermodel injectionworker}) async {
    emit(updateInjectionworkerloading());
    var result = await injectionworkerrepoimp.editInjectionworker(Injectionworkermodel: injectionworker);
    result.fold((failure) {
      emit(updateInjectionworkerfailure(error_message: failure.error_message));
    }, (success) {
     

      emit(updateInjectionworkersuccess(success_message: success));
    });
  }
 deleteinjectionworkers({required Injectionworkermodel injectionworker}) async {
    emit(deleteInjectionworkerloading());
    var result = await injectionworkerrepoimp.deleteInjectionworker(Injectionworkermodel: injectionworker);
    result.fold((failure) {
      emit(deleteInjectionworkerfailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < injectionworkers.length; i++) {
        if (injectionworker.workername ==
            injectionworkers[i].workername) {
          injectionworkers.removeAt(i);

          break;
        }
      }

      emit(deleteInjectionworkersuccess(success_message: success));
    });
  }
  
}
