import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';
import 'package:cleopatra/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/showemployeecuibt/employeestates.dart';

class showemployeescuibt extends Cubit<showemployeesstates> {
  final emplyeerepoimplementaion employeerepo;
  showemployeescuibt({required this.employeerepo})
      : super(showemployeesintial());
  List<Signmodelrequest> employeesdata = [];
  List<Signmodelrequest> filterdata = [];

  getallemployees() async {
    emit(showemployeesloading());
    var result = await employeerepo.getemployees();
    result.fold((l) {
      emit(showemployeesfailure(error_message: l.error_message));
    }, (r) {
      employeesdata.clear();
      filterdata.clear();
      employeesdata.addAll(r);
      filterdata.addAll(r);
      emit(showemployeessuccess());
    });
  }

  deleteemployee({required String EMAIL}) async {
    emit(deleteemployeeloading());
    var result = await employeerepo.deleteemployee(EMAIL: EMAIL);
    result.fold((failure) {
      emit(deleteemployeefailure(errormessage: failure.error_message));
    }, (success) {
      employeesdata.removeWhere((element) => element.email == EMAIL);
      emit(deleteemployeesuccess(succes_message: success));
    });
  }

  fileralldata() {
    employeesdata.clear();
    employeesdata.addAll(filterdata);
  }

  searchforemployee(String phone) {
    if (phone.isNotEmpty) {
      employeesdata.removeWhere((element) => element.phone != phone);
    }

    emit(deleteemployeesuccess(succes_message: ""));
  }
}
