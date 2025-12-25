import 'package:cloud_firestore/cloud_firestore.dart';

class Workercomodel {
  final String name;
  final num time;
  final String job;
  final String date;
  final num quantity;

  Workercomodel(
      {required this.name,
      required this.time,
      required this.job,
      required this.date,
      required this.quantity});
  tojson() => {
        "name": name,
        "time": time,
        "job": job,
        "date": date,
        "quantity": quantity,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory Workercomodel.fromjson(var data) {
    return Workercomodel(
      name: data["name"],
      time: data["time"],
      date: data["date"],
      job: data["job"],
      quantity: data["quantity"],
    );
  }
}
