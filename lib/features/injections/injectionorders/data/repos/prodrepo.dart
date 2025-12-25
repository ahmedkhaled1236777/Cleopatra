import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel%20copy.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';

abstract class injectionhallrepo {
  Future<Either<failure, String>> addinjection(
      {required injectionhallmodel injectionmodel});
  Future<Either<failure, String>> updateorder(
      {required injectionhallmodel injectionmodel});
  Future<Either<failure, List<injectionhallmodel>>> getinjections(
      {required bool status});
  Future<Either<failure, String>> deleteinjection(
      {required injectionhallmodel prduction});
  Future<Either<failure, List<injectionhallmodel>>> searchinjections(
      {required String orderid});
  Future<Either<failure, String>> addinjectionsub(
      {required injectionusagemodel injectionmodel, required String docid});
  Future<Either<failure, List<injectionusagemodel>>> getinjectionssub(
      {required String docid});
  Future<Either<failure, String>> deleteinjectionsub(
      {required injectionusagemodel prduction, required String docid});
}
