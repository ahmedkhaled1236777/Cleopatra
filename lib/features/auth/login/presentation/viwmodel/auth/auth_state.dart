part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class getprofileloading extends AuthState {}

class getprofilesuccess extends AuthState {
  final String successmessage;

  getprofilesuccess({required this.successmessage});
}

class getprofilefailure extends AuthState {
  final String errormessage;

  getprofilefailure({required this.errormessage});
}

class signuploading extends AuthState {}

class signupsuccess extends AuthState {
  final String suuccessmessage;

  signupsuccess({required this.suuccessmessage});
}

class signupfailure extends AuthState {
  final String errormessage;

  signupfailure({required this.errormessage});
}

class resetpassloading extends AuthState {}

class signoutloading extends AuthState {}

class signoutsuccess extends AuthState {
  final String success_message;

  signoutsuccess({required this.success_message});
}

class signoutfailure extends AuthState {
  final String error_message;

  signoutfailure({required this.error_message});
}

class resetpasssuccess extends AuthState {
  final String success_message;

  resetpasssuccess({required this.success_message});
}

class resetpassfailure extends AuthState {
  final String error_message;

  resetpassfailure({required this.error_message});
}

class loginloading extends AuthState {}

class loginsuccess extends AuthState {
  final Signmodelrequest signmodelrequest;

  loginsuccess({required this.signmodelrequest});
}

class loginfailure extends AuthState {
  final String error_message;

  loginfailure({required this.error_message});
}
