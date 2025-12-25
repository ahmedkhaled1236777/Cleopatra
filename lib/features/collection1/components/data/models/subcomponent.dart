class Subcomponent {
  final String name;
  final String qty;
  final String weight;

  Subcomponent({required this.name, required this.qty, required this.weight});
  tojson() => {
        "name": name,
        "qty": qty,
        "weight": weight,
      };
  factory Subcomponent.fromjson(var data) {
    return Subcomponent(
        name: data["name"], qty: data["qty"], weight: data["weight"]);
  }
}
