import 'package:cloud_firestore/cloud_firestore.dart';

class Workermodel {
  final String workername;
  final String date;
  final int prodquantity;
  final String prodname;
  final String month;
  final String notes;
  final double per;

  Workermodel(
      {required this.workername,
      required this.prodquantity,
      required this.prodname,
      required this.notes,
      required this.month,
      required this.date,
      required this.per});
  tojson() => {
        "workername": workername,
        "per": per,
        "date": date,
        "month": month,
        "prodname": prodname,
        "notes": notes,
        "prodquantity": prodquantity,
        "timestamp": FieldValue.serverTimestamp(),
      };
  factory Workermodel.fromjson(var data) {
    return Workermodel(
        workername: data["workername"],
        prodquantity: data["prodquantity"],
        month: data["month"],
        notes: data["notes"],
        prodname: data["prodname"],
        date: data["date"],
        per: data["per"]);
  }
}
