import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as tt;
import 'package:get/get.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/auth/login/presentation/views/widgets/profile.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/drawer.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/newsettings.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';

//bhbhbhhbh
//ssss
class home1 extends StatefulWidget {
  @override
  State<home1> createState() => _homeState();
}

class _homeState extends State<home1> {
  List<IconData> data = [
    Icons.person,
    Icons.home,
    Icons.menu,
  ];
  int index = 1;
  SEARCHBLOCK() {
    
    FirebaseFirestore.instance.collection("users").snapshots().listen((e) {
      e.docs.forEach((datat) {
        if (datat.data()["block"] == true &&
            datat.data()["email"] == cashhelper.getdata(key: "email")) {
          cashhelper.cleardata();
          Get.offAll(newlogin(),
              transition: Transition.rightToLeft,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut);
        }
      });
    });
  }

  sendtempnoty() {}

  @override
  void initState() {
    if (cashhelper.getdata(key: "mymolds") == null) {
      tt.BlocProvider.of<moldusagesCubit>(context).getmoldusages();
    }
    SEARCHBLOCK();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            bottomNavigationBar: Container(
              color: index == 1 ? Colors.white : appcolors.dropcolor,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(40),
                  color: appcolors.newblack,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    child: Center(
                      child: SingleChildScrollView (
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: data
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index = data.indexOf(e);
                                      });
                                    },
                                    child: ClipPath(
                                      clipper: mynavpath(),
                                      child: AnimatedContainer(
                                        height: 70,
                                        curve: Curves.easeInOut,
                                        duration: Duration(milliseconds: 500),
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: data.indexOf(e) == index
                                              ? Border(
                                                  top: BorderSide(
                                                      width: 3.0,
                                                      color: Colors.white))
                                              : null,
                                          gradient: data.indexOf(e) == index
                                              ? LinearGradient(
                                                  colors: [
                                                      Color.fromARGB(
                                                          255, 251, 249, 249),
                                                      appcolors.newblack
                                                    ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter)
                                              : null,
                                        ),
                                        child: Icon(
                                          e,
                                          size: 35,
                                          color: data.indexOf(e) == index
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                      //hello w
                                      //
                                      //orld
                                      //new command
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: index == 1
                ? drawer()
                : index == 2
                    ? newsettings()
                    : profile()));
  }
}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    double h = size.height;
    double w = size.width;
    path.lineTo(0, 0.9 * h);
    path.quadraticBezierTo(0.1 * w, 0.8 * h, 0.2 * w, 0.9 * h);

    path.quadraticBezierTo(0.3 * w, h, 0.4 * w, 0.9 * h);
    path.quadraticBezierTo(0.5 * w, 0.8 * h, 0.6 * w, 0.9 * h);
    path.quadraticBezierTo(0.7 * w, h, 0.8 * w, 0.9 * h);
    path.quadraticBezierTo(0.9 * w, 0.8 * h, w, 0.9 * h);
    path.lineTo(w, 0);
    path.close();

    //start path with this if you are making at bottom

    /* var firstStart = Offset(size.width / 5, size.height); 
      //fist point of quadratic bezier curve
      var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
      //second point of quadratic bezier curve
      path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

      var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105); 
      //third point of quadratic bezier curve
      var secondEnd = Offset(size.width, size.height - 10);
      //fourth point of quadratic bezier curve
      path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

      path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
      path.close();*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class mynavpath extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double h = size.height;
    double w = size.width;
    final path_0 = Path();
    path_0.moveTo(0, h);
    path_0.lineTo(w, h);
    path_0.lineTo(w * 0.65, 0);
    path_0.lineTo(w * 0.35, 0);
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
