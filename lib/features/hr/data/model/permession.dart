import 'package:cleopatra/core/common/constants.dart';

class Permession {
  final String date;
  final String starthour;
  final String endhour;

  Permession(
      {required this.date, required this.starthour, required this.endhour});
  tojson() => {"date": date, "starthour": starthour, "endhour": endhour};
  factory Permession.fromjson(var data) {
    return Permession(
        date: data["date"],
        starthour: data["starthour"],
        endhour: data["endhour"]);
  }
}
