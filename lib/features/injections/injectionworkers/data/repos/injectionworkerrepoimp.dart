import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/model/injectioworkermodel.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/repos/injectionworkerrepo.dart';

class Injectionworkerrepoimp extends Injectionworkerrepo{
  @override
  Future<Either<failure, String>> addInjectionworker({required Injectionworkermodel Injectionworkermodel}) async {
    try {
         var exis = await FirebaseFirestore.instance
                                        .collection("injectionworkers")
                                        .doc("${Injectionworkermodel.workername}}")
                                        .get();
                                    if (exis.exists) {
                                     return left(requestfailure(error_message:"هذا العامل مسجله لدينا"));
                                    } 
                                    else{
      await FirebaseFirestore.instance
          .collection("injectionworkers")
          .doc(
              "${Injectionworkermodel.workername}")
          .set(Injectionworkermodel.tojson());
      
      return right("تم تسجيل الماكينه بنجاح");}
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteInjectionworker({required Injectionworkermodel Injectionworkermodel}) async {
  try {
      await FirebaseFirestore.instance.collection("injectionworkers").doc("${Injectionworkermodel.workername}").delete();

      return right("تم حذف العامل بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editInjectionworker({required Injectionworkermodel Injectionworkermodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionworkers")
          .doc("${Injectionworkermodel.workername}")
          .update({
    "workername":Injectionworkermodel.workername,
    "workersalary":Injectionworkermodel.workersalary,
    "workerhours":Injectionworkermodel.workerhours
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Injectionworkermodel>>> getInjectionworkers() async {
    List<Injectionworkermodel> workers = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionworkers");

      await user.get().then((value) {
        value.docs.forEach((element) {
          workers.add(Injectionworkermodel.fromjson(element));
        });
      });
      return right(workers);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
  
}