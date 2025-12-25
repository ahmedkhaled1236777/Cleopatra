import 'package:bloc/bloc.dart';

import 'package:cleopatra/features/injections/injectionmachines/data/model/injectionmachinemodel.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/repos/injectionmachinerepoimp.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_state.dart';


class InjectionmachinesCubit extends Cubit<InjectionmachinesState> {
  InjectionmachinesCubit(this.injectionmachinerepoimp) : super(InjectionmachinesInitial());
   final Injectionmachinerepoimp injectionmachinerepoimp;
 
List<Injectionmachinemodel>injectionmachines=[];
  addinjectionmachine({required Injectionmachinemodel injectionmachine}) async {
    emit(addInjectionmachineloading());
    var result = await injectionmachinerepoimp.addInjectionmachine(Injectionmachinemodel: injectionmachine);
    result.fold((failure) {
      emit(addInjectionmachinefailure(error_message: failure.error_message));
    }, (success) {
      emit(addInjectionmachinesuccess(success_message: success));
    });
  }

  getinjectionmachines() async {
    emit(getInjectionmachineloading());
    var result = await injectionmachinerepoimp.getInjectionmachines();
    result.fold((failure) {
      emit(getInjectionmachinefailure(error_message: failure.error_message));
    }, (success) {
      injectionmachines = success;
      emit(getInjectionmachinesuccess(success_message: "تم الحصول علي الماكينات بنجاح"));
    });
  }

  updatinjectionmachines({required Injectionmachinemodel injectionmachine}) async {
    emit(updateInjectionmachineloading());
    var result = await injectionmachinerepoimp.editInjectionmachine(Injectionmachinemodel: injectionmachine);
    result.fold((failure) {
      emit(updateInjectionmachinefailure(error_message: failure.error_message));
    }, (success) {
     

      emit(updateInjectionmachinesuccess(success_message: success));
    });
  }
 deleteinjectionmachines({required Injectionmachinemodel injectionmachine}) async {
    emit(deleteInjectionmachineloading());
    var result = await injectionmachinerepoimp.deleteInjectionmachine(Injectionmachinemodel: injectionmachine);
    result.fold((failure) {
      emit(deleteInjectionmachinefailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < injectionmachines.length; i++) {
        if (injectionmachine.machinenumber ==
            injectionmachines[i].machinenumber) {
          injectionmachines.removeAt(i);

          break;
        }
      }

      emit(deleteInjectionmachinesuccess(success_message: success));
    });
  }
  
}
