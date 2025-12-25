import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class Customtableaverageitem extends StatelessWidget {
  final String job;
  final double rate;
  Widget checkbox;

  final Widget edit;
  final Widget delete;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  Customtableaverageitem(
      {super.key,
      required this.job,
      required this.checkbox,
      required this.rate,
      required this.edit,
      required this.delete});

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
              job,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                rate.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: checkbox),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: edit),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
