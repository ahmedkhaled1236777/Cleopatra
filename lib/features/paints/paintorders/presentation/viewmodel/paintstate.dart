// ignore: camel_case_types
abstract class painttates {}

class painttateintial extends painttates {}

class updateorderloading extends painttates {}

class updateordersuccess extends painttates {
  final String successmessage;

  updateordersuccess({required this.successmessage});
}

class updateorderfailure extends painttates {
  final String errormessage;

  updateorderfailure({required this.errormessage});
}

class paintsearchsucess extends painttates {}

class paintsearchloading extends painttates {}

class paintsearchfailure extends painttates {}

class changetextformstate extends painttates {}

class changechecboxstate extends painttates {}

class cahngeorder extends painttates {}

// ignore: camel_case_types
class deletepainttateloadind extends painttates {}

// ignore: camel_case_types
class deletepainttatesuccess extends painttates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deletepainttatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deletepainttatefailure extends painttates {
  final String error_message;

  deletepainttatefailure({required this.error_message});
}

class getpainttateloading extends painttates {}

class getpainttatesuccess extends painttates {
  final String success_message;

  getpainttatesuccess({required this.success_message});
}

class getpainttatefailure extends painttates {
  final String error_message;

  getpainttatefailure({required this.error_message});
}

class painttateloading extends painttates {}

class painttatesuccess extends painttates {
  final String success_message;

  painttatesuccess({required this.success_message});
}

class painttatefailure extends painttates {
  final String error_message;

  painttatefailure({required this.error_message});
}
