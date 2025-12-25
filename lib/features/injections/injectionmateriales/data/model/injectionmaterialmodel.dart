import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';

class Injectionmaterialmodel {
  final String materialname;
  final double purematerialcost;
  final double breakmaterialcost;

  Injectionmaterialmodel({required this.breakmaterialcost, required this.materialname, required this.purematerialcost});
  tojson()=>{
    "materialname":materialname,
    "purematerialcost":purematerialcost,
    "breakmaterialcost":breakmaterialcost
  };
  factory Injectionmaterialmodel.fromjson(var data){
    return Injectionmaterialmodel(breakmaterialcost: data["breakmaterialcost"],
     materialname: data["materialname"], purematerialcost: data["purematerialcost"],
      );
  }
}
