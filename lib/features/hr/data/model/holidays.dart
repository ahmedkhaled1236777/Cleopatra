class holiday {
  final String date;
  final String notes;

  holiday({
    required this.date,
    required this.notes,
  });
  tojson() => {
        "name": "",
        "date": date,
        "notes": notes,
        "status": "رسميه",
        "type": "اجازه",
      };
  factory holiday.fromjson(var data) {
    return holiday(
      date: data["date"],
      notes: data["notes"],
    );
  }
}
