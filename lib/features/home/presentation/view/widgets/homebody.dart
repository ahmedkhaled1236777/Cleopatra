import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:carousel_slider/carousel_slider.dart' as ss;
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/injectionco.dart';

import 'package:cleopatra/features/home/presentation/view/home1.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/gridelement.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/molds.dart';

import 'package:cleopatra/features/injections/injection/presentation/views/production.dart';
import 'package:cleopatra/features/qc/presentation/view/qcreports.dart';

class homebody extends StatefulWidget {
  final ZoomDrawerController awesomeDrawerBarController;

  homebody({super.key, required this.awesomeDrawerBarController});

  @override
  State<homebody> createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {
  List<String> images = [
    "assets/images/cleopatra1.jpg",
    "assets/images/cleopatra2.jpg",
    "assets/images/splash2.png"
  ];

  ss.CarouselSliderController controller = ss.CarouselSliderController();

  List homegrid = [
    {"name": 'الحقن', "image": "assets/images/injectionimage.png", "page": production()},
    {
      "name": 'صالة اللقمه',
      "image": "assets/images/ss.jpeg",
      "page": injectionco()
    },
    {"name": 'الاسطمبات', "image": "assets/images/molds.png", "page": molds()},
    {
      "name": 'الجوده',
      "image": "assets/images/qc.png",
      "page": qc()
    },
  ];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Stack(
          children: <Widget>[
            //stack overlaps widgets
            Opacity(
              //semi red clippath with more height and with 0.5 opacity
              opacity: 0.2,
              child: ClipPath(
                clipper: WaveClipper(), //set our custom wave clipper
                child: Container(
                  color: appcolors.maincolor,
                  height: 160,
                ),
              ),
            ),

            ClipPath(
              //upper clippath with less height
              clipper: WaveClipper(), //set our custom wave clipper.
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                color: appcolors.newblack,
                height: 150,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
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
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              cashhelper.getdata(key: "name"),
                              style: const TextStyle(
                                fontFamily: "cairo",
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              widget.awesomeDrawerBarController.open!();
                            },
                            icon: Icon(Icons.menu, color: Colors.white),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        ss.CarouselSlider(
          carouselController: controller,
          options: ss.CarouselOptions(
              onPageChanged: (i, _) {},
              height: 150.0,
              enlargeStrategy: ss.CenterPageEnlargeStrategy.height,
              autoPlay: true,
              aspectRatio: 20 / 9),
          items: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Card(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: ClipRRect(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            i,
                            width: double.infinity,
                          )),
                      borderRadius: BorderRadius.circular(15),
                    ));
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AnimationLimiter(
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    children: List.generate(
                        homegrid.length,
                        (index) => AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: 2,
                            child: SlideAnimation(
                                delay: Duration(milliseconds: 300),
                                child: FlipAnimation(
                                    child: Gridelement(
                                  text: homegrid[index]["name"],
                                  image: homegrid[index]["image"],
                                  onTap: () async {
                                
                                    if (!permession
                                        .contains(homegrid[index]["name"])) {
                                      showdialogerror(
                                          error: "ليس لديك صلاحية الدخول",
                                          context: context);
                                    } else {
                                      navigateto(
                                          context: context,
                                          page: homegrid[index]["page"]);
                                    }
                                  },
                                ))))),
                  ),
                )))
      ],
    ));
    ;
  }
}
