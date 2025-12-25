

abstract class InjectionmaterialsState {}
 class updateInjectionmaterialloading extends InjectionmaterialsState {}

 class InjectionmaterialsInitial extends InjectionmaterialsState {}
 class updateInjectionmaterialsuccess extends InjectionmaterialsState {
  final String success_message;

  updateInjectionmaterialsuccess({required this.success_message});
 }
 class updateInjectionmaterialfailure extends InjectionmaterialsState {
  final String error_message;

  updateInjectionmaterialfailure({required this.error_message});
 }
  class deleteInjectionmaterialloading extends InjectionmaterialsState {}
 class deleteInjectionmaterialsuccess extends InjectionmaterialsState {
  final String success_message;

  deleteInjectionmaterialsuccess({required this.success_message});
 }
 class deleteInjectionmaterialfailure extends InjectionmaterialsState {
  final String error_message;

  deleteInjectionmaterialfailure({required this.error_message});
 }
 class addInjectionmaterialloading extends InjectionmaterialsState {}
 class addInjectionmaterialsuccess extends InjectionmaterialsState {
  final String success_message;

  addInjectionmaterialsuccess({required this.success_message});
 }
 class addInjectionmaterialfailure extends InjectionmaterialsState {
  final String error_message;

  addInjectionmaterialfailure({required this.error_message});
 }
 class getInjectionmaterialloading extends InjectionmaterialsState {}
 class getInjectionmaterialsuccess extends InjectionmaterialsState {
  final String success_message;

  getInjectionmaterialsuccess({required this.success_message});
 }
 class getInjectionmaterialfailure extends InjectionmaterialsState {
  final String error_message;

  getInjectionmaterialfailure({required this.error_message});
 }

