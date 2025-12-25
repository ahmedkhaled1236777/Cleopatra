import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtableinjectionmachineitem extends StatelessWidget {
  final String injectionmachinename;
  final String injectionmachinenumber;

  Widget delet;
    Widget edit;

  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtableinjectionmachineitem(
      {super.key,
      required this.injectionmachinename,
      required this.injectionmachinenumber,
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
              injectionmachinename,
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
                injectionmachinenumber,
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
