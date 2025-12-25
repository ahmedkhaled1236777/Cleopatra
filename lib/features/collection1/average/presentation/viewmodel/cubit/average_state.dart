part of 'average_cubit.dart';

abstract class AverageState {}

class AverageInitial extends AverageState {}

class ChangeAverage extends AverageState {}

class DeleteAverageloading extends AverageState {}

class changechecboxcyclestate extends AverageState {}

class DeleteAverageSuccess extends AverageState {
  final String successmessage;

  DeleteAverageSuccess({required this.successmessage});
}

class DeleteAveragefailure extends AverageState {
  final String errormessage;

  DeleteAveragefailure({required this.errormessage});
}

class AddAverageLoading extends AverageState {}

class AddAverageSucess extends AverageState {
  final String successmessage;

  AddAverageSucess({required this.successmessage});
}

class AddAverageFailure extends AverageState {
  final String failuremessage;

  AddAverageFailure({required this.failuremessage});
}

class GetAverageLoading extends AverageState {}

class changejob extends AverageState {}

class GetAverageSuccess extends AverageState {
  final String successmessage;

  GetAverageSuccess({required this.successmessage});
}

class GetAverageFailure extends AverageState {
  final String errormessage;

  GetAverageFailure({required this.errormessage});
}

class UpdateAverageLoading extends AverageState {}

class UpdateAverageSuccess extends AverageState {
  final String successmessage;

  UpdateAverageSuccess({required this.successmessage});
}

class UpdateAverageFailure extends AverageState {
  final String errormessage;

  UpdateAverageFailure({required this.errormessage});
}
