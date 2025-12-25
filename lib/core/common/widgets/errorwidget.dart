import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/images/loading.json", width: 130,height: 130),
    );
  }
}
