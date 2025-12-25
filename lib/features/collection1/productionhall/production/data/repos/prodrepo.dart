import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';

abstract class productionhallrepo {
  Future<Either<failure, String>> addproduction(
      {required productionhallmodel productionmodel});
  Future<Either<failure, List<productionhallmodel>>> getproductions(
      {required bool status});
  Future<Either<failure, String>> deleteproduction(
      {required productionhallmodel prduction});
  Future<Either<failure, List<productionhallmodel>>> searchproductions(
      {required String orderid});
}
