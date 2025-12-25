import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/model/workermodel.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/repos/workersrepo.dart';

class Workersrepoimp extends Workersrepo {
  @override
  Future<Either<failure, String>> addworker(
      {required Worker Workermodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("workers")
          .doc(Workermodel.workername)
          .set(Workermodel.tojson());
      return right("تمت اضافة العامل بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Worker>>> getworkers() async {
    List<Worker> workers = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("workers");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          workers.add(Worker.fromjson(element));
        });
      });

      return right(workers);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteworker(
      {required Worker Workermodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("workers")
          .doc(Workermodel.workername)
          .delete();

      return right("تم حذف تقرير الماكينه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
