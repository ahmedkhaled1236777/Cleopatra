import 'package:flutter/material.dart';
import 'package:cleopatra/features/home/presentation/view/home1.dart';
import 'package:cleopatra/features/home/presentation/view/homeddesktop.dart';

class home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
return constrains.maxWidth<700?home1():home2();
    });
  }

}