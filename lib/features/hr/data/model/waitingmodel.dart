class waitingmodel {
  final String date;
  final String name;
  final String status;
  final String notes;
  final String type;
  String? starthour;
  String? timeto;
  double? money;

  waitingmodel(
      {required this.date,
      required this.name,
      required this.status,
      required this.notes,
      required this.type,
      this.starthour,
      this.timeto,
      this.money});
  factory waitingmodel.fromjson(var data) {
    return waitingmodel(
        date: data["date"],
        name: data["name"],
        starthour: data["starthour"] ?? "لا يوجد",
        timeto: data["endhour"] ?? "لا يوجد",
        money: data["moneypackage"] ?? 0.0,
        status: data["status"],
        notes: data["notes"],
        type: data["type"]);
  }
}
