import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/homebody.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/menudraer.dart';

class drawer extends StatelessWidget {
  ZoomDrawerController awesomeDrawerBarController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      isRtl: true,
      clipMainScreen: false,
      style: DrawerStyle.style3,
      controller: awesomeDrawerBarController,
      mainScreenScale: 0.1,
      menuBackgroundColor: Colors.white,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.65,
      mainScreenTapClose: true,
      openCurve: Curves.bounceInOut,
      menuScreen: menudrawer(),
      mainScreen: homebody(
        awesomeDrawerBarController: awesomeDrawerBarController,
      ),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
    );
  }
}
