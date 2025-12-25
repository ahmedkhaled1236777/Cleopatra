import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class Customtableallattendanceitem extends StatelessWidget {
  final String name;
  final String attendancedays;
  final String notattendancedays;
  final String daysoff;
  final String salary;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  Customtableallattendanceitem({
    super.key,
    required this.name,
    required this.attendancedays,
    required this.notattendancedays,
    required this.daysoff,
    required this.salary,
  });
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 19),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                attendancedays,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                daysoff,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                notattendancedays,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                salary,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
