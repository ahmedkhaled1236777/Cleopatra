// ignore: camel_case_types
abstract class productiontates {}

class productiontateintial extends productiontates {}

class adddiagnoseloading extends productiontates {}

class getdiagnoseloading extends productiontates {}

class adddiagnosesuccess extends productiontates {
  final String successmessage;

  adddiagnosesuccess({required this.successmessage});
}

class getdiagnosesuccess extends productiontates {
  final String successmessage;

  getdiagnosesuccess({required this.successmessage});
}

class getdiagnosefailure extends productiontates {
  final String errormessage;

  getdiagnosefailure({required this.errormessage});
}

class adddiagnosefailure extends productiontates {
  final String errormessage;

  adddiagnosefailure({required this.errormessage});
}

class getmachinesloading extends productiontates {}

class resetselected extends productiontates {}

class getmachinessuccess extends productiontates {
  final String successmessage;

  getmachinessuccess({required this.successmessage});
}

class getmachinesfailure extends productiontates {
  final String errormessage;

  getmachinesfailure({required this.errormessage});
}

class cahngeorder extends productiontates {}

class deleteorderloading extends productiontates {}

class deleteordersuccess extends productiontates {
  final String successmessage;

  deleteordersuccess({required this.successmessage});
}

class deleteorderfailure extends productiontates {
  final String failuremessage;

  deleteorderfailure({required this.failuremessage});
}

class addorderloading extends productiontates {}

class getorderloading extends productiontates {}

class getordersuccess extends productiontates {
  final String successmessage;

  getordersuccess({required this.successmessage});
}

class getorderfailure extends productiontates {
  final String errormessage;

  getorderfailure({required this.errormessage});
}

class addordersuccess extends productiontates {
  final String successmessage;

  addordersuccess({required this.successmessage});
}

class addorderfailure extends productiontates {
  final String errormessage;

  addorderfailure({required this.errormessage});
}

class changetextformstate extends productiontates {}

class changechecboxstate extends productiontates {}

// ignore: camel_case_types
class deleteproductiontateloadind extends productiontates {}

// ignore: camel_case_types
class deleteproductiontatesuccess extends productiontates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deleteproductiontatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deleteproductiontatefailure extends productiontates {
  final String error_message;

  deleteproductiontatefailure({required this.error_message});
}

class getproductiontateloading extends productiontates {}

class getproductiontatesuccess extends productiontates {
  final String success_message;

  getproductiontatesuccess({required this.success_message});
}

class getproductiontatefailure extends productiontates {
  final String error_message;

  getproductiontatefailure({required this.error_message});
}

class productiontateloading extends productiontates {}

class productiontatesuccess extends productiontates {
  final String success_message;

  productiontatesuccess({required this.success_message});
}

class productiontatefailure extends productiontates {
  final String error_message;

  productiontatefailure({required this.error_message});
}

class DeleteTimerloading extends productiontates {}

class DeleteTimerSuccess extends productiontates {
  final String successmessage;

  DeleteTimerSuccess({required this.successmessage});
}

class DeleteTimerfailure extends productiontates {
  final String errormessage;

  DeleteTimerfailure({required this.errormessage});
}

class AddTimerLoading extends productiontates {}

class AddTimerSucess extends productiontates {
  final String successmessage;

  AddTimerSucess({required this.successmessage});
}

class AddTimerFailure extends productiontates {
  final String failuremessage;

  AddTimerFailure({required this.failuremessage});
}

class GetTimerLoading extends productiontates {}

class changejob extends productiontates {}

class GetTimerSuccess extends productiontates {
  final String successmessage;

  GetTimerSuccess({required this.successmessage});
}

class GetTimerFailure extends productiontates {
  final String errormessage;

  GetTimerFailure({required this.errormessage});
}

class UpdateTimerLoading extends productiontates {}

class UpdateTimerSuccess extends productiontates {
  final String successmessage;

  UpdateTimerSuccess({required this.successmessage});
}

class UpdateTimerFailure extends productiontates {
  final String errormessage;

  UpdateTimerFailure({required this.errormessage});
}
