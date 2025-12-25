sealed class attendanceworkersState {}

class attendanceworkersInitial extends attendanceworkersState {}

class changescannerstate extends attendanceworkersState {}

class getdeviceiploading extends attendanceworkersState {}

class getdeviceipsuccess extends attendanceworkersState {
  final String deviceip;

  getdeviceipsuccess({required this.deviceip});
}

class getdeviceipfailure extends attendanceworkersState {
  final String errormessage;

  getdeviceipfailure({required this.errormessage});
}

class addworkerloading extends attendanceworkersState {}

class changeworkernamestate extends attendanceworkersState {}

class addattendanceworkersuccess extends attendanceworkersState {
  final String successmessage;

  addattendanceworkersuccess({required this.successmessage});
}

class addworkerfailure extends attendanceworkersState {
  final String errormessage;

  addworkerfailure({required this.errormessage});
}

class deleteworkerloading extends attendanceworkersState {}

class deleteattendanceworkersuccess extends attendanceworkersState {
  final String successmessage;

  deleteattendanceworkersuccess({required this.successmessage});
}

class deleteworkerfailure extends attendanceworkersState {
  final String errormessage;

  deleteworkerfailure({required this.errormessage});
}

class getworkerloading extends attendanceworkersState {}

class getattendanceworkersuccess extends attendanceworkersState {
  final String successmessage;

  getattendanceworkersuccess({required this.successmessage});
}

class getworkerfailure extends attendanceworkersState {
  final String errormessage;

  getworkerfailure({required this.errormessage});
}

class getworkermovesloading extends attendanceworkersState {}

class getworkermovessuccess extends attendanceworkersState {
  final String successmessage;

  getworkermovessuccess({required this.successmessage});
}

class getworkermovesfailure extends attendanceworkersState {
  final String errormessage;

  getworkermovesfailure({required this.errormessage});
}

class editworkerloading extends attendanceworkersState {}

class editattendanceworkersuccess extends attendanceworkersState {
  final String successmessage;

  editattendanceworkersuccess({required this.successmessage});
}

class editworkerfailure extends attendanceworkersState {
  final String errormessage;

  editworkerfailure({required this.errormessage});
}
