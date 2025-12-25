part of 'molds_cubit.dart';

abstract class MoldsState {}
 class MoldsInitial extends MoldsState {}
 class changemold extends MoldsState {}
 class resetmoldname extends MoldsState {}
 class searchformold extends MoldsState {}
 class deletemoldloading extends MoldsState {}
 class deletemoldsuccess extends MoldsState {
  final String success_message;

  deletemoldsuccess({required this.success_message});
 }
 class deletemoldfailure extends MoldsState {
  final String error_message;

  deletemoldfailure({required this.error_message});
 }
 class changetypestate extends MoldsState {}
 class addmoldloading extends MoldsState {}
 class addmoldsuccess extends MoldsState {
  final String success_message;

  addmoldsuccess({required this.success_message});
 }
 class addmoldfailure extends MoldsState {
  final String error_message;

  addmoldfailure({required this.error_message});
 }
 class getmoldloading extends MoldsState {}
 class getmoldsuccess extends MoldsState {
  final String success_message;

  getmoldsuccess({required this.success_message});
 }
 class getmoldfailure extends MoldsState {
  final String error_message;

  getmoldfailure({required this.error_message});
 }

