

abstract class qcsState {}
 class updateqcloading extends qcsState {}

 class qcsInitial extends qcsState {}
 class updateqcsuccess extends qcsState {
  final String success_message;

  updateqcsuccess({required this.success_message});
 }
 class updateqcfailure extends qcsState {
  final String error_message;

  updateqcfailure({required this.error_message});
 }
  class deleteqcloading extends qcsState {}
 class deleteqcsuccess extends qcsState {
  final String success_message;

  deleteqcsuccess({required this.success_message});
 }
 class deleteqcfailure extends qcsState {
  final String error_message;

  deleteqcfailure({required this.error_message});
 }
 class addqcloading extends qcsState {}
 class addqcsuccess extends qcsState {
  final String success_message;

  addqcsuccess({required this.success_message});
 }
 class addqcfailure extends qcsState {
  final String error_message;

  addqcfailure({required this.error_message});
 }
 class getqcloading extends qcsState {}
 class getqcsuccess extends qcsState {
  final String success_message;

  getqcsuccess({required this.success_message});
 }
 class getqcfailure extends qcsState {
  final String error_message;

  getqcfailure({required this.error_message});
 }

