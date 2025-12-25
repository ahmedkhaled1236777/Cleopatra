import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/hr/data/model/absensemodel.dart';
import 'package:cleopatra/features/hr/data/model/attendancemodel.dart';
import 'package:cleopatra/features/hr/data/model/cut.dart';
import 'package:cleopatra/features/hr/data/model/holidays.dart';
import 'package:cleopatra/features/hr/data/model/waitingmodel.dart';
import 'package:cleopatra/features/hr/data/repo/hrrepo.dart';

class Hrrepoimp extends hrrepo {
  @override
  Future<Either<failure, List<Attendancemodel>>> getattallendence(
      {required String month}) async {
    try {
      List<Attendancemodel> attendances = [];
      CollectionReference user = await FirebaseFirestore.instance
          .collection("attendances")
          .doc(month)
          .collection(month);
      await user.get().then((e) {
        for (var element in e.docs) {
          attendances.add(Attendancemodel.fromjson(element.data()));
        }
      });
      return right(attendances);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<waitingmodel>>> getwaitings(
      {required String monthyear}) async {
    try {
      List<waitingmodel> attendances = [];
      CollectionReference user = await FirebaseFirestore.instance
          .collection("waitings")
          .doc(monthyear)
          .collection(monthyear);
      await user.get().then((e) {
        for (var element in e.docs) {
          attendances.add(waitingmodel.fromjson(element.data()));
        }
      });
      return right(attendances);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletewaiting(
      {required waitingmodel waiting,
      required String monthyear,
      required String status}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference ref1 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc("${waiting.name}")
            .collection(waiting.type == "اجازه"
                ? "holiday"
                : waiting.type == "سلفه"
                    ? "money"
                    : waiting.type == "اذن"
                        ? "permession"
                        : "addhours")
            .doc("${waiting.date}");
        DocumentReference ref2 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc("${waiting.name}");
        transaction.update(ref1, {"status": status});
        if (status == "مقبوله") {
          if (waiting.type == "اذن" || waiting.type == "اضافى") {
            var format = DateFormat("HH:mm");
            var start = format.parse(waiting.starthour!);
            var end = format.parse(waiting.timeto!);
            Duration diff = end.difference(start).abs();
            transaction.update(ref2, {
              if (waiting.type == "اذن")
                "permessionhours": FieldValue.increment(diff.inMinutes / 60),
              if (waiting.type == "اضافى")
                "addhours": FieldValue.increment(diff.inMinutes / 60)
            });
          } else {
            transaction.update(ref2, {
              if (waiting.type == "اجازه") "daysoff": FieldValue.increment(1),
              if (waiting.type == "سلفه")
                "money": FieldValue.increment(waiting.money!),
            });
          }
        }
        DocumentReference ref = FirebaseFirestore.instance
            .collection("waitings")
            .doc(monthyear)
            .collection(monthyear)
            .doc(
                "${waiting.name}-${waiting.type == "اجازه" ? "holiday" : waiting.type == "سلفه" ? "money" : waiting.type == "اذن" ? "permession" : "addhours"}-${waiting.date}");
        transaction.delete(ref);
      });
      return right("تم التعديل بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addabsense(
      {required Absensemodel absense,
      required String monthyear,
      required String workerid}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((trasaction) async {
        DocumentReference ref1 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc(workerid);
        trasaction.update(ref1, {"notattendance": FieldValue.increment(1)});
        DocumentReference ref2 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc(workerid)
            .collection("notattendance")
            .doc();
        trasaction.set(ref2, absense.tojson());
      });
      return right("تم التسجيل بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addcutmoney(
      {required cutmodel cut,
      required String monthyear,
      required String workerid}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((trasaction) async {
        DocumentReference ref1 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc(workerid);
        trasaction
            .update(ref1, {"cut": FieldValue.increment(cut.numberofcuts)});
        DocumentReference ref2 = FirebaseFirestore.instance
            .collection("attendances")
            .doc(monthyear)
            .collection(monthyear)
            .doc(workerid)
            .collection("cut")
            .doc();
        trasaction.set(ref2, cut.tojson());
      });
      return right("تم التسجيل بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addfullholiday({
    required String monthyear,
    required holiday holiday,
  }) async {
    try {
      final userSnapshot =
          await FirebaseFirestore.instance.collection("workerattendance").get();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // 1️⃣ First, perform all reads (collect references & check existence)
        final docsToUpdate = <DocumentReference, bool>{};
        for (final doc in userSnapshot.docs) {
          final ref = FirebaseFirestore.instance
              .collection("attendances")
              .doc(monthyear)
              .collection(monthyear)
              .doc(doc.data()["name"]);

          final snapshot = await transaction.get(ref);
          docsToUpdate[ref] = snapshot.exists;
        }

        // 2️⃣ Then, perform all writes
        for (final entry in docsToUpdate.entries) {
          final ref = entry.key;
          final exists = entry.value;

          if (exists) {
            transaction.update(ref, {"daysoff": FieldValue.increment(1)});
          } else {
            transaction.set(ref, {
              "attendancedays": 0,
              "permessionhours": 0.0,
              "addhours": 0.0,
              "daysoff": 1,
              "notattendance": 0,
              "cut": 0.0,
              "money": 0.0,
              "ipadress": ref.id,
            });
          }

          // Add holiday subcollection entry
          final holidayRef = ref.collection("holiday").doc(holiday.date);
          transaction.set(holidayRef, holiday.tojson());
        }

        return null; // Explicitly mark completion
      });

      return right("تم التسجيل بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
