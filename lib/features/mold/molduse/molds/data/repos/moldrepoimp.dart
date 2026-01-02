import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';

import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/repos/moldrepos.dart';

class moldusagerepoimp extends moldusagerepo {
  @override
  Future<Either<failure, String>> addmoldusage(
      {required moldusagemodel moldmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("moldusages")
          .doc("${moldmodel.moldname}")
          .set(moldmodel.tojson());
      return right("تم تسجيل بيانات الاسطمبه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<moldusagemodel>>> getmoldusages() async {
    List<moldusagemodel> moldusages = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("moldusages");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          moldusages.add(moldusagemodel.fromjson(element));
        });
      });
      return right(moldusages);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editmoldusage(
      {required moldusagemodel moldmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("moldusages")
          .doc(moldmodel.moldname)
          .update(
              {"karton": moldmodel.karton,"bag":moldmodel.bag,"can":moldmodel.can,"glutinous":moldmodel.glutinous});
      return right("تم تعديل بيانات الاسطمبه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
