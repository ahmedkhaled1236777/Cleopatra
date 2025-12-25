import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/model/injectionmaterialmodel.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/repos/injectionmaterialrepo.dart';


class Injectionmaterialrepoimp extends Injectionmaterialrepo{
  @override
  Future<Either<failure, String>> addInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel}) async {
    try {
         var exis = await FirebaseFirestore.instance
                                        .collection("injectionmaterials")
                                        .doc("${Injectionmaterialmodel.materialname}}")
                                        .get();
                                    if (exis.exists) {
                                     return left(requestfailure(error_message:"هذه الخامه مسجله لدينا"));
                                    } 
                                    else{
      await FirebaseFirestore.instance
          .collection("injectionmaterials")
          .doc(
              "${Injectionmaterialmodel.materialname}")
          .set(Injectionmaterialmodel.tojson());
      
      return right("تم تسجيل الخامه بنجاح");}
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel}) async {
  try {
      await FirebaseFirestore.instance.collection("injectionmaterials").doc("${Injectionmaterialmodel.materialname}").delete();

      return right("تم حذف الخامه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editInjectionmaterial({required Injectionmaterialmodel Injectionmaterialmodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionmaterials")
          .doc("${Injectionmaterialmodel.materialname}")
          .update({
    "purematerialcost":Injectionmaterialmodel.purematerialcost,
    "breakmaterialcost":Injectionmaterialmodel.breakmaterialcost
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Injectionmaterialmodel>>> getInjectionmaterials() async {
    List<Injectionmaterialmodel> materials = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionmaterials");

      await user.get().then((value) {
        value.docs.forEach((element) {
          materials.add(Injectionmaterialmodel.fromjson(element));
        });
      });
      return right(materials);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
  
}