import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workercomodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workermodel.dart';

abstract class Injectioncorepo {
  Future<Either<failure, String>> adddata({required injectioncomodel injec});
  Future<Either<failure, String>> updatedata({required injectioncomodel injec});

  Future<Either<failure, String>> adddworkerdata({required Workermodel worker});
  Future<Either<failure, String>> deletedata({required injectioncomodel injec});
  Future<Either<failure, List<Workercomodel>>> getworkercodata(
      {required String month});
  Future<Either<failure, List<injectioncomodel>>> getdata(
      {required String date});
  Future<Either<failure, List<Workermodel>>> getworkerdata(
      {required String worker, required String month});
  Future<Either<failure, String>> update(
      {required String injecdate,
      required String docid,
      String? workername,
      int? prodquantity,
      String? job,
      String? notes});
}
