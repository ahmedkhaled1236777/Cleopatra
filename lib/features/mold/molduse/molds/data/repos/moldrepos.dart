import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';

abstract class moldusagerepo {
  Future<Either<failure, String>> addmoldusage(
      {required moldusagemodel moldmodel});
  Future<Either<failure, String>> editmoldusage(
      {required moldusagemodel moldmodel});
  Future<Either<failure, List<moldusagemodel>>> getmoldusages();
}
