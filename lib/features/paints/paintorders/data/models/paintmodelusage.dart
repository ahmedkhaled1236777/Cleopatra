import 'package:cloud_firestore/cloud_firestore.dart';

class paintusagemodel {
  final String date;
  final int quantity;
  final String ordernumber;
  final String status;
  final String boyaquantity;
  final String injscrapquantity;
  final int paintscrapquantity;
  paintusagemodel(
      {required this.date,
      required this.ordernumber,
      required this.quantity,
      required this.boyaquantity,
      required this.injscrapquantity,
      required this.paintscrapquantity,
      required this.status});

  tojson() => {
        "date": date,
        "quantity": quantity,
        "ordernumber": ordernumber,
        "status": status,
        "boyaquantity": boyaquantity,
        "paintscrapquantity": paintscrapquantity,
        "injscrapquantity": injscrapquantity,
        "timestamp": FieldValue.serverTimestamp(),
      };
  factory paintusagemodel.fromjson(var data) {
    return paintusagemodel(
        date: data["date"],
        ordernumber: data["ordernumber"],
        boyaquantity: data["boyaquantity"],
        injscrapquantity: data["injscrapquantity"],
        paintscrapquantity: data["paintscrapquantity"],
        status: data["status"],
        quantity: data["quantity"]);
  }
}
