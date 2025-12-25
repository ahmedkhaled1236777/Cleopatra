import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintaveragemodel.dart';
import 'package:cleopatra/features/paints/paintaverage/data/repo/paintaveragerepo.dart';

class paintaveragerepoimp extends paintaveragerepo {
  @override
  Future<Either<failure, String>> addpaintaverage(
      {required paintaveragemodel paintaverage}) async {
    try {
      await FirebaseFirestore.instance
          .collection("paintaverages")
          .doc(paintaverage.id)
          .set(paintaverage.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<paintaveragemodel>>> getpaintaverages() async {
    List<paintaveragemodel> paintaverages = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("paintaverages");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          paintaverages.add(paintaveragemodel.fromjson(element));
        });
      });
      return right(paintaverages);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updatepaintaverage(
      {required paintaveragemodel paintaverage}) async {
    try {
      await FirebaseFirestore.instance
          .collection("paintaverages")
          .doc(paintaverage.id)
          .update({
        "secondsperpiece": paintaverage.secondsperpiece,
        "job": paintaverage.job
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletepaintaverage(
      {required paintaveragemodel paintaverage}) async {
    try {
      await FirebaseFirestore.instance
          .collection("paintaverages")
          .doc(paintaverage.id)
          .delete();
      return right("تم حذف البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
