import 'package:cloud_firestore/cloud_firestore.dart';

class Signmodelrequest {
  final String email;
  final String phone;
  final String name;
  final String job;
  final bool admin;
  String? img;
  final bool block;
  String? password;
  final List<dynamic> permessions;

  Signmodelrequest(
      {required this.email,
      required this.phone,
      required this.admin,
      required this.name,
      required this.img,
      required this.job,
      required this.block,
      required this.password,
      required this.permessions});
  tojson() => {
        "email": email,
        "phone": phone,
        "admin": admin,
        if (password != null) "password": password,
        "job": job,
        if (img != null) "img": img,
        "name": name,
        "block": block,
        "permessions": permessions,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory Signmodelrequest.fromjson({required var data}) {
    return Signmodelrequest(
        email: data["email"],
        phone: data["phone"],
        admin: data["admin"] ?? false,
        name: data["name"],
        img: data["img"],
        job: data["job"],
        block: data["block"],
        password: data["password"],
        permessions: data["permessions"]);
  }
}
