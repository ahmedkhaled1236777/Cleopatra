import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableproductionsusageitem extends StatelessWidget {
  final String date;
  final String name;
  final String quantaity;
  final String line;

  Widget delet;
TextStyle  textStyle=TextStyle(fontSize: 12,fontFamily: "cairo",color: appcolors.maincolor);

   customtableproductionsusageitem({super.key, required this.date, required this.name, required this.line,required this.quantaity,required this.delet,});
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
                name,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
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
              flex: 2,
              child: Text(
                line,
                style: textStyle,
                textAlign: TextAlign.center,
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
