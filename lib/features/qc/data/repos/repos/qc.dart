

import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/qc/data/models/qcmodel.dart';

abstract class qcrepo {
  Future<Either<failure, String>> addqc({required qcmodel qcmodel});
  Future<Either<failure, String>> editqc({required qcmodel qcmodel});
  Future<Either<failure, List<qcmodel>>> getqcs({String ?date,String? machinenumber,String?prodname});
  Future<Either<failure, String>> deleteqc({required qcmodel qcmodel});
}
