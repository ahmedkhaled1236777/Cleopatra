import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablepaintsusageitem extends StatelessWidget {
  final String date;
  final String quantaity;
  final String injscrap;
  final String paintscrap;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtablepaintsusageitem({
    super.key,
    required this.date,
    required this.quantaity,
    required this.injscrap,
    required this.paintscrap,
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
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                quantaity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                paintscrap,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                injscrap,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
