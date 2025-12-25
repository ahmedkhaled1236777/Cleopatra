import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/workers/data/models/workermodelrequest.dart';

abstract class attenfdanceWorkerrepo {
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker});
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required String id});

  Future<Either<failure, String>> deletworker({required String workerid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, List<Workermodelrequest>>> getworkers(
);
  
}
