import 'package:cloud_firestore/cloud_firestore.dart';

class timermodel {
  final double secondsperpiece;
  final String moldname;
  final String weight;
  final String materialtype;
  num sprueweight;
  final String numberofpieces;
  final String id;

  timermodel(
      {required this.secondsperpiece,
      required this.moldname,
      required this.id,
      required this.materialtype,
      required this.sprueweight,
      required this.numberofpieces,
      required this.weight});
  tojson() => {
        "secondsperpiece": secondsperpiece,
        "moldname": moldname,
        "weight": weight,
        "sprueweight": sprueweight,
        "materialtype": materialtype,
        "numberofpieces": numberofpieces,
        "id": id,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory timermodel.fromjson(var data) {
    return timermodel(
        numberofpieces: data["numberofpieces"],
        secondsperpiece: data["secondsperpiece"],
        materialtype: data["materialtype"] ?? "لا يوجد",
        weight: data["weight"],
        sprueweight: data["sprueweight"],
        moldname: data["moldname"],
        id: data["id"]);
  }
}
