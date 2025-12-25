import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel%20copy.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';

import 'package:cleopatra/features/injections/injectionorders/data/repos/prodrepo.dart';

class injectionhallrepoimplementation extends injectionhallrepo {
  @override
  Future<Either<failure, String>> addinjection(
      {required injectionhallmodel injectionmodel}) async {
    try {
      
                                      var exis = await FirebaseFirestore.instance
                                        .collection("injectionshall")
                                        .doc("${injectionmodel.ordernumber}")
                                        .get();
                                    if (exis.exists) {
                                            return left(requestfailure(error_message: "هذا الاوردر مسجل لدينا من قبل"));

                                      
                                    }
                            
                             else{
   var exisit = await FirebaseFirestore.instance
                                        .collection("injectionshall")
                                        .where("status",isEqualTo: false).where("machine",isEqualTo: injectionmodel.machine)
                                        .get();

   if (exisit.docs.isNotEmpty) {
    return left(requestfailure(error_message: "برجاء اغلاق الاوردر المسجل علي الماكينه اولا"));
                                     
   }
                                    else
      await FirebaseFirestore.instance
          .collection("injectionshall")
          .doc("${injectionmodel.ordernumber}")
          .set(injectionmodel.tojson());}
      return right("تم تسجيل بيانات الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<injectionhallmodel>>> getinjections(
      {required bool status}) async {
    /*  List<injectionhallmodel> injectionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionshall");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          injectionmodels.add(injectionhallmodel.fromjson(element.data()));
        });
      });
      return right(injectionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }*/
    List<injectionhallmodel> injectionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionshall");

      await user
          .where("status", isEqualTo: status)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          injectionmodels.add(injectionhallmodel.fromjson(element.data()));
        });
      });
      return right(injectionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteinjection(
      {required injectionhallmodel prduction}) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        await FirebaseFirestore.instance
            .collection("injectionshall")
            .doc(prduction.ordernumber)
            .collection(prduction.ordernumber)
            .get()
            .then((value) {
          value.docs.forEach((e) {
            transaction.delete(e.reference);
          });
        });
        final ref = await FirebaseFirestore.instance
            .collection("injectionshall")
            .doc(prduction.ordernumber);
        transaction.delete(ref);
      });

      return right("تم حذف الاوردر بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<injectionhallmodel>>> searchinjections(
      {required String orderid}) async {
    List<injectionhallmodel> injectionmodels = [];
    try {
      CollectionReference user =
          await FirebaseFirestore.instance.collection("injectionshall");
      await user.doc(orderid).get().then((value) {
        if (value.exists)
          injectionmodels.add(injectionhallmodel.fromjson(value.data()));
      });

      return right(injectionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  Future<Either<failure, String>> editstatus(
      {required injectionhallmodel injectionmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionshall")
          .doc("${injectionmodel.ordernumber}")
          .update({"status": true});
      return right("تم تسجيل بيانات التقرير بنجاح");

      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addinjectionsub(
      {required injectionusagemodel injectionmodel,
      required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionshall")
          .doc("${docid}")
          .collection("${docid}")
          .doc("${injectionmodel.ordernumber}")
          .set(injectionmodel.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteinjectionsub(
      {required injectionusagemodel prduction, required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionshall")
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

  @override
  Future<Either<failure, List<injectionusagemodel>>> getinjectionssub(
      {required String docid}) async {
    List<injectionusagemodel> injectionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionshall");

      await user
          .doc("${docid}")
          .collection("${docid}")
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          injectionmodels.add(injectionusagemodel.fromjson(element.data()));
        });
      });
      return right(injectionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updateorder(
      {required injectionhallmodel injectionmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionshall")
          .doc("${injectionmodel.ordernumber}")
          .update(injectionmodel.tojson());
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
