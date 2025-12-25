

import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/model/injectionmachinemodel.dart';

abstract class Injectionmachinerepo {
  Future<Either<failure, String>> addInjectionmachine({required Injectionmachinemodel Injectionmachinemodel});
  Future<Either<failure, String>> editInjectionmachine({required Injectionmachinemodel Injectionmachinemodel});
  Future<Either<failure, List<Injectionmachinemodel>>> getInjectionmachines();
  Future<Either<failure, String>> deleteInjectionmachine({required Injectionmachinemodel Injectionmachinemodel});
}
