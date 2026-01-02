import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/repos/prodrepo.dart';

class productionhallrepoimplementation extends productionhallrepo {
  @override
  Future<Either<failure, String>> addproduction(
      {required productionhallmodel productionmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("productionshall")
          .doc("${productionmodel.ordernumber}")
          .set(productionmodel.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<productionhallmodel>>> getproductions(
      {required bool status}) async {
    List<productionhallmodel> productionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("productionshall");

      await user
          .where("status", isEqualTo: status)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          productionmodels.add(productionhallmodel.fromjson(element.data()));
        });
      });
      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteproduction(
      {required productionhallmodel prduction}) async {
    try {
     final batch = FirebaseFirestore.instance.batch();
  
  // 1. Fetch the subcollection
  final subCollectionSnapshot = await FirebaseFirestore.instance
      .collection("productionshall")
      .doc(prduction.ordernumber)
      .collection(prduction.ordernumber)
      .get();

  // 2. Explicitly check if docs exist
  if (subCollectionSnapshot.docs.isNotEmpty) {
    for (var doc in subCollectionSnapshot.docs) {
      batch.delete(doc.reference);
    }
  }

  // 3. Delete the parent document
  final parentRef = FirebaseFirestore.instance
      .collection("productionshall")
      .doc(prduction.ordernumber);
  
  batch.delete(parentRef);

  // 4. Commit the changes
  await batch.commit();
      return right("تم حذف الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<productionhallmodel>>> searchproductions(
      {required String orderid}) async {
    List<productionhallmodel> productionmodels = [];
    try {
      CollectionReference user =
          await FirebaseFirestore.instance.collection("productionshall");
      await user.doc(orderid).get().then((value) {
        if (value.exists)
          productionmodels.add(productionhallmodel.fromjson(value.data()));
      });

      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  Future<Either<failure, String>> editstatus(
      {required productionhallmodel productionmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("productionshall")
          .doc("${productionmodel.ordernumber}")
          .update({"status": true});
      return right("تم تسجيل بيانات التقرير بنجاح");

      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
