abstract class paintaverageState {}

class paintaverageInitial extends paintaverageState {}

class Changepaintaverage extends paintaverageState {}

class Deletepaintaverageloading extends paintaverageState {}

class changechecboxcyclestate extends paintaverageState {}

class DeletepaintaverageSuccess extends paintaverageState {
  final String successmessage;

  DeletepaintaverageSuccess({required this.successmessage});
}

class Deletepaintaveragefailure extends paintaverageState {
  final String errormessage;

  Deletepaintaveragefailure({required this.errormessage});
}

class AddpaintaverageLoading extends paintaverageState {}

class AddpaintaverageSucess extends paintaverageState {
  final String successmessage;

  AddpaintaverageSucess({required this.successmessage});
}

class AddpaintaverageFailure extends paintaverageState {
  final String failuremessage;

  AddpaintaverageFailure({required this.failuremessage});
}

class GetpaintaverageLoading extends paintaverageState {}

class changejob extends paintaverageState {}

class GetpaintaverageSuccess extends paintaverageState {
  final String successmessage;

  GetpaintaverageSuccess({required this.successmessage});
}

class GetpaintaverageFailure extends paintaverageState {
  final String errormessage;

  GetpaintaverageFailure({required this.errormessage});
}

class UpdatepaintaverageLoading extends paintaverageState {}

class UpdatepaintaverageSuccess extends paintaverageState {
  final String successmessage;

  UpdatepaintaverageSuccess({required this.successmessage});
}

class UpdatepaintaverageFailure extends paintaverageState {
  final String errormessage;

  UpdatepaintaverageFailure({required this.errormessage});
}
