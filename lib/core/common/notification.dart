import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

sendnotification({required String data, Widget? page}) async {
  String uri = 'https://onesignal.com/api/v1/notifications';
  var url = Uri.parse(uri);

  await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Basic YTY1MjA0NGUtMWJjOS00NTg4LTgyNWYtZjRiNjY3MGUwMWZk',
    },
    body: jsonEncode(
      <String, dynamic>{
        "app_id": "aecb54c7-90d3-48aa-a37f-b55fe381c10a",
        "included_segments": ["All"],
        "data": {"foo": "bar"},
        "contents": {"en": data},
      },
    ),
  );
  /*.then((onValue) async {
    await FirebaseFirestore.instance.collection("notifications").doc().set({
      "content": data,
      "timestamp": FieldValue.serverTimestamp(),
      "date":
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      "time": "${DateTime.now().hour}-${DateTime.now().minute}"
    });
  });*/
}

sendnotificationtospecificperson(
    {required String data, Widget? page, required String playerid}) async {
  String uri = 'https://onesignal.com/api/v1/notifications';
  var url = Uri.parse(uri);

  await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Basic YTY1MjA0NGUtMWJjOS00NTg4LTgyNWYtZjRiNjY3MGUwMWZk',
    },
    body: jsonEncode(
      <String, dynamic>{
        "app_id": "aecb54c7-90d3-48aa-a37f-b55fe381c10a",
        "include_player_ids": [playerid],
        "data": {"foo": "bar"},
        "contents": {"en": data},
      },
    ),
  );
  /*.then((onValue) async {
    await FirebaseFirestore.instance.collection("notifications").doc().set({
      "content": data,
      "timestamp": FieldValue.serverTimestamp(),
      "date":
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      "time": "${DateTime.now().hour}-${DateTime.now().minute}"
    });
  });*/
}

Future<void> checkCurrentPlayerId() async {
  var status = await OneSignal.User.pushSubscription.id;
  if (status != null) {
    print("Current player ID: ${status!}");
  }
}
