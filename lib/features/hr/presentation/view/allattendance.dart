import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/error.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/hr/presentation/view/widgets/addabsense.dart';
import 'package:cleopatra/features/hr/presentation/view/widgets/addcut.dart';
import 'package:cleopatra/features/hr/presentation/view/widgets/addholiday.dart';

import 'package:cleopatra/features/hr/presentation/view/widgets/customtableallattendance.dart';
import 'package:cleopatra/features/hr/presentation/view/widgets/waitings.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:cleopatra/features/workers/presentation/views/workers.dart';

class Allattendance extends StatefulWidget {
  @override
  State<Allattendance> createState() => _AllattendanceState();
}

class _AllattendanceState extends State<Allattendance> {
  final productionheader = [
    "الاسم",
    "ايام\nالحضور",
    "ايام\nالاجازه",
    "ايام\nالغياب",
    "الراتب"
  ];

  getdata() async {
    await BlocProvider.of<HrCubit>(context).getallattendance(
        context: context,
        month:
            "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year}");
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            floatingActionButton: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 15),
                  FloatingActionButton(
                    heroTag: "1",
                    backgroundColor: appcolors.maincolor,
                    child: Text(
                      "العمال",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: worker());
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "2",
                    backgroundColor: appcolors.maincolor,
                    child: Text(
                      "خصم",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: Addcut());
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "3",
                    backgroundColor: appcolors.maincolor,
                    child: Text(
                      "غياب",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: addabsense());
                    },
                  ),
                  FloatingActionButton(
                    heroTag: "4",
                    backgroundColor: appcolors.maincolor,
                    child: Text(
                      " اجازه رسميه ",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: Addholiday());
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      navigateto(context: context, page: waitings());
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ))
              ],
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "تفاصيل الحضور والانصراف لشهر \n ${DateTime.now().month}-${DateTime.now().year}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(builder: (context, constrains) {
              return Column(children: [
                Container(
                  height: 50,
                  color: appcolors.maincolor.withOpacity(0.7),
                  child: Row(
                      children: productionheader
                          .map((e) => customheadertable(
                                title: e,
                                flex: e == "تحديد" || e == "حذف" ? 2 : 3,
                              ))
                          .toList()),
                ),
                Expanded(child: BlocBuilder<HrCubit, HrState>(
                  builder: (context, state) {
                    if (state is getallattendanceloading)
                      return loadingshimmer();
                    if (state is getallattendancefailure)
                      return errorfailure(errormessage: state.errormessage);

                    return BlocProvider.of<HrCubit>(context).attendances.isEmpty
                        ? nodata()
                        : ListView.separated(
                            itemBuilder: (context, i) =>
                                Customtableallattendanceitem(
                                  salary: (((double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["salary"]) / 30) *
                                              (BlocProvider.of<HrCubit>(context)
                                                      .attendances[i]
                                                      .daysoff +
                                                  BlocProvider.of<HrCubit>(context)
                                                      .attendances[i]
                                                      .attendancedays)) -
                                          ((double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["salary"]) / 30) *
                                              (BlocProvider.of<HrCubit>(context)
                                                  .attendances[i]
                                                  .notattendance)) -
                                          (((double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["salary"]) / 30) / double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["workhours"])) *
                                              BlocProvider.of<HrCubit>(context)
                                                  .attendances[i]
                                                  .permessionhours) +
                                          (((double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["salary"]) / 30) / double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["workhours"])) *
                                              BlocProvider.of<HrCubit>(context)
                                                  .attendances[i]
                                                  .addhours) -
                                          ((double.parse(BlocProvider.of<attendanceworkersCubit>(context).device[BlocProvider.of<HrCubit>(context).attendances[i].ipadress]!["salary"]) / 30) *
                                              (BlocProvider.of<HrCubit>(context)
                                                      .attendances[i]
                                                      .daysoff +
                                                  BlocProvider.of<HrCubit>(context)
                                                      .attendances[i]
                                                      .cut)))
                                      .toStringAsFixed(1),
                                  daysoff: BlocProvider.of<HrCubit>(context)
                                      .attendances[i]
                                      .daysoff
                                      .toString(),
                                  name: BlocProvider.of<attendanceworkersCubit>(
                                              context)
                                          .device[
                                      BlocProvider.of<HrCubit>(context)
                                          .attendances[i]
                                          .ipadress]!["name"],
                                  attendancedays:
                                      BlocProvider.of<HrCubit>(context)
                                          .attendances[i]
                                          .attendancedays
                                          .toString(),
                                  notattendancedays:
                                      BlocProvider.of<HrCubit>(context)
                                          .attendances[i]
                                          .notattendance
                                          .toString(),
                                ),
                            separatorBuilder: (context, i) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: BlocProvider.of<HrCubit>(context)
                                .attendances
                                .length);
                  },
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
