import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workercomodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workermodel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/repo/injectioncorepo.dart';
import 'package:intl/intl.dart';

class Injectioncorepoimp extends Injectioncorepo {
  @override
 // ملاحظة: تم حذف تعريف transaction = batch() القديم الذي كان خارج try-catch.

Future<Either<failure, String>> adddata(
    {required injectioncomodel injec}) async {
  
  // 1. حساب فرق الوقت (لا يتغير)
  var format = DateFormat("HH:mm");
  var start = format.parse(injec.timefrom!);
  var end = format.parse(injec.timeto!);
  Duration diff = end.difference(start).abs();

  // 2. إنشاء مجموعة الكتابة (Write Batch)
  final batch = FirebaseFirestore.instance.batch();

  // 3. تحديد وتجميع العملية الأولى (injectionco)
  final firstref = FirebaseFirestore.instance
      .collection("injectionco")
      .doc("${injec.date}")
      .collection("${injec.date}")
      .doc(injec.docid);
  batch.set(firstref, injec.tojson()); // استخدام batch.set

  // 4. تحديد وتجميع العملية الثانية (injectionworkerco)
  final secondref = FirebaseFirestore.instance
      .collection("injectionworkerco")
      .doc("injectionworkerco")
      .collection(
          "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().year}",
      )
      .doc(injec.docid);
  batch.set(secondref, { // استخدام batch.set
    "name": injec.workername,
    "date": injec.date,
    "time": (diff.inMinutes.toDouble()),
    "job": injec.job,
    "quantity": injec.productionquantity.toDouble(),
    "timestamp": FieldValue.serverTimestamp()
  });

  // 5. تنفيذ (Commit) مجموعة الكتابة داخل Try-Catch
  try {
    await batch.commit(); // تنفيذ جميع العمليات معاً
    return right("تم تسجيل بيانات التقرير بنجاح");
    // ignore: empty_catches
  } catch (e) {
    return left(requestfailure(error_message: e.toString()));
  }
}

  @override
  Future<Either<failure, List<injectioncomodel>>> getdata(
      {required String date}) async {
    List<injectioncomodel> productionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionco");

      await user
          .doc(date)
          .collection(date)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          productionmodels.add(injectioncomodel.fromjson(element.data()));
        });
      });
      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> update(
      {required String injecdate,
      required String docid,
      String? workername,
      int? prodquantity,
      String? job,
      String? notes}) async {
    try {
      CollectionReference user = FirebaseFirestore.instance
          .collection("injectionco")
          .doc(injecdate)
          .collection(injecdate);

      await user.doc(docid).update({
        if (workername != null) "workername": workername,
        if (job != null) "job": job,
        if (notes != null) "notes": notes,
        if (prodquantity != null) "productionquantity": prodquantity,
      });

      return right("تم تعديل البيانات بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
 Future<Either<failure, String>> deletedata(
    {required injectioncomodel injec}) async {
  
  // 1. إنشاء مجموعة الكتابة (Write Batch)
  final batch = FirebaseFirestore.instance.batch();

  // 2. تحديد وتجميع العملية الأولى للحذف (injectionco)
  // ملاحظة: لا نحتاج إلى 'await' هنا، نحن فقط نبني المرجع.
  final firestref = FirebaseFirestore.instance
      .collection("injectionco")
      .doc(injec.date)
      .collection(injec.date)
      .doc(injec.docid);
  
  batch.delete(firestref); // تجميع عملية الحذف الأولى

  // 3. التحقق وتجميع العملية الثانية للحذف (injectionworkerco)
  if (injec.month != null) {
    // ملاحظة: لا نحتاج إلى 'await' هنا
    final secondref = FirebaseFirestore.instance
        .collection("injectionworkerco")
        .doc("injectionworkerco")
        .collection(injec.month!)
        .doc(injec.docid);
    
    batch.delete(secondref); // تجميع عملية الحذف الثانية
  }

  // 4. تنفيذ (Commit) مجموعة الكتابة داخل Try-Catch
  try {
    await batch.commit(); // تنفيذ جميع عمليات الحذف المجمعة معاً
    return right("تم حذف البيان بنجاح");
    // ignore: empty_catches
  } catch (e) {
    return left(requestfailure(error_message: e.toString()));
  }
}
  @override
  Future<Either<failure, String>> adddworkerdata(
      {required Workermodel worker}) async {
    try {
      await FirebaseFirestore.instance
          .collection("workers")
          .doc("${worker.workername}")
          .collection("${worker.month}")
          .doc("${worker.date}-${Random().nextInt(1000)}")
          .set(worker.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Workermodel>>> getworkerdata(
      {required String worker, required String month}) async {
    List<Workermodel> workers = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("workers");

      await user
          .doc("${worker}")
          .collection(month)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          workers.add(Workermodel.fromjson(element.data()));
        });
      });
      return right(workers);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Workercomodel>>> getworkercodata(
      {required String month}) async {
    List<Workercomodel> Workercomodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionworkerco");

      await user
          .doc("injectionworkerco")
          .collection(month)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          Workercomodels.add(Workercomodel.fromjson(element.data()));
        });
      });
      return right(Workercomodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updatedata(
      {required injectioncomodel injec}) async {
    var format = DateFormat("HH:mm");
    var start = format.parse(injec.timefrom!);
    var end = format.parse(injec.timeto!);
    Duration diff = end.difference(start).abs();

    try {
      await FirebaseFirestore.instance
          .collection("injectionco")
          .doc("${injec.date}")
          .collection("${injec.date}")
          .doc(injec.docid)
          .update(injec.tojson());
      if (injec.month != null)
        await FirebaseFirestore.instance
            .collection("injectionworkerco")
            .doc("injectionworkerco")
            .collection(
              injec.month!,
            )
            .doc(injec.docid)
            .update({
          "name": injec.workername,
          "date": injec.date,
          "time": (diff.inMinutes.toDouble()),
          "job": injec.job,
          "quantity": injec.productionquantity.toDouble(),
        });
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
