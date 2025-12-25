import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';
import 'package:cleopatra/features/collection1/average/data/repo/averagerepo.dart';

class Averagerepoimp extends Averagerepo {
  @override
  Future<Either<failure, String>> addaverage(
      {required averagemodel average}) async {
    try {
      await FirebaseFirestore.instance
          .collection("averages")
          .doc(average.id)
          .set(average.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<averagemodel>>> getaverages() async {
    List<averagemodel> averages = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("averages");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          averages.add(averagemodel.fromjson(element.data()));
        });
      });
      return right(averages);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updateaverage(
      {required averagemodel average}) async {
    try {
      await FirebaseFirestore.instance
          .collection("averages")
          .doc(average.id)
          .update(
              {"secondsperpiece": average.secondsperpiece, "job": average.job});

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteaverage(
      {required averagemodel average}) async {
    try {
      await FirebaseFirestore.instance
          .collection("averages")
          .doc(average.id)
          .delete();
      return right("تم حذف البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
