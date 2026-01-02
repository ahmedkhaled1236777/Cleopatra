import 'package:flutter/material.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/home.dart';

class LogoAnimationScreen extends StatefulWidget {
  const LogoAnimationScreen();

  @override
  LogoAnimationScreenState createState() => LogoAnimationScreenState();
}

class LogoAnimationScreenState extends State<LogoAnimationScreen> {
  bool isFirst = true;
  bool issecond = false;
  bool vis = false;

  int align = 0;
  bool showtext = false;
  @override
  void initState() {
    /*  Future.delayed(const Duration(milliseconds: 100), () {
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
    });*/
    Future.delayed(const Duration(milliseconds: 0), () {
      if (mounted) {
        setState(() {
          showtext = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: AnimatedOpacity(
                onEnd: () async {
                  navigateandfinish(
                      page: cashhelper.getdata(key: "save") != null
                          ? home()
                          : newlogin(),
                      context: context);
                },
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: showtext ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 2000),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Image.asset("assets/images/cleopatrahome.png"))));
  }
}
