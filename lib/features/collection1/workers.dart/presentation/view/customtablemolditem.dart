import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableworkeritem extends StatelessWidget {
  final String workername;
  final String code;
  final Widget delete;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtableworkeritem(
      {super.key,
      required this.workername,
      required this.delete,
      required this.code});

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
              workername,
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
              code,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: delete),
          const SizedBox(
            width: 3,
          ),
        ],
      ),
    );
  }
}
