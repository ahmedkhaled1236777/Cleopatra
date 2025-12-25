import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';
import 'package:cleopatra/features/users/data/repos/addemployeerepo.dart';

class emplyeerepoimplementaion extends employeerepo {
  @override
  Future<Either<failure, List<Signmodelrequest>>> getemployees() async {
    List<Signmodelrequest> EMPLOYEES = [];
    try {
      CollectionReference user = FirebaseFirestore.instance.collection("users");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          EMPLOYEES.add(Signmodelrequest.fromjson(data: element.data()));
        });
      });
      return right(EMPLOYEES);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteemployee(
      {required String EMAIL}) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(EMAIL).delete();
      return right("تم حذف الموظف بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editemployee(
      {required Signmodelrequest employee}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("${employee.email}")
          .update(employee.tojson());
      return right("تم تعديل البيانات بنجاح");

      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
