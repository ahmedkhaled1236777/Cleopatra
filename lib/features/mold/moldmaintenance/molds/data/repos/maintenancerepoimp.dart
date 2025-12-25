import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/models/maintenancemodel.dart';
import 'package:cleopatra/features/mold/molds/data/models/moldmodel.dart';

abstract class maintenancerepo {
  Future<Either<failure, String>> addmaintenance(
      {required maintenancemodel moldmodel});
  Future<Either<failure, List<maintenancemodel>>> getmaintenance();
  Future<Either<failure, String>> deletemaintenance({required String docid});
  Future<Either<failure, String>> editmentatnce(
      {required String docid,
      required String status,
      required String type,
      required String name,
      required String location,
      required String notes,
      String? retrundate});
}
