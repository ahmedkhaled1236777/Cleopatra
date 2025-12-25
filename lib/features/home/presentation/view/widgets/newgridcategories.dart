import 'package:carousel_slider/carousel_slider.dart' as ss;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/auth/login/presentation/views/widgets/mypath.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/average.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/views/productiontabbars.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/gridelement.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/injectionco.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/paintreports.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/production.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/view/workers.dart';
import 'package:badges/badges.dart' as badges;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class newgridcategories extends StatefulWidget {
  @override
  State<newgridcategories> createState() => _newgridcategoriesState();
}

class _newgridcategoriesState extends State<newgridcategories> {
  ss.CarouselSliderController controller = ss.CarouselSliderController();
  bool list = false;
  int noty = 0;
  List<String> adverts = [];
  int index = 0;
  List homegrid = [
    {"name": "الحقن", "image": "assets/images/prod.jpg", "page": production()},
    {"name": "الاسطمبات", "image": "assets/images/molds.jpg", "page": molds()},
    {
      "name": "استهلاك الاسطمبات",
      "image": "assets/images/molds.jpg",
      "page": moldusages()
    },
    {
      "name": "صيانة الاسطمبات",
      "image": "assets/images/ma.jpeg",
      "page": maintenances()
    },
    {
      "name": "تجميع الحقن",
      "image": "assets/images/ll.jpg",
      "page": injectionco()
    },
    {
      "name": "معدلات العمال",
      "image": "assets/images/workers.png",
      "page": Average()
    },
    {"name": "العمال", "image": "assets/images/workers.png", "page": Workers()},
    {
      "name": "اوردرات التجميع",
      "image": "assets/images/gg.jpg",
      "page": Productiontabbars()
    },
    {
      "name": "تقارير واوردرات الرش",
      "image": "assets/images/3d-report.png",
      "page": Paintreports()
    },
  ];
  List images = [
    "assets/images/cleopatra1.jpg",
    "assets/images/cleopatra2.jpg",
    "assets/images/cleopatra3.jpg"
  ];
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: mypath(),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.3 / 4.5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        ZoomDrawer.of(context)!.open();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  Spacer(),
                  Text("الرئيسيه",
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Spacer(),
                  badges.Badge(
                    position: badges.BadgePosition.topStart(start: 25, top: 2),
                    child: IconButton(
                        onPressed: (() async {}),
                        icon: Icon(Icons.notifications, color: Colors.white)),
                    badgeContent: Text(
                      "0",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () async {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            cashhelper.getdata(key: "email") ==
                                    "ahmedaaallam123@gmail.com"
                                ? 'assets/images/profile.jpg'
                                : 'assets/images/cleopatra.jpg',
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.28,
            color: appcolors.primarycolor,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  ss.CarouselSlider(
                    carouselController: controller,
                    options: ss.CarouselOptions(
                        onPageChanged: (i, _) {},
                        height: 150.0,
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
                                child: Image.asset(images[i]),
                                borderRadius: BorderRadius.circular(15),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: index,
                    count: adverts.length,
                    effect: WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        strokeWidth: 10,
                        activeDotColor: Colors.purple),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimationLimiter(
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
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
                                    onTap: () {
                                      navigateto(
                                          context: context,
                                          page: homegrid[index]["page"]);
                                    },
                                  ))))),
                    ),
                  ))
            ]),
          ),
        )
      ],
    );
  }
}
