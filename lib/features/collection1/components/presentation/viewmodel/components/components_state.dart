part of 'components_cubit.dart';

abstract class componentState {}

class componentInitial extends componentState {}

class deletesubcomponentloading extends componentState {}

class deletesubcomponentsuccess extends componentState {
  final String successmessage;

  deletesubcomponentsuccess({required this.successmessage});
}

class deletesubcomponentfailure extends componentState {
  final String errormessage;

  deletesubcomponentfailure({required this.errormessage});
}

class changeprodname extends componentState {}

class addcomponentloading extends componentState {}

class editcomponentloading extends componentState {}

class editcomponentsuccess extends componentState {
  final String success_message;

  editcomponentsuccess({required this.success_message});
}

class editcomponentfailure extends componentState {
  final String error_message;

  editcomponentfailure({required this.error_message});
}

class addcomponentsuccess extends componentState {}

class addsubcomponentsuccess extends componentState {
  final String successmessage;

  addsubcomponentsuccess({required this.successmessage});
}

class addsubcomponentfailure extends componentState {
  final String errormessage;

  addsubcomponentfailure({required this.errormessage});
}

class addsubcomponentloading extends componentState {}

class getsubcomponentloadding extends componentState {}

class getsubcomponentsuccess extends componentState {
  final String successmessage;

  getsubcomponentsuccess({required this.successmessage});
}

class getsubcomponentfailure extends componentState {
  final String errormessage;

  getsubcomponentfailure({required this.errormessage});
}

class addcomponentfailure extends componentState {}

class componentloading extends componentState {}

class componentsuccess extends componentState {
  final String success_message;

  componentsuccess({required this.success_message});
}

class componentfailure extends componentState {
  final String error_message;

  componentfailure({required this.error_message});
}
