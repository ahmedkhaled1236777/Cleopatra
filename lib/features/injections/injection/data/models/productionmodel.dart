import 'package:cloud_firestore/cloud_firestore.dart';

class productionmodel {
  final String date;
  final String workername;
  final String machinenumber;
  final String prodname;
  final String cycletime;
  final String numberofpieces;
  final String workhours;
  final String counterstart;
  final String counterend;
  final String realprodcountity;
  final String expectedprod;
  final String scrapcountity;
  final String proddivision;
  final String machinestop;
  final String notes;
  final String shift;
  final List<dynamic> diagnoses;
  final String docid;
  String? storequantity;
  String? ordernuber;
  String? color;
  productionmodel(
      {required this.date,
      this.ordernuber,
      this.color,
      this.storequantity,
      required this.workername,
      required this.docid,
      required this.machinenumber,
      required this.shift,
      required this.diagnoses,
      required this.prodname,
      required this.cycletime,
      required this.numberofpieces,
      required this.workhours,
      required this.counterstart,
      required this.counterend,
      required this.realprodcountity,
      required this.expectedprod,
      required this.scrapcountity,
      required this.proddivision,
      required this.machinestop,
      required this.notes});

  tojson() => {
        "date": date,
        "shift": shift,
        "diagnoses": diagnoses,
        "workername": workername,
        "storequantity": storequantity,
        "machinenumber": machinenumber,
        "prodname": prodname,
        "cycletime": cycletime,
        "numberofpieces": numberofpieces,
        "workhours": workhours,
        "counterstart": counterstart,
        "counterend": counterend,
        "realprodcountity": realprodcountity,
        "expectedprod": expectedprod,
        "scrapcountity": scrapcountity,
        "proddivision": proddivision,
        "machinestop": machinestop,
        "notes": notes,
        "docid": docid,
        "ordernuber": ordernuber,
        "color": color,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory productionmodel.fromjson(var data, {String? dta, String? color}) {
    return productionmodel(
        date: data["date"],
        docid: data["docid"],
        shift: data["shift"],
        diagnoses: data["diagnoses"] ?? [],
        storequantity: data["storequantity"],
        ordernuber: dta,
        color: color,
        workername: data["workername"],
        machinenumber: data["machinenumber"],
        prodname: data["prodname"],
        cycletime: data["cycletime"],
        numberofpieces: data["numberofpieces"],
        workhours: data["workhours"],
        counterstart: data["counterstart"],
        counterend: data["counterend"],
        realprodcountity: data["realprodcountity"],
        expectedprod: data["expectedprod"],
        scrapcountity: data["scrapcountity"],
        proddivision: data["proddivision"],
        machinestop: data["machinestop"],
        notes: data["notes"]);
  }
}
