class Machinemodel {
  final int date;
  final String notes;
  final String scrap;
  final String performance;
  final String machinestopper;

  Machinemodel(
      {required this.date,
      required this.notes,
      required this.machinestopper,
      required this.scrap,
      required this.performance});
  factory Machinemodel.fromjson(var data) {
    return Machinemodel(
        date: data["date"],
        notes: data["notes"],
        scrap: data["scrapper"],
        machinestopper: data["machinestopper"],
        performance: data["performance"]);
  }
}
