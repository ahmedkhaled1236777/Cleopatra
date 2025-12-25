

abstract class InjectionmachinesState {}
 class updateInjectionmachineloading extends InjectionmachinesState {}

 class InjectionmachinesInitial extends InjectionmachinesState {}
 class updateInjectionmachinesuccess extends InjectionmachinesState {
  final String success_message;

  updateInjectionmachinesuccess({required this.success_message});
 }
 class updateInjectionmachinefailure extends InjectionmachinesState {
  final String error_message;

  updateInjectionmachinefailure({required this.error_message});
 }
  class deleteInjectionmachineloading extends InjectionmachinesState {}
 class deleteInjectionmachinesuccess extends InjectionmachinesState {
  final String success_message;

  deleteInjectionmachinesuccess({required this.success_message});
 }
 class deleteInjectionmachinefailure extends InjectionmachinesState {
  final String error_message;

  deleteInjectionmachinefailure({required this.error_message});
 }
 class addInjectionmachineloading extends InjectionmachinesState {}
 class addInjectionmachinesuccess extends InjectionmachinesState {
  final String success_message;

  addInjectionmachinesuccess({required this.success_message});
 }
 class addInjectionmachinefailure extends InjectionmachinesState {
  final String error_message;

  addInjectionmachinefailure({required this.error_message});
 }
 class getInjectionmachineloading extends InjectionmachinesState {}
 class getInjectionmachinesuccess extends InjectionmachinesState {
  final String success_message;

  getInjectionmachinesuccess({required this.success_message});
 }
 class getInjectionmachinefailure extends InjectionmachinesState {
  final String error_message;

  getInjectionmachinefailure({required this.error_message});
 }

