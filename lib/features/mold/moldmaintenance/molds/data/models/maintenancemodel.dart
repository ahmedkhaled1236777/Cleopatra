import 'package:cloud_firestore/cloud_firestore.dart';

class maintenancemodel{
  final String type;
  final String cause;
   String status;
  final String moldname;
   String notes;
   String ?godate;
   String ?retrundate;
 String? location;

  maintenancemodel({ required this.status,  required this.cause,required this.notes,this.godate,this.retrundate,required this.type,required this.moldname,  this.location});
  tojson()=>{
    "status":status,
    "moldname":moldname,
    "godate":godate,
    "retrundate":retrundate,
    "cause":cause,

    "notes":notes,
    "type":type,
    "timestamp":FieldValue.serverTimestamp(),
    "location":location,
  };
  factory maintenancemodel.fromjson(var data){
    return maintenancemodel( 
    type: data["type"],
   godate :data["godate"],
    retrundate:data["retrundate"],
    notes: data["notes"],
    cause: data["cause"],
     status: data["status"], moldname: data["moldname"], location: data["location"]);
  }
}