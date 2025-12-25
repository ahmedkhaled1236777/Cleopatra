import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class custommaterialbutton extends StatelessWidget {
Color color;
 
  final void Function()? onPressed;
  // ignore: non_constant_identifier_names
  final String button_name;
  // ignore: non_constant_identifier_names
   custommaterialbutton(
      {super.key,
      this.onPressed,
      this.color=appcolors.primarycolor,
      required this.button_name,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width > 950 ? 20 : 15),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(
              button_name,
              style:
                 const TextStyle(fontFamily: "cairo",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
