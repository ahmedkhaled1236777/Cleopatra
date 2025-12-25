import 'package:flutter/material.dart';

class choosedate extends StatelessWidget {
  final void Function()? onPressed;
  final String date;
  const choosedate({super.key, this.onPressed, required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        color: Color(0xff535C91),
          border: Border.all(color: Colors.black45, width: 0.5),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          style: TextButton.styleFrom(
              padding: MediaQuery.sizeOf(context).width > 950
                  ? const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 22,
                    )
                  : const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 12,
                    ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: onPressed,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                date,
              
                textAlign: TextAlign.start,
                style: const TextStyle(
                  
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.w100),
              ),
            ),
          )),
    );
  }
}
