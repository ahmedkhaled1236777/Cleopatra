abstract class showemployeesstates {}

class showemployeesintial extends showemployeesstates {}

class deleteemployeeloading extends showemployeesstates {}

class deleteemployeesuccess extends showemployeesstates {
  final String succes_message;

  deleteemployeesuccess({required this.succes_message});
}

class deleteemployeefailure extends showemployeesstates {
  final String errormessage;

  deleteemployeefailure({required this.errormessage});
}

class showemployeesloading extends showemployeesstates {}

class showemployeessuccess extends showemployeesstates {}

class showemployeesfailure extends showemployeesstates {
  final String error_message;

  showemployeesfailure({required this.error_message});
}
