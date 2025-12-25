abstract class paintusagetates {}

class painttateintial extends paintusagetates {}

class resetstatus extends paintusagetates {}

class changetypestate extends paintusagetates {}

// ignore: camel_case_types
class deletepaintusagetateloadind extends paintusagetates {}

// ignore: camel_case_types
class deletepaintusagetatesuccess extends paintusagetates {
  // ignore: non_constant_identifier_names
  final String success_message;

  // ignore: non_constant_identifier_names
  deletepaintusagetatesuccess({required this.success_message});
}

// ignore: camel_case_types
class deletepaintusagetatefailure extends paintusagetates {
  final String error_message;

  deletepaintusagetatefailure({required this.error_message});
}

class getpaintusagetateloading extends paintusagetates {}

class getpaintusagetatesuccess extends paintusagetates {
  final String success_message;

  getpaintusagetatesuccess({required this.success_message});
}

class getpaintusagetatefailure extends paintusagetates {
  final String error_message;

  getpaintusagetatefailure({required this.error_message});
}

class paintusagetateloading extends paintusagetates {}

class paintusagetatesuccess extends paintusagetates {
  final String success_message;

  paintusagetatesuccess({required this.success_message});
}

class paintusagetatefailure extends paintusagetates {
  final String error_message;

  paintusagetatefailure({required this.error_message});
}
