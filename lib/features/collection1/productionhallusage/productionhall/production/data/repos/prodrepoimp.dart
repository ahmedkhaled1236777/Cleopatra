import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/repos/prodrepo.dart';

class productionusagerepoimplementation extends productionusagerepo {
  @override
  Future<Either<failure, String>> addproduction(
      {required productionusagemodel productionmodel,
      required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("productionshall")
          .doc("${docid}")
          .collection("${docid}")
          .doc("${productionmodel.ordernumber}")
          .set(productionmodel.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<productionusagemodel>>> getproductions(
      {required String docid}) async {
    List<productionusagemodel> productionmodels = [];
    try {
      CollectionReference user = FirebaseFirestore.instance
          .collection("productionshall")
          .doc("${docid}")
          .collection("${docid}");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          productionmodels.add(productionusagemodel.fromjson(element));
        });
      });
      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteproduction(
      {required productionusagemodel prduction, required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("productionshall")
          .doc(docid)
          .collection("${docid}")
          .doc(prduction.ordernumber)
          .delete();

      return right("تم حذف الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
