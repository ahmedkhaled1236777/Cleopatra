import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injection/data/models/diagnosemodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/ordermodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/timermodel.dart';

abstract class productionrepo {
  Future<Either<failure, String>> adddiagnose(
      {required Diagnosemodel diagnose});
  Future<Either<failure, List<Diagnosemodel>>> getdiagnose();
  Future<Either<failure, String>> addproduction(
      {required productionmodel productionmodel});
  Future<Either<failure, String>> addorder({required Ordermodel order});
  Future<Either<failure, List<productionmodel>>> getproductions(
      {required String date});

  Future<Either<failure, String>> deleteproduction(
      {required productionmodel prduction});
  Future<Either<failure, List<productionmodel>>> searchproductions(
      {String? date, String? machinenumber, String? shift});
  Future<Either<failure, String>> addtimer({required timermodel timer});
  Future<Either<failure, String>> deletetimer({required timermodel timer});
  Future<Either<failure, String>> updatetimer({required timermodel timer});
  Future<Either<failure, List<timermodel>>> gettimers();
}
