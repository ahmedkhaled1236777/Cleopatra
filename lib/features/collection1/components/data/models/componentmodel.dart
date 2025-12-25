import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class componentsmodel{
   int quantity;
   String name;
   String? url;

  componentsmodel({ required this.quantity, required this.name, this.url});
  tojson()=>{
    "quantity":quantity,
    "name":name,
    "url":url,
    "timestamp":FieldValue.serverTimestamp(),
  };
  factory componentsmodel.fromjson(var data){
    return componentsmodel(name: data["name"], 
    url: data["url"],
    quantity: data["quantity"], );
  }
}