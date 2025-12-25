import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:cleopatra/features/paints/paint/data/repos/painreportrepo.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodelusage.dart';

class Paintreportrepoimp extends Painreportrepo {
  @override
  Future<Either<failure, String>> addpaintreport(
      {required paintreportmodel paintreport}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final firstref = await FirebaseFirestore.instance
            .collection("paintsreports")
            .doc("${paintreport.date}")
            .collection("${paintreport.date}")
            .doc(paintreport.docid);
        transaction.set(firstref, paintreport.tojson());
        final secondref = await FirebaseFirestore.instance
            .collection("painthall")
            .doc("${paintreport.ordernuber}")
            .collection("${paintreport.ordernuber}")
            .doc("${paintreport.date}${paintreport.docid}");
        transaction.set(
            secondref,
            paintusagemodel(
                    boyaquantity: (num.parse(
                                paintreport.boyaweightend.toString()) -
                            num.parse(paintreport.boyaweightstart.toString()))
                        .toString(),
                    date: paintreport.date,
                    injscrapquantity: paintreport.scrapinjquantity,
                    paintscrapquantity: paintreport.scrappaintquantity,
                    ordernumber: paintreport.ordernuber!,
                    quantity: paintreport.actualprodquantity!,
                    status: "لا")
                .tojson());
        final thirdref = await FirebaseFirestore.instance
            .collection("painthall")
            .doc("${paintreport.ordernuber}");
        transaction.update(thirdref, {
          "scrapquantity": FieldValue.increment(paintreport.scrappaintquantity),
          "actualprod": FieldValue.increment(paintreport.actualprodquantity),
        });
      });

      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<paintreportmodel>>> getpaintsreports(
      {required String date}) async {
    List<paintreportmodel> paintsreports = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("paintsreports");

      await user
          .doc(date)
          .collection(date)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          paintsreports.add(paintreportmodel.fromjson(
            element.data(),
          ));
        });
      });

      return right(paintsreports);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletepaintreport(
      {required paintreportmodel paintreport}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final firstref = await FirebaseFirestore.instance
            .collection("paintsreports")
            .doc(paintreport.date)
            .collection(paintreport.date)
            .doc(paintreport.docid);
        transaction.delete(firstref);
        final secondref = await FirebaseFirestore.instance
            .collection("painthall")
            .doc(paintreport.ordernuber)
            .collection("${paintreport.ordernuber}")
            .doc("${paintreport.date}${paintreport.docid}");
        transaction.delete(secondref);
        final thirdref = await FirebaseFirestore.instance
            .collection("painthall")
            .doc("${paintreport.ordernuber}");
        transaction.update(thirdref, {
          "scrapquantity":
              FieldValue.increment(-paintreport.scrappaintquantity),
          "actualprod": FieldValue.increment(-paintreport.actualprodquantity),
        });
      });

      return right("تم حذف تقرير الماكينه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
