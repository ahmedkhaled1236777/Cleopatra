import 'package:cloud_firestore/cloud_firestore.dart';

class moldusagemodel{
  final String moldname;
  final int numberofuses;

  moldusagemodel({ required this.numberofuses,required this.moldname});
  tojson()=>{
   "moldname":moldname,
    "timestamp":FieldValue.serverTimestamp(),
    "numberofuses":numberofuses,
  };
  factory moldusagemodel.fromjson(var data){
    return moldusagemodel( numberofuses: data["numberofuses"],
     moldname: data["moldname"],);
  }
}