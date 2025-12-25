import 'package:cloud_firestore/cloud_firestore.dart';

class injectioncomodel {
  final String date;
  final String status;
  final String workername;
  final String job;
  final int productionquantity;
  final String notes;
  final String docid;
  String? timefrom;
  String? month;
  String? ordernumber;
  String? timeto;
  injectioncomodel(
      {required this.date,
      required this.status,
      required this.docid,
      this.timefrom,
      this.month,
      this.timeto,
      this.ordernumber,
      required this.productionquantity,
      required this.workername,
      required this.job,
      required this.notes});
  tojson() => {
        "date": date,
        "status": status,
        "workername": workername,
        "timefrom": timefrom,
        "timeto": timeto,
        "month":
            "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().year}",
        "ordernumber": ordernumber,
        "timestamp": FieldValue.serverTimestamp(),
        "notes": notes,
        "job": job,
        "productionquantity": productionquantity,
        "docid": docid
      };
  factory injectioncomodel.fromjson(var data) {
    return injectioncomodel(
        date: data["date"],
        docid: data["docid"],
        timeto: data["timeto"] ?? "لا يوجد",
        timefrom: data["timefrom"] ?? "لا يوجد",
        ordernumber: data["ordernumber"] ?? "لا يوجد",
        month: data["month"] ?? "لا يوجد",
        workername: data["workername"],
        status: data["status"],
        productionquantity: data["productionquantity"],
        notes: data["notes"],
        job: data["job"]);
  }
}
