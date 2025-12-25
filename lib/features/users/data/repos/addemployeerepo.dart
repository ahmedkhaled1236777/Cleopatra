import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';

abstract class employeerepo {
  Future<Either<failure, List<Signmodelrequest>>> getemployees();
  Future<Either<failure, String>> deleteemployee({required String EMAIL});
  Future<Either<failure, String>> editemployee(
      {required Signmodelrequest employee});
}
