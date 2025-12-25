import 'package:dartz/dartz.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/models/productionmodel.dart';

import '../../../../../../../core/common/errors/failure.dart';

abstract class productionusagerepo {
  Future<Either<failure, String>> addproduction(
      {required productionusagemodel productionmodel, required String docid});
  Future<Either<failure, List<productionusagemodel>>> getproductions(
      {required String docid});
  Future<Either<failure, String>> deleteproduction(
      {required productionusagemodel prduction, required String docid});
}
