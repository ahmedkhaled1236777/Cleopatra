
abstract class moldusagesState {}
 class moldusagesInitial extends moldusagesState {}
 class changemoldusage extends moldusagesState {}
 class searchformoldusage extends moldusagesState {}
 class editmoldusageloading extends moldusagesState {}
 class editmoldusagesuccess extends moldusagesState {
  final String success_message;

  editmoldusagesuccess({required this.success_message});
 }
 class editmoldusagefailure extends moldusagesState {
  final String error_message;

  editmoldusagefailure({required this.error_message});
 }
 class changetypestate extends moldusagesState {}
 class addmoldusageloading extends moldusagesState {}
 class addmoldusagesuccess extends moldusagesState {
  final String success_message;

  addmoldusagesuccess({required this.success_message});
 }
 class addmoldusagefailure extends moldusagesState {
  final String error_message;

  addmoldusagefailure({required this.error_message});
 }
 class getmoldusageloading extends moldusagesState {}
 class getmoldusagesuccess extends moldusagesState {
  final String success_message;

  getmoldusagesuccess({required this.success_message});
 }
 class getmoldusagefailure extends moldusagesState {
  final String error_message;

  getmoldusagefailure({required this.error_message});
 }

