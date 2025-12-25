import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/workers/data/models/workermodelrequest.dart';
import 'package:cleopatra/features/workers/data/repos/workerrepo.dart';
import 'package:http/http.dart' as http;

class attendanceWorkerrepoimp extends attenfdanceWorkerrepo {
  @override
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker}) async {
    try {
      final QuerySnapshot user1 = await FirebaseFirestore.instance
          .collection("workerattendance")
          .where('name', isEqualTo: worker.name)
          .limit(1)
          .get();
      final QuerySnapshot user2 = await FirebaseFirestore.instance
          .collection("workerattendance")
          .where('deviceip', isEqualTo: worker.deviceip)
          .limit(1)
          .get();

      if (user1.docs.isNotEmpty) {
        return left(
            requestfailure(error_message: "هذا الاسم مسجل لدينا من قبل"));
      } else if (user2.docs.isNotEmpty) {
        return left(
            requestfailure(error_message: "هذا الجهاز مسجل لدينا من قبل"));
      } else {
        await FirebaseFirestore.instance
            .collection("workerattendance")
            .doc(worker.name)
            .set(worker.tojson());
        return right("تم تسجيل بيانات الموظف  بنجاح");
      }
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletworker(
      {required String workerid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("workerattendance")
          .doc(workerid)
          .delete();

      return right("تم حذف البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection("workerattendance")
          .doc(id)
          .update(worker.tojson());
      return right("تم تعديل البيانات بنجاح  بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Workermodelrequest>>> getworkers() async {
    List<Workermodelrequest> workers = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("workerattendance");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          workers.add(Workermodelrequest.fromjson(element.data()));
        });
      });
      return right(workers);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
