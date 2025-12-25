import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';

class Injectionworkermodel {
  final String workernumber;
  final String workername;
  final double workersalary;
  final double workerhours;

  Injectionworkermodel({required this.workernumber, required this.workername, required this.workersalary, required this.workerhours});
  tojson()=>{
    "workernumber":workernumber,
    "workername":workername,
    "workersalary":workersalary,
    "workerhours":workerhours
  };
  factory Injectionworkermodel.fromjson(var data){
    return Injectionworkermodel(workernumber: data["workernumber"],
     workername: data["workername"], workersalary: data["workersalary"],
      workerhours: data["workerhours"]);
  }
}
