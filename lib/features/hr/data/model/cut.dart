class cutmodel {
  final double numberofcuts;
  final String name;
  final String date;
  final String notes;

  cutmodel({
    required this.numberofcuts,
    required this.date,
    required this.name,
    required this.notes,
  });
  tojson() => {
        "numberofcuts": numberofcuts,
        "name": name,
        "date": date,
        "notes": notes,
      };
  factory cutmodel.fromjson(var data) {
    return cutmodel(
      numberofcuts: data["numberofcuts"],
      name: data["name"],
      date: data["date"],
      notes: data["notes"],
    );
  }
}
