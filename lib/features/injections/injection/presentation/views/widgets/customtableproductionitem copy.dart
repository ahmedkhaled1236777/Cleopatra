import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablorderitem extends StatelessWidget {
  final String name;
  final String ordernumber;
  final String quantaity;
  final String productquantity;
  final bool status;

  Widget delet;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtablorderitem({
    super.key,
    required this.status,
    required this.productquantity,
    required this.name,
    required this.quantaity,
    required this.ordernumber,
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
                name,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                ordernumber,
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
              flex: 3,
              child: Text(
                productquantity,
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
            child: delet,
          ),
        ],
      ),
    );
  }
}
