import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';

abstract class Painreportrepo {
  Future<Either<failure, String>> addpaintreport(
      {required paintreportmodel paintreport});
  Future<Either<failure, List<paintreportmodel>>> getpaintsreports(
      {required String date});
  Future<Either<failure, String>> deletepaintreport(
      {required paintreportmodel paintreport});
}
