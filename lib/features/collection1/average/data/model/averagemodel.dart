import 'package:cloud_firestore/cloud_firestore.dart';

class averagemodel {
  final double secondsperpiece;
  final String job;
  final String prieceofpiece;
  final String id;

  averagemodel(
      {required this.secondsperpiece,
      required this.job,
      required this.id,
      required this.prieceofpiece});
  tojson() => {
        "secondsperpiece": secondsperpiece,
        "prieceofpiece": prieceofpiece,
        "job": job,
        "id": id,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory averagemodel.fromjson(var data) {
    return averagemodel(
        secondsperpiece: data["secondsperpiece"],
        prieceofpiece: data["prieceofpiece"] ?? "0",
        job: data["job"],
        id: data["id"]);
  }
}
