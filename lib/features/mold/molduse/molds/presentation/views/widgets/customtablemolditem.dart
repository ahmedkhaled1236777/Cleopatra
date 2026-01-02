import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablemoldusageitem extends StatelessWidget {
  final String moldname;
  final String numberofuses;
  final String karton;
  final String can;
  final String bag;
  final String glutinous;
  Widget edit;

TextStyle  textStyle=TextStyle(fontSize: 12,fontFamily: "cairo",color: appcolors.maincolor);

   customtablemoldusageitem({super.key, required this.moldname, required this.numberofuses,required this.bag,required this.karton,required this.glutinous,required this.can,required this.edit,});
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
              moldname,
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
                numberofuses,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                karton,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                can,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                bag,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: Text(
                glutinous,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 2,
              child: edit),
          const SizedBox(
            width: 3,
          ),
         
         
        ],
      ),
    );
  }
}
