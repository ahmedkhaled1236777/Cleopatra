
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';

class dropdownbutton extends StatelessWidget{
  final Function onchanged;
    String? name;
  final List mo;
  final String hint;


   dropdownbutton({super.key, required this.onchanged,required this.mo,required this.name, required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Container(
        decoration: BoxDecoration(
              color: appcolors.dropcolor,
              borderRadius: BorderRadius.circular(10)
            ),
            width: double.infinity,
            height: 50,
        child: Padding(
          padding:  EdgeInsets.only(left: 5),
          child: Row(
            children: [
              Icon(Icons.arrow_circle_down,color: Colors.white,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(30),
                   dropdownColor:Colors.purple,
                    value: name,
                    isExpanded: true,
              iconSize: 0,
                    hint:Center(child: Text(hint,style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: "cairo"),textAlign: TextAlign.center,)) ,
                    
                    items:mo.map((e) => DropdownMenuItem(child: Center(child: Text("${e}",style: TextStyle(fontSize: 20,color:Colors.white,fontFamily: "cairo"))),value: e,)).toList()
                    , onChanged: ((val) {
                     onchanged(val);
                    
                  })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}