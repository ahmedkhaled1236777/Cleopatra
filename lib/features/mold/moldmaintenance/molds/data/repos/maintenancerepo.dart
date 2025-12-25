import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/core/common/notification.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/models/maintenancemodel.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/repos/maintenancerepoimp.dart';

class Maintenancerepoimp extends maintenancerepo {
  @override
  Future<Either<failure, String>> addmaintenance(
      {required maintenancemodel moldmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("maintenance")
          .doc("${moldmodel.godate}-${moldmodel.moldname}-${moldmodel.type}")
          .set(moldmodel.tojson());
      if (moldmodel.type == "خارجيه")
        await sendnotification(
            data:
                "تم خروج اسطمبة ${moldmodel.moldname} لجهة الصيانه  ${moldmodel.location} بسبب ${moldmodel.cause}");
      return right("تم تسجيل بيانات الصيانه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<maintenancemodel>>> getmaintenance() async {
    List<maintenancemodel> maintenances = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("maintenance");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          maintenances.add(maintenancemodel.fromjson(element));
        });
      });
      return right(maintenances);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletemaintenance(
      {required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("maintenance")
          .doc(docid)
          .delete();

      return right("تم حذف تقرير الصيانه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editmentatnce(
      {required String docid,
      required String status,
      required String name,
      required String location,
      required String notes,
      required String type,
      String? retrundate}) async {
    try {
      await FirebaseFirestore.instance
          .collection("maintenance")
          .doc(docid)
          .update({"status": status, "retrundate": retrundate, "notes": notes});
      if (retrundate != null && status == "تمت الصيانه" && type == "خارجيه")
        await sendnotification(
            data: "تم عودة اسطمبة ${name} بعد الصيانه من جهة ${location}");
      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
