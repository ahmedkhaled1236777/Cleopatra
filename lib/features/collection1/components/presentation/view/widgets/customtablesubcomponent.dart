import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablesubcomponentitem extends StatelessWidget {
  final String quantaity;
  final String weigt;
  final String name;
  Widget? delete;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtablesubcomponentitem(
      {super.key,
      this.delete,
      required this.quantaity,
      required this.name,
      required this.weigt});
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
                weigt,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          if (delete != null) Expanded(flex: 2, child: delete!),
        ],
      ),
    );
  }
}
