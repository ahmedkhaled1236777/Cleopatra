

import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/model/injectioworkermodel.dart';

abstract class Injectionworkerrepo {
  Future<Either<failure, String>> addInjectionworker({required Injectionworkermodel Injectionworkermodel});
  Future<Either<failure, String>> editInjectionworker({required Injectionworkermodel Injectionworkermodel});
  Future<Either<failure, List<Injectionworkermodel>>> getInjectionworkers();
  Future<Either<failure, String>> deleteInjectionworker({required Injectionworkermodel Injectionworkermodel});
}
