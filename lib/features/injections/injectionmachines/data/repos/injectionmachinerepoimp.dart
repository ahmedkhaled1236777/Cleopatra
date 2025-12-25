import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';

import 'package:cleopatra/features/injections/injectionmachines/data/model/injectionmachinemodel.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/repos/injectionmachinerepo.dart';

class Injectionmachinerepoimp extends Injectionmachinerepo{
  @override
  Future<Either<failure, String>> addInjectionmachine({required Injectionmachinemodel Injectionmachinemodel}) async {
    try {
         var exis = await FirebaseFirestore.instance
                                        .collection("injectionmachines")
                                        .doc("${Injectionmachinemodel.machinenumber}}")
                                        .get();
                                    if (exis.exists) {
                                     return left(requestfailure(error_message:"هذه الماكينه مسجله لدينا"));
                                    } 
                                    else{
      await FirebaseFirestore.instance
          .collection("injectionmachines")
          .doc(
              "${Injectionmachinemodel.machinenumber}")
          .set(Injectionmachinemodel.tojson());
      
      return right("تم تسجيل الماكينه بنجاح");}
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteInjectionmachine({required Injectionmachinemodel Injectionmachinemodel}) async {
  try {
      await FirebaseFirestore.instance.collection("injectionmachines").doc("${Injectionmachinemodel.machinenumber}").delete();

      return right("تم حذف تقرير الماكينه بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editInjectionmachine({required Injectionmachinemodel Injectionmachinemodel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("injectionmachines")
          .doc("${Injectionmachinemodel.machinenumber}")
          .update({
    "machinename":Injectionmachinemodel.machinename,
    "machinecost":Injectionmachinemodel.machinecost,
    "machinedeprecation":Injectionmachinemodel.machinedeprecation,
    "machinehourelectriccost":Injectionmachinemodel.machinehourelectriccost
      });

      return right("تم تعديل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<Injectionmachinemodel>>> getInjectionmachines() async {
    List<Injectionmachinemodel> machines = [];
    try {
      CollectionReference user =
          FirebaseFirestore.instance.collection("injectionmachines");

      await user.get().then((value) {
        value.docs.forEach((element) {
          machines.add(Injectionmachinemodel.fromjson(element));
        });
      });
      return right(machines);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
  
}