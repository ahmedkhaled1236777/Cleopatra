class Absensemodel {
  final String name;
  final String date;
  final String notes;

  Absensemodel({
    required this.date,
    required this.name,
    required this.notes,
  });
  tojson() => {
        "name": name,
        "date": date,
        "notes": notes,
      };
  factory Absensemodel.fromjson(var data) {
    return Absensemodel(
      name: data["name"],
      date: data["date"],
      notes: data["notes"],
    );
  }
}
