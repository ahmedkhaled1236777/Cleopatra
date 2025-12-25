import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cleopatra/features/users/data/repos/addemployeerepoimplementation.dart';

import '../../../../auth/login/model/signmodelrequest.dart';

part 'addemployee_state.dart';

class AddemployeeCubit extends Cubit<AddemployeeState> {
  final emplyeerepoimplementaion addemployeerepo;
  AddemployeeCubit({required this.addemployeerepo})
      : super(AddemployeeInitial());
  File? image;
  String? is_active;
  String? manager;
  uploadimage() async {
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage!.path);
      emit(changeprofileimage());
    }
  }

  resetimage() {
    image = null;
    emit(changeprofileimage());
  }

  bool loading = false;
  List headertable = ["اسم الموظف", "الوظيفه", "رقم الهاتف", "تعديل", "الحاله"];

  List<dynamic> selecteditems = [];

  editemployee({required Signmodelrequest employee}) async {
    emit(updateemployeeloading());
    var result = await addemployeerepo.editemployee(employee: employee);
    result.fold(
        (l) => {emit(updateemployeefailure(errormessage: l.error_message))},
        (r) => {emit(updateemployeesuccess(succes_message: r))});
  }

  resetdata() {
    selecteditems = [];
    image = null;
    emit(resetdatastate());
  }

  changestatus(String val) {
    this.is_active = val;
    emit(changestatusstate());
  }

  changemanager(String val) {
    this.manager = val;
    emit(changestatusstate());
  }
}
