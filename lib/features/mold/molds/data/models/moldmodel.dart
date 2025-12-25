import 'package:cloud_firestore/cloud_firestore.dart';

class moldmodel {
  final String date;
  final String status;
  final String moldname;
  final String machinenumber;
  final String notes;
  final String time;

  moldmodel(
      {required this.date,
      required this.status,
      required this.machinenumber,
      required this.moldname,
      required this.notes,
      required this.time});
  tojson() => {
        "date": date,
        "status": status,
        "moldname": moldname,
        "time": time,
        "timestamp": FieldValue.serverTimestamp(),
        "notes": notes,
        "machinenumber": machinenumber
      };
  factory moldmodel.fromjson(var data) {
    return moldmodel(
        date: data["date"],
        time: data["time"] ?? "لا يوجد",
        machinenumber: data["machinenumber"],
        status: data["status"],
        moldname: data["moldname"],
        notes: data["notes"]);
  }
}
