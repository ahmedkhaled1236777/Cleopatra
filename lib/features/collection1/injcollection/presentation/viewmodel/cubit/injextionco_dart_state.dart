part of 'injextionco_dart_cubit.dart';

abstract class InjextioncoDartState {}

class InjextioncoDartInitial extends InjextioncoDartState {}

class followordersloading extends InjextioncoDartState {}

class followorderssuccess extends InjextioncoDartState {
  final String successmessage;

  followorderssuccess({required this.successmessage});
}

class followordersfailure extends InjextioncoDartState {
  final String errormessage;

  followordersfailure({required this.errormessage});
}

class UpdateInjextioncoDartloading extends InjextioncoDartState {}

class UpdateInjextioncoDartsuccess extends InjextioncoDartState {
  final String successmessage;

  UpdateInjextioncoDartsuccess({required this.successmessage});
}

class UpdateInjextioncoDartfailure extends InjextioncoDartState {
  final String errormessage;

  UpdateInjextioncoDartfailure({required this.errormessage});
}

class getworkercodataloading extends InjextioncoDartState {}

class getworkercodatasuccess extends InjextioncoDartState {
  final String successmessage;

  getworkercodatasuccess({required this.successmessage});
}

class getworkercodatafailure extends InjextioncoDartState {
  final String errorrmessage;

  getworkercodatafailure({required this.errorrmessage});
}

class Injextioncworkersloading extends InjextioncoDartState {}

class Injextioncworkerssuccess extends InjextioncoDartState {
  final String successmessage;

  Injextioncworkerssuccess({required this.successmessage});
}

class Injextioncworkersfailure extends InjextioncoDartState {
  final String errormessage;

  Injextioncworkersfailure({required this.errormessage});
}

class changetypestate extends InjextioncoDartState {}

class editinjectioncoloading extends InjextioncoDartState {}

class editinjectioncosuccess extends InjextioncoDartState {
  final String successmessage;

  editinjectioncosuccess({required this.successmessage});
}

class editinjectioncofailure extends InjextioncoDartState {
  final String errormessage;

  editinjectioncofailure({required this.errormessage});
}

class deleteinjectioncoloading extends InjextioncoDartState {}

class deleteinjectioncofailure extends InjextioncoDartState {
  final String errormessage;

  deleteinjectioncofailure({required this.errormessage});
}

class deleteinjectioncosuccess extends InjextioncoDartState {
  final String successmessage;

  deleteinjectioncosuccess({required this.successmessage});
}

class getinjectioncoloading extends InjextioncoDartState {}

class getinjectioncosuccess extends InjextioncoDartState {
  final String successmessage;

  getinjectioncosuccess({required this.successmessage});
}

class getinjectioncofailure extends InjextioncoDartState {
  final String errormessage;

  getinjectioncofailure({required this.errormessage});
}

class addinjectioncoloading extends InjextioncoDartState {}

class addinjectioncosuccess extends InjextioncoDartState {
  final String successmessage;

  addinjectioncosuccess({required this.successmessage});
}

class addinjectioncofailure extends InjextioncoDartState {
  final String errormessage;

  addinjectioncofailure({required this.errormessage});
}
