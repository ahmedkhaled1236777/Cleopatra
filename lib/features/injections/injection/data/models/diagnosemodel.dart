class Diagnosemodel {
  final String diagnose;
  final String fix;

  Diagnosemodel({required this.diagnose, required this.fix});
  tojson() => {"diagnose": diagnose, "fix": fix};
  factory Diagnosemodel.fromjson(var data) {
    return Diagnosemodel(diagnose: data["diagnose"], fix: data["fix"]);
  }
}
