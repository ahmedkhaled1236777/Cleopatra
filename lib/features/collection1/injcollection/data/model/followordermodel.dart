class Followordermodel {
  final String jobname;
  final int quantity;

  Followordermodel({
    required this.jobname,
    required this.quantity,
  });
  factory Followordermodel.foromjson({required var data}) {
    return Followordermodel(
      jobname: data["name"],
      quantity: data["value"],
    );
  }
}
