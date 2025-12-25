import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String workername;
  final String code;

  Worker({required this.workername, required this.code});
  tojson() => {
        "workername": workername,
        "code": code,
        "timestamp": FieldValue.serverTimestamp(),
      };
  factory Worker.fromjson(var data) {
    return Worker(workername: data["workername"], code: data["code"]);
  }
}
