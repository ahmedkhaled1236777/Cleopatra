import 'package:cloud_firestore/cloud_firestore.dart';

class Paintmodel {
  final String date;
  final String name;
  final String quantity;
  final String ordernumber;
  final String boyacode;
  final String warnishcode;
  final String prodcode;
  final int actualprod;
  final int scrapquantity;
  final String notes;
  final bool status;
  bool? update;
  Paintmodel({
    required this.date,
    required this.status,
    required this.prodcode,
    required this.notes,
    required this.scrapquantity,
    required this.actualprod,
    required this.ordernumber,
    required this.warnishcode,
    required this.boyacode,
    required this.name,
    required this.quantity,
  });

  tojson() => {
        "date": date,
        "name": name,
        "notes": notes,
        "prodcode": prodcode,
        "quantity": quantity,
        "ordernumber": ordernumber,
        "boyacode": boyacode,
        "warnishcode": warnishcode,
        "actualprod": actualprod,
        "scrapquantity": scrapquantity,
        "status": status,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory Paintmodel.fromjson(var data) {
    return Paintmodel(
        date: data["date"],
        prodcode: data["prodcode"],
        notes: data["notes"],
        status: data["status"],
        warnishcode: data["warnishcode"],
        boyacode: data["boyacode"],
        ordernumber: data["ordernumber"],
        scrapquantity: data["scrapquantity"],
        actualprod: data["actualprod"],
        name: data["name"],
        quantity: data["quantity"]);
  }
}
