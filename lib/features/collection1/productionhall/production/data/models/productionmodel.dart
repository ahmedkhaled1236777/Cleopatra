import 'package:cloud_firestore/cloud_firestore.dart';

class productionhallmodel {
  final String date;
  final String name;
  final String quantity;
  final String line;
  final String ordernumber;
  final String code;
  final bool status;
  productionhallmodel(
      {required this.date,
      required this.status,
      required this.ordernumber,
      required this.name,
      required this.code,
      required this.quantity,
      required this.line});

  tojson() => {
        "date": date,
        "name": name,
        "quantity": quantity,
        "line": line,
        "code": code,
        "ordernumber": ordernumber,
        "status": status,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory productionhallmodel.fromjson(var data) {
    return productionhallmodel(
        date: data["date"],
        status: data["status"],
        ordernumber: data["ordernumber"],
        line: data["line"],
        code: data["code"] ?? "لا يوجد",
        name: data["name"],
        quantity: data["quantity"]);
  }
}
