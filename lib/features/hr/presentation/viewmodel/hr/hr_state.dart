part of 'hr_cubit.dart';

abstract class HrState {}

class HrInitial extends HrState {}

class changewaitingstatus extends HrState {}

class addfullholidayloading extends HrState {}

class addfullholidaysuccess extends HrState {
  final String successmessage;

  addfullholidaysuccess({required this.successmessage});
}

class addfullholidayfailure extends HrState {
  final String errormessage;

  addfullholidayfailure({required this.errormessage});
}

class addabsenseloading extends HrState {}

class addcutloading extends HrState {}

class addabsensesucess extends HrState {
  final String successmessage;

  addabsensesucess({required this.successmessage});
}

class addcutsuccess extends HrState {
  final String successmessage;

  addcutsuccess({required this.successmessage});
}

class addabsensefailure extends HrState {
  final String errormessage;

  addabsensefailure({required this.errormessage});
}

class addcutfailure extends HrState {
  final String errormessage;

  addcutfailure({required this.errormessage});
}

class getallattendanceloading extends HrState {}

class deletewaitingsloading extends HrState {}

class deletewaitingssuccess extends HrState {
  final String successmessage;

  deletewaitingssuccess({required this.successmessage});
}

class deletewaitingsfailure extends HrState {
  final String errormessage;

  deletewaitingsfailure({required this.errormessage});
}

class getallwaitingsloading extends HrState {}

class getwaitingssuccess extends HrState {
  final String successmessage;

  getwaitingssuccess({required this.successmessage});
}

class getwaitingsfailure extends HrState {
  final String errormesaage;

  getwaitingsfailure({required this.errormesaage});
}

class getallattendancesuccess extends HrState {
  final String successmessage;

  getallattendancesuccess({required this.successmessage});
}

class getallattendancefailure extends HrState {
  final String errormessage;

  getallattendancefailure({required this.errormessage});
}
