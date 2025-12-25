import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';


import 'package:cleopatra/features/qc/data/models/qcmodel.dart';
import 'package:cleopatra/features/qc/data/repos/repos/qc.dart';

class qcrepoimp extends qcrepo{
  @override
  Future<Either<failure, String>> addqc({required qcmodel qcmodel}) async {
    try {
         
      await FirebaseFirestore.instance
          .collection("qcs")
          .doc(
              "${qcmodel.docid}")
          .set(qcmodel.tojson());
      
      return right("تم تسجيل التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteqc({required qcmodel qcmodel}) async {
  try {
      await FirebaseFirestore.instance.collection("qcs").doc("${qcmodel.docid}").delete();

      return right("تم حذف التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editqc({required qcmodel qcmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("qcs")
          .doc("${qcmodel.docid}")
          .update({
    "starttime":qcmodel.starttime,
    "endtime":qcmodel.endtime,
    "cause":qcmodel.cause,
    "notes":qcmodel.notes,
    "qcengineer":qcmodel.qcengineer,
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<qcmodel>>> getqcs({String ?date,String? machinenumber,String?prodname}) async {
    List<qcmodel> qcs = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("qcs");

      await user.where("date",isEqualTo: date).where("machinenumber",isEqualTo: machinenumber).where("productname",isEqualTo: prodname).orderBy("timestamp",descending: true).get().then((value) {
        value.docs.forEach((element) {
          qcs.add(qcmodel.fromjson(element));
        });
      });
      return right(qcs);
    } catch (e) {
      print(e);
      return left(requestfailure(error_message: e.toString()));
    }
  }
  
}