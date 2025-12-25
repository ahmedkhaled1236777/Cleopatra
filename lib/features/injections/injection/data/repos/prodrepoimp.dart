import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel%20copy.dart';
import 'package:cleopatra/features/injections/injection/data/models/diagnosemodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/ordermodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/data/models/timermodel.dart';
import 'package:cleopatra/features/injections/injection/data/repos/prodrepo.dart';

class productionrepoimplementation extends productionrepo {
  @override
  Future<Either<failure, String>> adddiagnose(
      {required Diagnosemodel diagnose}) async {
    try {
      await FirebaseFirestore.instance
          .collection("diagnoses")
          .doc()
          .set(diagnose.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addproduction(
      {required productionmodel productionmodel}) async {
    final transaction = FirebaseFirestore.instance.batch();
    final firstref = FirebaseFirestore.instance
        .collection("productions")
        .doc("${productionmodel.date}")
        .collection("${productionmodel.date}")
        .doc(productionmodel.docid);
    transaction.set(firstref, productionmodel.tojson());
    final seconref = FirebaseFirestore.instance
        .collection("injectionshall")
        .doc("${productionmodel.ordernuber}")
        .collection("${productionmodel.ordernuber}")
        .doc(
            "${productionmodel.date}-${productionmodel.shift}-${productionmodel.machinenumber}-${productionmodel.docid}");
    transaction.set(
        seconref,
        injectionusagemodel(
                scrap: productionmodel.scrapcountity,
                workhours: productionmodel.workhours,
                stoptime: productionmodel.machinestop,
                expectedprod: productionmodel.expectedprod,
                diagnoses: productionmodel.diagnoses,
                date: productionmodel.date,
                machine: productionmodel.machinenumber,
                shift: productionmodel.shift,
                ordernumber: productionmodel.ordernuber!,
                quantity: productionmodel.storequantity!,
                status: "لا")
            .tojson());
             final thirdref =  await FirebaseFirestore.instance
          .collection("moldusages")
          .doc("${productionmodel.prodname}");
          transaction
          .update(thirdref,{"numberofuses": FieldValue.increment(int.parse(productionmodel.counterend))});
      

    
    try {
      await transaction.commit();
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<productionmodel>>> getproductions(
      {required String date}) async {
    List<productionmodel> productionmodels = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("productions");

      await user
          .doc(date)
          .collection(date)
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          productionmodels.add(productionmodel.fromjson(element.data(),
              dta: element.data()["ordernuber"] ?? element.data()["ordernuber"],
              color: element.data()["color"] ?? element.data()["color"]));
        });
      });
      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
Future<Either<failure, String>> deleteproduction(
    {required productionmodel prduction}) async {
  try {
    final batch = FirebaseFirestore.instance.batch();

    // 1. First Deletion
    final firstref = FirebaseFirestore.instance
        .collection("productions")
        .doc(prduction.date)
        .collection(prduction.date)
        .doc(prduction.docid);
    batch.delete(firstref);

    // 2. Second Deletion
    final secondref = FirebaseFirestore.instance
        .collection("injectionshall")
        .doc(prduction.ordernuber)
        .collection("${prduction.ordernuber}")
        .doc(
            "${prduction.date}-${prduction.shift}-${prduction.machinenumber}-${prduction.docid}");
    batch.delete(secondref);

    // 3. Update (uses FieldValue.increment)
    final thirdref = FirebaseFirestore.instance
        .collection("moldusages")
        .doc("${prduction.prodname}");
    
    // Note: You can use update() in a batch.
    batch.update(thirdref, {
      "numberofuses": FieldValue.increment(-int.parse(prduction.counterend))
    });

    await batch.commit(); // Execute all operations

    return right("تم حذف تقرير الماكينه بنجاح");
  } catch (e) {
    return left(requestfailure(error_message: e.toString()));
  }
}

  @override
  Future<Either<failure, List<productionmodel>>> searchproductions(
      {String? date, String? machinenumber, String? shift}) async {
    List<productionmodel> productionmodels = [];
    try {
      CollectionReference user =
          await FirebaseFirestore.instance.collection("productions");
      if (date != null) {
        await user
            .doc(date)
            .collection(date)
            .orderBy("timestamp", descending: true)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            if (machinenumber == null && shift == null) {
              productionmodels.add(productionmodel.fromjson(element.data(),
                  dta: element.data()["ordernuber"] ??
                      element.data()["ordernuber"],
                  color: element.data()["color"] ?? element.data()["color"]));
            } else if (machinenumber != null && shift == null) {
              if (element.data()["machinenumber"] == machinenumber)
                productionmodels.add(productionmodel.fromjson(element.data(),
                    dta: element.data()["ordernuber"] ??
                        element.data()["ordernuber"],
                    color: element.data()["color"] ?? element.data()["color"]));
            } else if (machinenumber == null && shift != null) {
              if (element.data()["shift"] == shift)
                productionmodels.add(productionmodel.fromjson(element.data(),
                    dta: element.data()["ordernuber"] ??
                        element.data()["ordernuber"],
                    color: element.data()["color"] ?? element.data()["color"]));
            } else if (machinenumber != null && shift != null) {
              if (element.data()["shift"] == shift &&
                  element.data()["machinenumber"] == machinenumber)
                productionmodels.add(productionmodel.fromjson(element.data()));
            }
          });
        });
      }

      return right(productionmodels);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addorder({required Ordermodel order}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionorders")
          .doc(order.ordernumber)
          .set({
        "ordername": order.ordername,
        "resetquantity": order.resetquantity,
        "ordernumber": order.ordernumber,
        "color": order.color,
        "quantitu": order.quantitu,
        "status": order.status,
        "notes": order.notes,
        "timestamp": FieldValue.serverTimestamp(),
      });

      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      print(e.toString());
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addtimer({required timermodel timer}) async {
    try {
      await FirebaseFirestore.instance
          .collection("timers")
          .doc(timer.id)
          .set(timer.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletetimer(
      {required timermodel timer}) async {
    try {
      await FirebaseFirestore.instance
          .collection("timers")
          .doc(timer.id)
          .delete();
      return right("تم حذف البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<timermodel>>> gettimers() async {
    List<timermodel> timers = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("timers");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          timers.add(timermodel.fromjson(element.data()));
        });
      });
      return right(timers);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> updatetimer(
      {required timermodel timer}) async {
    try {
      await FirebaseFirestore.instance
          .collection("timers")
          .doc(timer.id)
          .update({
        "secondsperpiece": timer.secondsperpiece,
        "weight": timer.weight,
        "numberofpieces": timer.numberofpieces,
        "materialtype": timer.materialtype,
        "sprueweight": timer.sprueweight,
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Diagnosemodel>>> getdiagnose() async {
    List<Diagnosemodel> diagnoses = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("diagnoses");

      await user.get().then((value) {
        value.docs.forEach((element) {
          diagnoses.add(Diagnosemodel.fromjson(element));
        });
      });
      return right(diagnoses);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
