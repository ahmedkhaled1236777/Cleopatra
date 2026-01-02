import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/production.dart';

class Injectionorders extends StatefulWidget {
  @override
  State<Injectionorders> createState() => _InjectionordersState();
}

class _InjectionordersState extends State<Injectionorders> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        
          leading: BackButton(color: Colors.white),
          backgroundColor: appcolors.maincolor,
          bottom: TabBar(
            indicatorColor: appcolors.primarycolor,
            tabs: [
              Text(
                "الاوردرات النشطه",
                style: TextStyle(fontFamily: "cairo", color: Colors.white),
              ),
              Text(
                "الاوردرات المنتهيه",
                style: TextStyle(fontFamily: "cairo", color: Colors.white),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [injectionhall(
            status: false,
            index: 0,
          ),   injectionhall(
            status: true,
            index: 1,
          ),]),
      ),
    );
  }
}
    
    
                
