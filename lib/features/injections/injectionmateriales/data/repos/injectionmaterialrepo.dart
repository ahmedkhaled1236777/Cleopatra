

import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/model/injectionmaterialmodel.dart';

abstract class Injectionmaterialrepo {
  Future<Either<failure, String>> addInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel});
  Future<Either<failure, String>> editInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel});
  Future<Either<failure, List<Injectionmaterialmodel>>> getInjectionmaterials();
  Future<Either<failure, String>> deleteInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel});
}
