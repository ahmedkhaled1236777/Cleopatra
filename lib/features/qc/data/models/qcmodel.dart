import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cleopatra/core/common/errors/handlingerror.dart';

class qcmodel {
  final String date;
  final String checktime;
  final String starttime;
  final String machinenumber;
  final String productname;
  final String prodctcolor;
 final String endtime;
    final List<dynamic>  cause;
  final String notes;
  final String qcengineer;
   String? docid;

  qcmodel({required this.date, required this.machinenumber,required this.checktime,required this.prodctcolor,required this.productname,required this.starttime, required this.cause, required this.notes,required this.endtime ,required this.qcengineer,  this.docid});
  tojson()=>{
    "date":date,
    "starttime":starttime,
    "checktime":checktime,
    "endtime":endtime,
    "cause":cause,
    "notes":notes,
    "qcengineer":qcengineer,
    "docid":docid,
    "machinenumber":machinenumber,
    "prodctcolor":prodctcolor,
    "productname":productname,
            "timestamp": FieldValue.serverTimestamp(),


  };
  factory qcmodel.fromjson(var data){
  return qcmodel(date: data["date"], machinenumber: data["machinenumber"], 
  checktime: data["checktime"],
  endtime: data["endtime"],
  prodctcolor: data["prodctcolor"], productname: data["productname"], starttime: data["starttime"], 
  cause: data["cause"], notes: data["notes"], qcengineer: data["qcengineer"], docid: data["docid"]);
  }
}