class money {
  final String name;
  final String date;
  final double moneypackage;
  final String notes;
  final String status;

  money({
    required this.name,
    required this.moneypackage,
    required this.date,
    required this.notes,
    required this.status,
  });
  tojson() => {
    "name": name,
    "moneypackage": moneypackage,
    "notes": notes,
    "status": status,
    "date": date,
    "type": "سلفه",
  };
  factory money.fromjson(var data) {
    return money(
      name: data["name"],
      status: data["status"],
      date: data["date"],
      moneypackage: data["moneypackage"],
      notes: data["notes"],
    );
  }
}
