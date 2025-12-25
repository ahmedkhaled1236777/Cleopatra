import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class Customtablepaintaverageitem extends StatelessWidget {
  final String job;
  final double rate;
  final double boyaweight;

  final Widget edit;
  final Widget delete;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  Customtablepaintaverageitem(
      {super.key,
      required this.job,
      required this.rate,
      required this.boyaweight,
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
          Expanded(
              flex: 3,
              child: Text(
                boyaweight.toStringAsFixed(1),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
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
