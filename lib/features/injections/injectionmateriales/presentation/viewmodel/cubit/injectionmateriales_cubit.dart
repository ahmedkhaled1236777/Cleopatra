import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/model/injectionmaterialmodel.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/repos/injectionmaterialrepoimp.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_state.dart';



class InjectionmaterialsCubit extends Cubit<InjectionmaterialsState> {
  InjectionmaterialsCubit(this.injectionmaterialrepoimp) : super(InjectionmaterialsInitial());
   final Injectionmaterialrepoimp injectionmaterialrepoimp;
 
List<Injectionmaterialmodel>injectionmaterials=[];
  addinjectionmaterial({required Injectionmaterialmodel injectionmaterial}) async {
    emit(addInjectionmaterialloading());
    var result = await injectionmaterialrepoimp.addInjectionmaterial(Injectionmaterialmodel: injectionmaterial);
    result.fold((failure) {
      emit(addInjectionmaterialfailure(error_message: failure.error_message));
    }, (success) {
      emit(addInjectionmaterialsuccess(success_message: success));
    });
  }

  getinjectionmaterials() async {
    emit(getInjectionmaterialloading());
    var result = await injectionmaterialrepoimp.getInjectionmaterials();
    result.fold((failure) {
      emit(getInjectionmaterialfailure(error_message: failure.error_message));
    }, (success) {
      injectionmaterials = success;
      emit(getInjectionmaterialsuccess(success_message: "تم الحصول علي الخامات بنجاح"));
    });
  }

  updatinjectionmaterials({required Injectionmaterialmodel injectionmaterial}) async {
    emit(updateInjectionmaterialloading());
    var result = await injectionmaterialrepoimp.editInjectionmaterial(Injectionmaterialmodel: injectionmaterial);
    result.fold((failure) {
      emit(updateInjectionmaterialfailure(error_message: failure.error_message));
    }, (success) {
     

      emit(updateInjectionmaterialsuccess(success_message: success));
    });
  }
 deleteinjectionmaterials({required Injectionmaterialmodel injectionmaterial}) async {
    emit(deleteInjectionmaterialloading());
    var result = await injectionmaterialrepoimp.deleteInjectionmaterial(Injectionmaterialmodel: injectionmaterial);
    result.fold((failure) {
      emit(deleteInjectionmaterialfailure(error_message: failure.error_message));
    }, (success) {
      for (int i = 0; i < injectionmaterials.length; i++) {
        if (injectionmaterial.materialname ==
            injectionmaterials[i].materialname) {
          injectionmaterials.removeAt(i);

          break;
        }
      }

      emit(deleteInjectionmaterialsuccess(success_message: success));
    });
  }
  
}
