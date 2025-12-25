import 'package:flutter/material.dart';

class customheadertable extends StatelessWidget {
  int flex;
  String? tabletormobile;
  final String title;
   TextStyle textStyle=TextStyle(fontSize: 12,fontFamily: "cairo",color: Colors.white);
  customheadertable(
      {this.flex = 3,
      required this.title,
      this.tabletormobile,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
