import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablemaintenanceitem extends StatelessWidget {
  final String moldname;
  final String date;
  final String type;
  final String status;

  Widget edit;
TextStyle  textStyle=TextStyle(fontSize: 12,fontFamily: "cairo",color: appcolors.maincolor);

   customtablemaintenanceitem({super.key, required this.moldname,required this.type ,required this.status, required this.date,required this.edit});
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
                moldname,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                type,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
         
          Expanded(
              flex: 3,
              child: Text(
                status,
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
        ],
      ),
    );
  }
}
