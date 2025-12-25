import 'package:cloud_firestore/cloud_firestore.dart';

class paintaveragemodel {
  final double secondsperpiece;
  final double boyaweight;
  final String job;
  final String id;

  paintaveragemodel(
      {required this.secondsperpiece,
      required this.job,
      required this.id,
      required this.boyaweight});
  tojson() => {
        "secondsperpiece": secondsperpiece,
        "job": job,
        "boyaweight": boyaweight,
        "id": id,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory paintaveragemodel.fromjson(var data) {
    return paintaveragemodel(
        secondsperpiece: data["secondsperpiece"],
        boyaweight: data["boyaweight"],
        job: data["job"],
        id: data["id"]);
  }
}
