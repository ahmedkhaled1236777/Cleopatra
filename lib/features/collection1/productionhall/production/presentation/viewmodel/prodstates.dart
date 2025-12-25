// ignore: camel_case_types
abstract class productionhalltates {}

class productiontateintial extends productionhalltates {}

class cahngeorder extends productionhalltates {}

class productionsearchsucess extends productionhalltates {}

class productionsearchloading extends productionhalltates {}

class productionsearchfailure extends productionhalltates {}

class changetextformstate extends productionhalltates {}

class changechecboxstate extends productionhalltates {}

class changeline extends productionhalltates {}

// ignore: camel_case_types
class deleteproductionhalltateloadind extends productionhalltates {}

// ignore: camel_case_types
class deleteproductionhalltatesuccess extends productionhalltates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deleteproductionhalltatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deleteproductionhalltatefailure extends productionhalltates {
  final String error_message;

  deleteproductionhalltatefailure({required this.error_message});
}

class getproductionhalltateloading extends productionhalltates {}

class getproductionhalltatesuccess extends productionhalltates {
  final String success_message;

  getproductionhalltatesuccess({required this.success_message});
}

class getproductionhalltatefailure extends productionhalltates {
  final String error_message;

  getproductionhalltatefailure({required this.error_message});
}

class productionhalltateloading extends productionhalltates {}

class productionhalltatesuccess extends productionhalltates {
  final String success_message;

  productionhalltatesuccess({required this.success_message});
}

class productionhalltatefailure extends productionhalltates {
  final String error_message;

  productionhalltatefailure({required this.error_message});
}
