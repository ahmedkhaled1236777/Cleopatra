import 'package:cloud_firestore/cloud_firestore.dart';

class injectionhallmodel {
  final String date;
  final String name;
  final String machine;
  final String materialtype;
  final String pureper;
  final String breakper;
  final String masterper;
  final String color;
  final String quantity;
  final String producedquantity;
  final String ordernumber;
  final String notes;
  final bool status;
  final bool sprue;
  bool? update;
  injectionhallmodel({
    required this.date,
    required this.producedquantity,
    required this.status,
    required this.sprue,
    required this.notes,
    required this.pureper,
    required this.breakper,
    required this.masterper,
    required this.materialtype,
    required this.machine,
    required this.color,
    this.update = true,
    required this.ordernumber,
    required this.name,
    required this.quantity,
  });

  tojson() => {
        "date": date,
        "name": name,
        "notes": notes,
        "quantity": quantity,
        "pureper": pureper,
        "breakper": breakper,
        "masterper": masterper,
        "materialtype": materialtype,
        "sprue": sprue,
        "machine": machine,
        "ordernumber": ordernumber,
        "producedquantity": producedquantity,
        "status": status,
        "color": color,
        if (update!) "timestamp": FieldValue.serverTimestamp()
      };
  factory injectionhallmodel.fromjson(var data) {
    return injectionhallmodel(
        date: data["date"],
        notes: data["notes"],
        producedquantity: data["producedquantity"],
        machine: data["machine"],
        status: data["status"],
        pureper: data["pureper"] ?? "لا يوجد",
        masterper: data["masterper"] ?? "لا يوجد",
        breakper: data["breakper"] ?? "لا يوجد",
        materialtype: data["materialtype"] ?? "لا يوجد",
        ordernumber: data["ordernumber"],
        sprue: data["sprue"]??true,
        color: data["color"],
        name: data["name"],
        quantity: data["quantity"]);
  }
}
