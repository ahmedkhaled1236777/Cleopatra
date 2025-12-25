import 'package:cloud_firestore/cloud_firestore.dart';

class Workermodelrequest {
  final String name;
  final String job_title;
  final String employment_date;
  final String workhours;
  final String phone;
  final String salary;
  final String deviceip;

  Workermodelrequest(
      {required this.name,
      required this.job_title,
      required this.employment_date,
      required this.phone,
      required this.deviceip,
      required this.workhours,
      required this.salary});
  tojson() => {
        "name": name,
        "employment_date": employment_date,
        "deviceip": deviceip,
        "job_title": job_title,
        "salary": salary,
        "phone": phone,
        "worked_hours": workhours,
        "timestamp": FieldValue.serverTimestamp()
      };
  factory Workermodelrequest.fromjson(var data) {
    return Workermodelrequest(
        name: data["name"],
        job_title: data["job_title"],
        deviceip: data["deviceip"],
        employment_date: data["employment_date"],
        phone: data["phone"],
        workhours: data["worked_hours"],
        salary: data["salary"]);
  }
}
