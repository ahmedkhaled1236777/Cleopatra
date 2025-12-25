import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/home/presentation/view/home1.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/home.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  User? user;
  bool isFirst = true;

  bool issecond = false;

  bool vis = false;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          isFirst = false;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          issecond = true;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (isFirst == false && issecond == true) {
        navigateandfinish(
            context: context,
            page: user != null || cashhelper.getdata(key: "save") != null
                ? home()
                : newlogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appcolors.newblack,
        body: AnimatedRotation(
          duration: const Duration(milliseconds: 600),
          turns: issecond ? .25 : 0,
          child: AnimatedAlign(
            alignment: isFirst ? Alignment.topCenter : Alignment.center,
            duration: const Duration(milliseconds: 400),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: isFirst ? 0 : -1.25,
              child: SizedBox(
                  width: 296,
                  height: 282,
                  child: Image.asset("assets/images/cleopatradark.png")),
            ),
          ),
        ));
  }
}
