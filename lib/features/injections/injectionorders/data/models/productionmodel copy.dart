import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';

class injectionusagemodel {
  final String date;
  final String quantity;
  final String ordernumber;
  final String status;
  final String scrap;
  final List<dynamic> diagnoses;
  final String workhours;
  final String stoptime;
  final String expectedprod;
  final String machine;
  String? name;
  String? shift;
  injectionusagemodel(
      {required this.date,
      required this.ordernumber,
      required this.quantity,
      required this.stoptime,
      required this.workhours,
      required this.scrap,
      required this.diagnoses,
      required this.expectedprod,
      this.name,
      required this.machine,
      this.shift,
      required this.status});

  tojson() => {
        "date": date,
        "quantity": quantity,
        "ordernumber": ordernumber,
        "name": cashhelper.getdata(key: "email"),
        "machine": machine,
        "shift": shift,
        "scrap": scrap,
        "workhours": workhours,
        "stoptime": stoptime,
        "diagnoses": diagnoses,
        "expectedprod": expectedprod,
        "status": status,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory injectionusagemodel.fromjson(var data) {
    return injectionusagemodel(
        date: data["date"],
        ordernumber: data["ordernumber"],
        machine: data["machine"] ?? "لا يوجد",
        name: data["name"] ?? "لا يوجد",
        scrap: data["scrap"] ?? "0",
        diagnoses: data["diagnoses"] ?? [],
        stoptime: data["stoptime"] ?? "0",
        workhours: data["workhours"] ?? "0",
        expectedprod: data["expectedprod"] ?? "0",
        shift: data["shift"] ?? "لا يوجد",
        status: data["status"],
        quantity: data["quantity"]);
  }
}
