import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablepaintreportsitem extends StatelessWidget {
  final String prodname;
  final String productquantity;
  final String injscrap;
  final String paintscrap;

  Widget delet;
  Widget checkbox;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtablepaintreportsitem(
      {super.key,
      required this.prodname,
      required this.productquantity,
      required this.injscrap,
      required this.paintscrap,
      required this.delet,
      required this.checkbox});
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
                prodname,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                productquantity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                paintscrap,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                injscrap,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: checkbox,
          ),
          Expanded(
            flex: 2,
            child: delet,
          ),
        ],
      ),
    );
  }
}
