import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';

class Injectionmachinemodel {
  final int machinenumber;
  final String machinename;
  final double machinecost;
  final double machinehourelectriccost;
  final double machinedeprecation;

  Injectionmachinemodel({required this.machinenumber,required this.machinedeprecation ,required this.machinename, required this.machinecost, required this.machinehourelectriccost});
  tojson()=>{
    "machinenumber":machinenumber,
    "machinename":machinename,
    "machinecost":machinecost,
    "machinedeprecation":machinedeprecation,
    "machinehourelectriccost":machinehourelectriccost
  };
  factory Injectionmachinemodel.fromjson(var data){
    return Injectionmachinemodel(machinenumber: data["machinenumber"],
     machinename: data["machinename"], machinecost: data["machinecost"],
     machinedeprecation: data["machinedeprecation"],
      machinehourelectriccost: data["machinehourelectriccost"]);
  }
}
