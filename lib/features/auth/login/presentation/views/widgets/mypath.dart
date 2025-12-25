import 'package:flutter/material.dart';

class mypath extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    double h=size.height;
  double w =size.width;
  final path_0=Path();
  path_0.lineTo(0, h);
  path_0.quadraticBezierTo(0, h*0.7,w*0.15, h*0.7);
  path_0.lineTo(w*0.8, h*0.7);
    path_0.quadraticBezierTo(w, h*0.7,w, h*0.5);
  path_0.lineTo(w, h*0);
  path_0.close();
       // path_0.moveTo(size.width*1.0044365,size.height*0.0020000);
    //path_0.lineTo(size.width*0,size.height*0);
    //path_0.quadraticBezierTo(size.width*0.0013334,size.height*0.2698571,size.width*0.0013334,size.height*0.3591429);
    //path_0.cubicTo(size.width*0.2574874,size.height*-0.0827857,size.width*0.4856246,size.height*0.4962143,size.width*1.0019350,size.height*0.3605714);
    //path_0.quadraticBezierTo(size.width*1.0025604,size.height*0.2709286,size.width*1.0044365,size.height*0.0020000);
   // path_0.close();


   return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
   return false;
  }

}