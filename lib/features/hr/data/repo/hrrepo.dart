import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/hr/data/model/absensemodel.dart';
import 'package:cleopatra/features/hr/data/model/attendancemodel.dart';
import 'package:cleopatra/features/hr/data/model/cut.dart';
import 'package:cleopatra/features/hr/data/model/holidays.dart';
import 'package:cleopatra/features/hr/data/model/waitingmodel.dart';

abstract class hrrepo {
  Future<Either<failure, List<Attendancemodel>>> getattallendence(
      {required String month});
  Future<Either<failure, List<waitingmodel>>> getwaitings(
      {required String monthyear});
  Future<Either<failure, String>> addfullholiday({
    required String monthyear,
    required holiday holiday,
  });
  Future<Either<failure, String>> deletewaiting(
      {required waitingmodel waiting,
      required String monthyear,
      required String status});
  Future<Either<failure, String>> addabsense({
    required Absensemodel absense,
    required String monthyear,
    required String workerid,
  });
  Future<Either<failure, String>> addcutmoney({
    required cutmodel cut,
    required String monthyear,
    required String workerid,
  });
}
