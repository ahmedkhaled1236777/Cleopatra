import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableemployeeitem extends StatelessWidget {
  final String employeename;
  final String job;
  final String phone;
  final bool status;

  Widget edit;
  TextStyle textStyle;
  double iconsize;
  // ignore: non_constant_identifier_names
  customtableemployeeitem(
      {super.key,
      required this.employeename,
      required this.phone,
      required this.status,
      required this.job,
      required this.edit,
      this.iconsize = 22,
      this.textStyle = const TextStyle(
          fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor)});

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
              employeename,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                job,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                phone,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: status ? Colors.black : Colors.green,
              )),
          Expanded(
            child: edit,
            flex: 2,
          ),
        ],
      ),
    );
  }
}
