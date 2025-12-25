import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableinjectionmaterialitem extends StatelessWidget {
  final String injectionmaterialname;
  final String purematerialcost;
  final String breakmaterialcost;

  Widget delet;
    Widget edit;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtableinjectionmaterialitem(
      {super.key,
      required this.injectionmaterialname,
      required this.purematerialcost,
      required this.breakmaterialcost,
            required this.edit,

      required this.delet});
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
              injectionmaterialname,
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
                purematerialcost,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
        
          Expanded(
              flex: 3,
              child: Text(
                breakmaterialcost,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
        
        
          Expanded(
            flex: 2,
            child: edit,
          ),
           const SizedBox(
            width: 3,
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
