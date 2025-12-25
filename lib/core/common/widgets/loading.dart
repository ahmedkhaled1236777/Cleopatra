import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class lloading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: appcolors.maincolor,
      ),
    );
  }
}
class deleteloading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.green,
        ),
      ),
    );
  }
}