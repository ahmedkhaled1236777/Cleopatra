// ignore: camel_case_types
abstract class productionusagetates {}

class productiontateintial extends productionusagetates {}

class resetstatus extends productionusagetates {}

class changetypestate extends productionusagetates {}

// ignore: camel_case_types
class deleteproductionusagetateloadind extends productionusagetates {}

// ignore: camel_case_types
class deleteproductionusagetatesuccess extends productionusagetates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deleteproductionusagetatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deleteproductionusagetatefailure extends productionusagetates {
  final String error_message;

  deleteproductionusagetatefailure({required this.error_message});
}

class getproductionusagetateloading extends productionusagetates {}

class getproductionusagetatesuccess extends productionusagetates {
  final String success_message;

  getproductionusagetatesuccess({required this.success_message});
}

class getproductionusagetatefailure extends productionusagetates {
  final String error_message;

  getproductionusagetatefailure({required this.error_message});
}

class productionusagetateloading extends productionusagetates {}

class productionusagetatesuccess extends productionusagetates {
  final String success_message;

  productionusagetatesuccess({required this.success_message});
}

class productionusagetatefailure extends productionusagetates {
  final String error_message;

  productionusagetatefailure({required this.error_message});
}
