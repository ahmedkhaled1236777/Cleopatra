import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleopatra/core/colors/colors.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/main/error.png'),
            SizedBox(
              height: 8.h,
            ),
            Text(
              textAlign: TextAlign.center,
              errorMessage,
              style: const TextStyle(
                fontSize: 20,
                color: appcolors.maincolor,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
