import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/mold/molds/data/models/moldmodel.dart';

abstract class moldrepo {
  Future<Either<failure, String>> addmold({required moldmodel moldmodel});
  Future<Either<failure, List<moldmodel>>> getmolds();
  Future<Either<failure, String>> deletemold({required docid});
}
