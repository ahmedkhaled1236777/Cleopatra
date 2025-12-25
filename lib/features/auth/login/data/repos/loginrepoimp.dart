import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cleopatra/core/common/errors/failure.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/data/repos/loginrepo.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';

class authrepoimp extends authrepo {
  @override
  Future<Either<failure, Signmodelrequest>> sign(
      {required String email, required String pass}) async {
    try {
      CollectionReference user = FirebaseFirestore.instance.collection("users");

      var data = await user.doc(email).get();
      if (!data.exists) {
        return left(
            requestfailure(error_message: "هذا الايميل ليس مسجل لدينا"));
      } else {
        final key = Key.fromBase64('yE9tgqNxWcYDTSPNM+EGQw==');
        ;
        final iv = IV.fromBase64('8PzGKSMLuqSm0MVbviaWHA==');
        final encrypter = Encrypter(AES(key));

        final decrypted =
            encrypter.decrypt(Encrypted.fromBase64(data["password"]), iv: iv);

        if (pass == decrypted) {
          return right(Signmodelrequest.fromjson(data: data));
        } else
          return left(requestfailure(error_message: "كلمة المرور غير صحيحه"));
      }
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> resetpass({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return right("يرجاء فحص البريد الالكتروني لتغيير كلمة المرور");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> logout() async {
    try {
      await cashhelper.cleardata();
      return right("تم تسجيل الخروج بنجاح");
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> signup(
      {required Signmodelrequest signup}) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(signup.email)
          .get();
      if (doc.exists) {
        return left(
            requestfailure(error_message: "هذا الايميل مسجل لدينا من قبل"));
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(signup.email)
          .set(signup.tojson());
      return right("تم تسجيل البيانات بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Signmodelrequest>> getprofile(
      {required String email}) async {
    try {
      CollectionReference user = FirebaseFirestore.instance.collection("users");

      var data = await user.doc(email).get();
      return right(Signmodelrequest.fromjson(data: data));
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
