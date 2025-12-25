part of 'worker_cubit.dart';

abstract class WorkerState {}

class WorkerInitial extends WorkerState {}

class GetWorkersLoading extends WorkerState {}

class GetWorkersSuccess extends WorkerState {
  final String successmessage;

  GetWorkersSuccess({required this.successmessage});
}

class GetWorkersFailure extends WorkerState {
  final String errormessage;

  GetWorkersFailure({required this.errormessage});
}

class AddWorkerloading extends WorkerState {}

class deleteworkerloading extends WorkerState {}

class deleteworkersuccess extends WorkerState {
  final String successmessage;

  deleteworkersuccess({required this.successmessage});
}

class deleteworkerfailure extends WorkerState {
  final String errormessage;

  deleteworkerfailure({required this.errormessage});
}

class changeworker extends WorkerState {}

class AddWorkersuccess extends WorkerState {
  final String successmessage;

  AddWorkersuccess({required this.successmessage});
}

class AddWorkerfailure extends WorkerState {
  final String errormessage;

  AddWorkerfailure({required this.errormessage});
}
