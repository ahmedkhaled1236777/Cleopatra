class Ordermodel {
  final String ordername;
  final String ordernumber;
  final String notes;
  final String color;
  final int quantitu;
  final int resetquantity;
  final bool status;

  Ordermodel(
      {required this.ordername,
      required this.ordernumber,
      required this.quantitu,
      required this.notes,
      required this.color,
      required this.resetquantity,
      required this.status});
  factory Ordermodel.fromjson({var data}) {
    return Ordermodel(
        ordername: data["ordername"],
        resetquantity: data["resetquantity"],
        notes: data["notes"],
        color: data["color"],
        ordernumber: data["ordernumber"],
        quantitu: data["quantitu"],
        status: data["status"]);
  }
}
