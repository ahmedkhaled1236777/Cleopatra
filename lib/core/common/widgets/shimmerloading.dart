import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class loadingshimmer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.separated(separatorBuilder: (context, index) {
      return Divider();
    },itemBuilder: (context,index){
return ListTile(
  title: Container(

constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 21),    color: Colors.white,
  ),
);
    },itemCount:7 ,)
  );
  }
  
}