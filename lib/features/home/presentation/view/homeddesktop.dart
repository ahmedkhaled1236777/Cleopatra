
import 'package:animated_analog_clock/animated_analog_clock.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/presentation/views/widgets/profile.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/average.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/components.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/injectionco.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/views/productiontabbars.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/view/workers.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/gridelement.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/production.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/injectionorders.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/qc/presentation/view/qcreports.dart';
import 'package:cleopatra/features/users/presentation/views/widgets/employees.dart';

class home2 extends StatelessWidget {
    List homegrid = [
    {"name": 'الحقن', "image":  "assets/images/injection.png", "page": production()},
    {
      "name": 'اوردرات الحقن',
      "image": "assets/images/3d-report.png",
      "page": Injectionorders()
    },
        {"name": 'الاسطمبات', "image": "assets/images/molds.png", "page": molds()},
         {
      "name": 'استهلاك الاسطمبات',
      "image":  "assets/images/tooling.png",
      "page": moldusages()
    },
     {
      "name": 'صيانه الاسطمبات',
      "image": "assets/images/ma.jpg",
      "page": maintenances()
    },

    {
      "name": 'صالة التجميع',
      "image": "assets/images/collection.png",
      "page": injectionco()
    },
    {
      "name": 'اوردرات تجميع اللقمه',
      "image": "assets/images/switches.png",
      "page": Productiontabbars()
    },
     {
      "name": 'المنتجات ومكونات اللقمه',
      "image": "assets/images/cleopatra3.png",
      "page": components()
    },
    {
      "name": 'معدلات عمال اللقمه',
      "image": "assets/images/3d-report.png",
      "page": Average()
    },
     {
      "name":  'عمال اللقمه',
      "image": "assets/images/division.png",
      "page": Workers()
    },
    {
      "name": 'الجوده',
      "image": "assets/images/qc.png",
      "page": qc()
    },
    {
      "name": 'المستخدمين',
      "image": "assets/images/workers.png",
      "page": Employees()
    },
    
    
    {
      "name": 'الاعدادات',
      "image": "assets/images/settings.png",
      "page": profile()
    },
   
   
   
    
   
   
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/download.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Material(
                            // Replace this child with your own
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: AvatarGlow(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: CachedNetworkImage(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fill,
                                  imageUrl: cashhelper.getdata(key: "image"),
                                  errorWidget: (context, url, Widget) {
                                    return const Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                          ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "أحمد علام",
                      style: const TextStyle(
                        fontFamily: "cairo",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                   AnimatedAnalogClock(
                            hourDashColor: Colors.white,
                          centerDotColor: Colors.white  ,
                          hourHandColor: Colors.white,
                          minuteHandColor: Colors.white,
                            size: 60,
                            dialType: DialType.numbers,
                            backgroundImage: AssetImage(
                              'assets/images/clock.png',
                            ),
                          ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 1 / 0.8,
                  crossAxisCount:
                      MediaQuery.sizeOf(context).width > 950
                          ? 6
                          : MediaQuery.sizeOf(context).width > 650
                          ? 4
                          : MediaQuery.sizeOf(context).width > 500
                          ? 3
                          : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children:
                      homegrid
                          .map(
                            (e) => Gridelement(
                              text: e["name"],
                              image: e["image"],
                              onTap: () {
                    navigateto(context: context, page: e["page"]);
                              },
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
