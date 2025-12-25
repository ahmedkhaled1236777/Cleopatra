import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/production.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/alertcontent.dart';

class Injectionorders extends StatefulWidget {
  @override
  State<Injectionorders> createState() => _InjectionordersState();
}

class _InjectionordersState extends State<Injectionorders> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            bottom: TabBar(
                onTap: (value) {
                  index = value;

                  setState(() {});
                },
                labelPadding: EdgeInsets.all(15),
                dividerColor: appcolors.maincolor,
                padding: EdgeInsets.all(10),
                indicatorSize: TabBarIndicatorSize.tab,
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // Use the default focused overlay color
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                }),
                indicator: BoxDecoration(color: appcolors.maincolor),
                tabs: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index == 0
                          ? appcolors.primarycolor
                          : appcolors.maincolor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "النشطه",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index == 1
                          ? appcolors.primarycolor
                          : appcolors.maincolor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "المنتهيه",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                  ),
                ]),
            leading: BackButton(
              color: Colors.white,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<DateCubit>(context).cleardates();

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Container(
                              height: 20,
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: appcolors.maincolor,
                                  )),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.all(35),
                            content: Alertinjectioncontent(),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () async {
                    BlocProvider.of<injectionhallcuibt>(context).refreshdata();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  )),
            ],
            backgroundColor: appcolors.maincolor,
            centerTitle: true,
            title: const Text(
              "اوردرات الحقن",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "cairo",
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )),
        body: TabBarView(children: [
          injectionhall(
            status: false,
            index: 0,
          ),
          injectionhall(
            status: true,
            index: 1,
          ),
        ]),
      ),
    );
  }
}
