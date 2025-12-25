import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class Customtabletimeritem extends StatelessWidget {
  final String mold;
  final String materialtype;
  final double time;
  final String weight;
  final String numberofpieces;

  final Widget delete;
  final Widget edit;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  Customtabletimeritem(
      {super.key,
      required this.mold,
      required this.materialtype,
      required this.time,
      required this.numberofpieces,
      required this.weight,
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
              mold,
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
              materialtype,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: Text(
              numberofpieces,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                time.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                weight.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: edit),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
