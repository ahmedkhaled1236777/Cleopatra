import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/model/workermodel.dart';

abstract class Workersrepo {
  Future<Either<failure, String>> addworker({required Worker Workermodel});
  Future<Either<failure, String>> deleteworker({required Worker Workermodel});
  Future<Either<failure, List<Worker>>> getworkers();
}
