import 'package:bloc/bloc.dart';
import 'package:cleopatra/features/collection1/components/data/models/componentmodel.dart';
import 'package:cleopatra/features/collection1/components/data/models/subcomponent.dart';
import 'package:cleopatra/features/collection1/components/data/repos/componentsrepoimp.dart';

part 'components_state.dart';

class componentCubit extends Cubit<componentState> {
  String prodname = "اختر المنتج";

  bool firstime = false;
  final Componentsrepoimp componentrepoimplementation;
  List<componentsmodel> components = [];
  List<Subcomponent> subcomponents = [];
  List<componentsmodel> filtercomponents = [];
  List<String> compenantsnames = [];
  componentCubit(this.componentrepoimplementation) : super(componentInitial());
  addcomponent({required componentsmodel component}) async {
    emit(addcomponentloading());
    var result =
        await componentrepoimplementation.addcomponent(component: component);
    result.fold((failure) {
      emit(addcomponentfailure());
    }, (success) {
      emit(addcomponentsuccess());
    });
  }

  addsubcomponent(
      {required Subcomponent component, required String componentname}) async {
    emit(addsubcomponentloading());
    var result = await componentrepoimplementation.addsubcomponent(
        subcomponet: component, componentname: componentname);
    result.fold((failure) {
      emit(addsubcomponentfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addsubcomponentsuccess(successmessage: success));
    });
  }

  deletesubcomponent(
      {required Subcomponent component, required String componentname}) async {
    emit(deletesubcomponentloading());
    var result = await componentrepoimplementation.deletesubcomponent(
        subcomponet: component, componentname: componentname);
    result.fold((failure) {
      emit(deletesubcomponentfailure(errormessage: failure.error_message));
    }, (success) {
      emit(deletesubcomponentsuccess(successmessage: success));
    });
  }

  getcomponents() async {
    emit(componentloading());
    var result = await componentrepoimplementation.getcomponents();
    result.fold((failure) {
      emit(componentfailure(error_message: failure.error_message));
    }, (success) {
      compenantsnames = [];
      components = success;
      filtercomponents = success;
      success.forEach((e) {
        compenantsnames.add(e.name);
      });
      emit(componentsuccess(success_message: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getcsubomponents({required String componentname}) async {
    emit(getsubcomponentloadding());
    var result = await componentrepoimplementation.getsubcomponents(
        componentname: componentname);
    result.fold((failure) {
      emit(getsubcomponentfailure(errormessage: failure.error_message));
    }, (success) {
      subcomponents = success;

      emit(getsubcomponentsuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  editcomponents(
      {required int quantaity,
      required String docid,
      required bool type}) async {
    emit(editcomponentloading());
    var result = await componentrepoimplementation.editcomponent(
        quantaity: quantaity, docid: docid, type: type);
    result.fold((failure) {
      emit(editcomponentfailure(error_message: failure.error_message));
    }, (success) {
      components.forEach(
        (element) {
          if (element.name == docid) {
            element.quantity = element.quantity + (quantaity);
          }
        },
      );
      emit(editcomponentsuccess(success_message: "تم تعديل البيانات بنجاح"));
    });
  }

  prodchange(String val) {
    prodname = val;
    emit(changeprodname());
  }

  search({required String name}) {
    components = [];
    for (int i = 0; i < filtercomponents.length; i++) {
      if (filtercomponents[i].name == name) {
        components.add(filtercomponents[i]);
        break;
      }
    }
    emit(componentsuccess(success_message: "تم الحصول علي البيانات بنجاح"));
  }

  resetcomponents() {
    components = filtercomponents;
    emit(componentsuccess(success_message: "تم الحصول علي البيانات بنجاح"));
  }
}
