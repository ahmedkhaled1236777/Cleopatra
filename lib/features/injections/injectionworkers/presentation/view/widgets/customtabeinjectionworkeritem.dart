import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableinjectionworkeritem extends StatelessWidget {
  final String injectionworkername;
  final String injectionworkernumber;
  final String workerhours;

  Widget delet;
    Widget edit;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtableinjectionworkeritem(
      {super.key,
      required this.injectionworkername,
      required this.injectionworkernumber,
      required this.workerhours,
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
              injectionworkername,
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
                injectionworkernumber,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
        
        
            Expanded(
              flex: 3,
              child: Text(
                workerhours,
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
