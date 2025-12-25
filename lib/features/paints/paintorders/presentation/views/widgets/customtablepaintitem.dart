import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablepaintshallitem extends StatelessWidget {
  final String date;
  final String name;
  final String quantaity;
  final String scrapper;
  final String rightper;
  final bool status;

  Widget delet;
  Widget edit;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtablepaintshallitem({
    super.key,
    required this.status,
    required this.date,
    required this.edit,
    required this.scrapper,
    required this.rightper,
    required this.name,
    required this.quantaity,
    required this.delet,
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
              date,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                name,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                quantaity,
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
              flex: 2,
              child: Text(
                scrapper,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: Text(
                rightper,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
