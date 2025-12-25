import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class nodata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Center(
          child: Lottie.asset("assets/images/nodata.json"),
        ),
      ),
    );
  }
}
