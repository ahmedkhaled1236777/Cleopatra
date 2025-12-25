
abstract class maintenancesState {}
 class maintenancesInitial extends maintenancesState {}
 class editmaintenanceskoading extends maintenancesState {}
 class searcformaintenance extends maintenancesState {}
 class editmaintenancessuccess extends maintenancesState {
  final String success_message;

  editmaintenancessuccess({required this.success_message});
 }
 class editmaintenancesfailure extends maintenancesState {
  final String error_message;

  editmaintenancesfailure({required this.error_message});
 }
 class changemaintenance extends maintenancesState {}
 class deletemaintenanceloading extends maintenancesState {}
 class deletemaintenancesuccess extends maintenancesState {
  final String success_message;

  deletemaintenancesuccess({required this.success_message});
 }
 class deletemaintenancefailure extends maintenancesState {
  final String error_message;

  deletemaintenancefailure({required this.error_message});
 }
 class changetypestate extends maintenancesState {}
 class addmaintenanceloading extends maintenancesState {}
 class addmaintenancesuccess extends maintenancesState {
  final String success_message;

  addmaintenancesuccess({required this.success_message});
 }
 class addmaintenancefailure extends maintenancesState {
  final String error_message;

  addmaintenancefailure({required this.error_message});
 }
 class getmaintenanceloading extends maintenancesState {}
 class getmaintenancesuccess extends maintenancesState {
  final String success_message;

  getmaintenancesuccess({required this.success_message});
 }
 class getmaintenancefailure extends maintenancesState {
  final String error_message;

  getmaintenancefailure({required this.error_message});
 }

