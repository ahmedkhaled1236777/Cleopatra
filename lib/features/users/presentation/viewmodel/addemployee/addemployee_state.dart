part of 'addemployee_cubit.dart';

abstract class AddemployeeState {}

class AddemployeeInitial extends AddemployeeState {}

class changeprofileimage extends AddemployeeState {}

class resetdatastate extends AddemployeeState {}

class updateemployeeloading extends AddemployeeState {}

class changestatusstate extends AddemployeeState {}

class updateemployeesuccess extends AddemployeeState {
  final String succes_message;

  updateemployeesuccess({required this.succes_message});
}

class updateemployeefailure extends AddemployeeState {
  final String errormessage;

  updateemployeefailure({required this.errormessage});
}

class Addemployeeloading extends AddemployeeState {}

class Addemployeesuccess extends AddemployeeState {
  final String succes_message;

  Addemployeesuccess({required this.succes_message});
}

class Addemployeefailure extends AddemployeeState {
  final String error_message;

  Addemployeefailure({required this.error_message});
}
