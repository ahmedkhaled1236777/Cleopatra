import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';

abstract class authrepo {
  Future<Either<failure, Signmodelrequest>> sign(
      {required String email, required String pass});
  Future<Either<failure, String>> signup({required Signmodelrequest signup});
  Future<Either<failure, Signmodelrequest>> getprofile({required String email});
  Future<Either<failure, String>> logout();
  Future<Either<failure, String>> resetpass({required String email});
}
