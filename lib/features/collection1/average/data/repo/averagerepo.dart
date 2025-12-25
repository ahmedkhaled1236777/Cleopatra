import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';

abstract class Averagerepo {
  Future<Either<failure, String>> addaverage({required averagemodel average});
  Future<Either<failure, String>> deleteaverage(
      {required averagemodel average});
  Future<Either<failure, String>> updateaverage(
      {required averagemodel average});
  Future<Either<failure, List<averagemodel>>> getaverages();
}
