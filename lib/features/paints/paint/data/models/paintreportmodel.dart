import 'package:cloud_firestore/cloud_firestore.dart';

class paintreportmodel {
  final String date;
  final String prodname;
  final int actualprodquantity;
  final String workhours;
  final String scrapinjquantity;
  final int scrappaintquantity;
  final String docid;
  final String numberofpiecesinskewer;
  final String numberofskewerintray;
  final String actualdiskes;
  final String boyaweightstart;
  final String boyaweightend;
  final String warnishweightstart;
  final String warnishweightend;
  final String ordernuber;
  final String notes;
  final String numberofworkers;
  paintreportmodel(
      {required this.date,
      required this.numberofskewerintray,
      required this.ordernuber,
      required this.boyaweightstart,
      required this.boyaweightend,
      required this.warnishweightend,
      required this.warnishweightstart,
      required this.numberofworkers,
      required this.scrapinjquantity,
      required this.scrappaintquantity,
      required this.actualdiskes,
      required this.docid,
      required this.prodname,
      required this.numberofpiecesinskewer,
      required this.workhours,
      required this.actualprodquantity,
      required this.notes});

  tojson() => {
        "date": date,
        "ordernuber": ordernuber,
        "boyaweightstart": boyaweightstart,
        "boyaweightend": boyaweightend,
        "warnishweightstart": warnishweightstart,
        "warnishweightend": warnishweightend,
        "numberofskewerintray": numberofskewerintray,
        "scrapinjquantity": scrapinjquantity,
        "scrappaintquantity": scrappaintquantity,
        "actualdiskes": actualdiskes,
        "prodname": prodname,
        "numberofworkers": numberofworkers,
        "docid": docid,
        "workhours": workhours,
        "numberofpiecesinskewer": numberofpiecesinskewer,
        "actualprodquantity": actualprodquantity,
        "notes": notes,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory paintreportmodel.fromjson(var data) {
    return paintreportmodel(
      date: data["date"],
      boyaweightend: data["boyaweightend"],
      warnishweightstart: data["warnishweightstart"],
      boyaweightstart: data["boyaweightstart"],
      warnishweightend: data["warnishweightend"],
      docid: data["docid"],
      numberofskewerintray: data["numberofskewerintray"],
      ordernuber: data["ordernuber"],
      numberofworkers: data["numberofworkers"],
      scrappaintquantity: data["scrappaintquantity"],
      scrapinjquantity: data["scrapinjquantity"],
      actualdiskes: data["actualdiskes"],
      prodname: data["prodname"],
      workhours: data["workhours"],
      numberofpiecesinskewer: data["numberofpiecesinskewer"],
      actualprodquantity: data["actualprodquantity"],
      notes: data["notes"],
    );
  }
}
