import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintaveragemodel.dart';

abstract class paintaveragerepo {
  Future<Either<failure, String>> addpaintaverage(
      {required paintaveragemodel paintaverage});
  Future<Either<failure, String>> deletepaintaverage(
      {required paintaveragemodel paintaverage});
  Future<Either<failure, String>> updatepaintaverage(
      {required paintaveragemodel paintaverage});
  Future<Either<failure, List<paintaveragemodel>>> getpaintaverages();
}
