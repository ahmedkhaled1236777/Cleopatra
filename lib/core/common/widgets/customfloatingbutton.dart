
import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class customfloatingbutton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(backgroundColor: appcolors.primarycolor,onPressed: (){
    },child: Icon(Icons.add,color: Colors.white,),);
  }
  
}