import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/collection1/components/data/models/componentmodel.dart';
import 'package:cleopatra/features/collection1/components/data/models/subcomponent.dart';

abstract class componentrepo {
  Future<Either<failure, List<componentsmodel>>> getcomponents();
  Future<Either<failure, String>> deletesubcomponent(
      {required Subcomponent subcomponet, required String componentname});
  Future<Either<failure, List<Subcomponent>>> getsubcomponents(
      {required String componentname});
  Future<Either<failure, String>> addsubcomponent(
      {required Subcomponent subcomponet, required String componentname});
  Future<Either<failure, String>> editcomponent(
      {required int quantaity, required String docid, required bool type});
}
