import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel%20copy.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodelusage.dart';

abstract class paintrepo {
  Future<Either<failure, String>> addpaintorder({required Paintmodel paint});
  Future<Either<failure, String>> updateorder({required Paintmodel paint});
  Future<Either<failure, List<Paintmodel>>> getpaintorders();
  Future<Either<failure, String>> deletepaint({required Paintmodel paint});
  Future<Either<failure, List<Paintmodel>>> searchpaint(
      {required String orderid});
  Future<Either<failure, String>> addpaintsub(
      {required paintusagemodel paint, required String docid});
  Future<Either<failure, List<paintusagemodel>>> getsubpaints(
      {required String docid});
  Future<Either<failure, String>> deletesubpaints(
      {required paintusagemodel paint, required String docid});
}
