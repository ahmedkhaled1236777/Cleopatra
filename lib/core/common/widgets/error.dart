import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class errorfailure extends StatelessWidget {
  final String errormessage;

  const errorfailure({super.key, required this.errormessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          width: 250,
          height: 250,
          "assets/images/error.jpg",
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          errormessage,
          style:
              TextStyle(fontSize: 15, fontFamily: "cairo", color: Colors.red),
        )
      ],
    ));
  }
}
