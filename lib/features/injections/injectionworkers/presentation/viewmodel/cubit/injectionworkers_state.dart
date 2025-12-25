

abstract class InjectionworkersState {}
 class updateInjectionworkerloading extends InjectionworkersState {}

 class InjectionworkersInitial extends InjectionworkersState {}
 class updateInjectionworkersuccess extends InjectionworkersState {
  final String success_message;

  updateInjectionworkersuccess({required this.success_message});
 }
 class updateInjectionworkerfailure extends InjectionworkersState {
  final String error_message;

  updateInjectionworkerfailure({required this.error_message});
 }
  class deleteInjectionworkerloading extends InjectionworkersState {}
 class deleteInjectionworkersuccess extends InjectionworkersState {
  final String success_message;

  deleteInjectionworkersuccess({required this.success_message});
 }
 class deleteInjectionworkerfailure extends InjectionworkersState {
  final String error_message;

  deleteInjectionworkerfailure({required this.error_message});
 }
 class addInjectionworkerloading extends InjectionworkersState {}
 class addInjectionworkersuccess extends InjectionworkersState {
  final String success_message;

  addInjectionworkersuccess({required this.success_message});
 }
 class addInjectionworkerfailure extends InjectionworkersState {
  final String error_message;

  addInjectionworkerfailure({required this.error_message});
 }
 class getInjectionworkerloading extends InjectionworkersState {}
 class getInjectionworkersuccess extends InjectionworkersState {
  final String success_message;

  getInjectionworkersuccess({required this.success_message});
 }
 class getInjectionworkerfailure extends InjectionworkersState {
  final String error_message;

  getInjectionworkerfailure({required this.error_message});
 }

