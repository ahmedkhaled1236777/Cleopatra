import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/core/common/notification.dart';
import 'package:cleopatra/features/mold/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molds/data/repos/moldrepos.dart';

class moldrepoimp extends moldrepo {
  @override
  Future<Either<failure, String>> addmold(
      {required moldmodel moldmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("molds")
          .doc(
              "${moldmodel.date}-${moldmodel.moldname}-${moldmodel.status}-${moldmodel.machinenumber}")
          .set(moldmodel.tojson());
      await sendnotification(
          data:
              " تم ${moldmodel.status} اسطمبة ${moldmodel.moldname} علي الماكينه رقم ${moldmodel.machinenumber} بتاريج ${moldmodel.date} الساعه ${moldmodel.time}");
      return right("تم تسجيل بيانات الاسطمبه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<moldmodel>>> getmolds() async {
    List<moldmodel> molds = [];
    try {
      CollectionReference user = FirebaseFirestore.instance.collection("molds");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          molds.add(moldmodel.fromjson(element.data()));
        });
      });
      return right(molds);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletemold({required docid}) async {
    try {
      await FirebaseFirestore.instance.collection("molds").doc(docid).delete();

      return right("تم حذف تقرير الاسطمبه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
