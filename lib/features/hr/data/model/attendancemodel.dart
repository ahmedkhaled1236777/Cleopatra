class Attendancemodel {
  final int attendancedays;
  final int daysoff;
  final int notattendance;
  final double permessionhours;
  final double addhours;
  final double cut;
  final String ipadress;

  Attendancemodel({
    required this.attendancedays,
    required this.daysoff,
    required this.notattendance,
    required this.permessionhours,
    required this.ipadress,
    required this.addhours,
    required this.cut,
  });
  factory Attendancemodel.fromjson(var data) {
    return Attendancemodel(
      attendancedays: data["attendancedays"],
      daysoff: data["daysoff"],
      ipadress: data["ipadress"],
      notattendance: data["notattendance"],
      permessionhours: data["permessionhours"],
      addhours: data["addhours"],
      cut: data["cut"],
    );
  }
}
