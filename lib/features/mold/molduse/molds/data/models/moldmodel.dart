import 'package:cloud_firestore/cloud_firestore.dart';

class moldusagemodel{
  final String moldname;
  final int numberofuses;
  final double  can;
  final double glutinous;
  final double  bag;
  final double karton;

  moldusagemodel({ required this.numberofuses,required this.moldname,required this.bag,required this.can,required this.karton,required this.glutinous});
  tojson()=>{
   "moldname":moldname,
    "timestamp":FieldValue.serverTimestamp(),
    "numberofuses":numberofuses,
    "can":can,
    "glutinous":glutinous,
    "karton":karton,
    "bag":bag,
  };
  factory moldusagemodel.fromjson(var data){
    return moldusagemodel( numberofuses: data["numberofuses"],
     moldname: data["moldname"],
     can: data["can"],
     glutinous: data["glutinous"],
     bag: data["bag"],
     karton: data["karton"],
     
     
     );
  }
}