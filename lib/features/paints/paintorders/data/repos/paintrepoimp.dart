import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodelusage.dart';
import 'package:cleopatra/features/paints/paintorders/data/repos/paintrepo.dart';

class paintrepoimplementation extends paintrepo {
  @override
  Future<Either<failure, String>> addpaintorder(
      {required Paintmodel paint}) async {
    try {
      await FirebaseFirestore.instance
          .collection("painthall")
          .doc("${paint.ordernumber}")
          .set(paint.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Paintmodel>>> getpaintorders() async {
    List<Paintmodel> paints = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("painthall");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          paints.add(Paintmodel.fromjson(element.data()));
        });
      });
      return right(paints);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletepaint(
      {required Paintmodel paint}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        await FirebaseFirestore.instance
            .collection("painthall")
            .doc(paint.ordernumber)
            .collection(paint.ordernumber)
            .get()
            .then((value) {
          value.docs.forEach((e) {
            transaction.delete(e.reference);
          });
        });
        final secondref = await FirebaseFirestore.instance
            .collection("painthall")
            .doc(paint.ordernumber);
        transaction.delete(secondref);
      });
      return right("تم حذف الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Paintmodel>>> searchpaint(
      {required String orderid}) async {
    List<Paintmodel> paints = [];
    try {
      CollectionReference user =
          await FirebaseFirestore.instance.collection("painthall");
      await user.doc(orderid).get().then((value) {
        if (value.exists) paints.add(Paintmodel.fromjson(value.data()));
      });

      return right(paints);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  Future<Either<failure, String>> editstatus(
      {required Paintmodel paint}) async {
    try {
      await FirebaseFirestore.instance
          .collection("painthall")
          .doc("${paint.ordernumber}")
          .update({"status": true});
      return right("تم تسجيل بيانات التقرير بنجاح");

      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addpaintsub(
      {required paintusagemodel paint, required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("painthall")
          .doc("${docid}")
          .collection("${docid}")
          .doc("${paint.ordernumber}")
          .set(paint.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletesubpaints(
      {required paintusagemodel paint, required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("painthall")
          .doc(docid)
          .collection("${docid}")
          .doc(paint.ordernumber)
          .delete();

      return right("تم حذف الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<paintusagemodel>>> getsubpaints(
      {required String docid}) async {
    List<paintusagemodel> paints = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("painthall");

      await user
          .doc("${docid}")
          .collection("${docid}")
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          paints.add(paintusagemodel.fromjson(element.data()));
        });
      });
      return right(paints);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updateorder(
      {required Paintmodel paint}) async {
    try {
      await FirebaseFirestore.instance
          .collection("painthall")
          .doc("${paint.ordernumber}")
          .update(paint.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
