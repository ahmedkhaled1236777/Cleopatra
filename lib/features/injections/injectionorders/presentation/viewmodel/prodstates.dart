// ignore: camel_case_types
abstract class injectionhalltates {}

class injectiontateintial extends injectionhalltates {}
class changeorderspruestate extends injectionhalltates {}

class updateorderloading extends injectionhalltates {}

class updateordersuccess extends injectionhalltates {
  final String successmessage;

  updateordersuccess({required this.successmessage});
}

class updateorderfailure extends injectionhalltates {
  final String errormessage;

  updateorderfailure({required this.errormessage});
}

class injectionsearchsucess extends injectionhalltates {}

class injectionsearchloading extends injectionhalltates {}

class injectionsearchfailure extends injectionhalltates {}

class changetextformstate extends injectionhalltates {}

class changechecboxstate extends injectionhalltates {}

class cahngeorder extends injectionhalltates {}

// ignore: camel_case_types
class deleteinjectionhalltateloadind extends injectionhalltates {}

// ignore: camel_case_types
class deleteinjectionhalltatesuccess extends injectionhalltates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deleteinjectionhalltatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deleteinjectionhalltatefailure extends injectionhalltates {
  final String error_message;

  deleteinjectionhalltatefailure({required this.error_message});
}

class getinjectionhalltateloading extends injectionhalltates {}

class getinjectionhalltatesuccess extends injectionhalltates {
  final String success_message;

  getinjectionhalltatesuccess({required this.success_message});
}

class getinjectionhalltatefailure extends injectionhalltates {
  final String error_message;

  getinjectionhalltatefailure({required this.error_message});
}

class injectionhalltateloading extends injectionhalltates {}

class injectionhalltatesuccess extends injectionhalltates {
  final String success_message;

  injectionhalltatesuccess({required this.success_message});
}

class injectionhalltatefailure extends injectionhalltates {
  final String error_message;

  injectionhalltatefailure({required this.error_message});
}
