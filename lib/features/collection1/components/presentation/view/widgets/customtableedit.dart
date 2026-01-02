import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customtablecomponentitem extends StatelessWidget {
  final String name;
  Widget?edit;

TextStyle  textStyle=TextStyle(fontSize: 12,fontFamily: "cairo",color: appcolors.maincolor);

   customtablecomponentitem({super.key, required this.edit,required this.name});
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
              flex: 2,
              child: edit!),
        ],
      ),
    );
  }
}
