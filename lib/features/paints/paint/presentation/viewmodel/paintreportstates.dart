// ignore: camel_case_types
abstract class paintreportstates {}

class paintreportintial extends paintreportstates {}

class changechecboxstate extends paintreportstates {}

class addpaintreportloading extends paintreportstates {}

class addpaintreportsuccess extends paintreportstates {
  final String successmessage;

  addpaintreportsuccess({required this.successmessage});
}

class addpaintreportfailure extends paintreportstates {
  final String errormessage;

  addpaintreportfailure({required this.errormessage});
}

class getpaintreportsloading extends paintreportstates {}

class getpaintreportssuccess extends paintreportstates {
  final String successmessage;

  getpaintreportssuccess({required this.successmessage});
}

class getpaintreportsfailure extends paintreportstates {
  final String errormessage;

  getpaintreportsfailure({required this.errormessage});
}

class deletepaintreportloading extends paintreportstates {}

class deletepaintreportsuccess extends paintreportstates {
  final String successmessage;

  deletepaintreportsuccess({required this.successmessage});
}

class deletepaintreportfailure extends paintreportstates {
  final String errormessage;

  deletepaintreportfailure({required this.errormessage});
}
