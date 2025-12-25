import 'package:cloud_firestore/cloud_firestore.dart';

class productionusagemodel{
  final String date;
  final String quantity;
  final String ordernumber;
  final String status;
  productionusagemodel({required this.date,required this.ordernumber ,required this.quantity,required this.status});
  

  tojson()=>{
    "date":date,
    "quantity":quantity,
   "ordernumber":ordernumber,
   "status":status,
     "timestamp":FieldValue.serverTimestamp()

  };
  factory productionusagemodel.fromjson(var data){
    return productionusagemodel(date:data["date"], 
    ordernumber: data["ordernumber"],
    status: data["status"],
    quantity: data["quantity"]
    
);
  }
  
  
  }