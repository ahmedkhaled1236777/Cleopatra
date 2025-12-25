import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/collection1/components/data/models/componentmodel.dart';
import 'package:cleopatra/features/collection1/components/data/models/subcomponent.dart';
import 'package:cleopatra/features/collection1/components/data/repos/componentsrepo.dart';

class Componentsrepoimp extends componentrepo {
  @override
  Future<Either<failure, String>> addcomponent(
      {required componentsmodel component}) async {
    try {
      await FirebaseFirestore.instance
          .collection("components")
          .doc(component.name)
          .set(component.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editcomponent(
      {required int quantaity,
      required String docid,
      required bool type}) async {
    try {
      type == true
          ? await FirebaseFirestore.instance
              .collection("components")
              .doc(docid)
              .update({"quantity": FieldValue.increment(quantaity)})
          : await FirebaseFirestore.instance
              .collection("components")
              .doc(docid)
              .update({"quantity": FieldValue.increment(-quantaity)});

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<componentsmodel>>> getcomponents() async {
    List<componentsmodel> components = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("components");

      await user.orderBy("timestamp", descending: true).get().then((value) {
        value.docs.forEach((element) {
          components.add(componentsmodel.fromjson(element.data()));
        });
      });
      return right(components);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addsubcomponent(
      {required Subcomponent subcomponet,
      required String componentname}) async {
    try {
      await FirebaseFirestore.instance
          .collection("components")
          .doc(componentname)
          .collection(componentname)
          .doc(subcomponet.name)
          .set(subcomponet.tojson());

      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Subcomponent>>> getsubcomponents(
      {required String componentname}) async {
    List<Subcomponent> subcomponents = [];
    try {
      CollectionReference user = FirebaseFirestore.instance
          .collection("components")
          .doc(componentname)
          .collection(componentname);

      await user.get().then((value) {
        value.docs.forEach((element) {
          subcomponents.add(Subcomponent.fromjson(element));
        });
      });
      return right(subcomponents);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletesubcomponent(
      {required Subcomponent subcomponet,
      required String componentname}) async {
    try {
      await FirebaseFirestore.instance
          .collection("components")
          .doc(componentname)
          .collection(componentname)
          .doc(subcomponet.name)
          .delete();

      return right("تم حذف البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
