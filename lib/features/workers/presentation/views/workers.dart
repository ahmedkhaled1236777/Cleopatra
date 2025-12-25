import 'dart:io';

import 'package:flutter/services.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_state.dart';
import 'package:cleopatra/features/workers/presentation/views/addworker.dart';
import 'package:cleopatra/features/workers/presentation/views/widgets/alertsearch.dart';
import 'package:cleopatra/features/workers/presentation/views/widgets/customworkertimeritem.dart';
import 'package:cleopatra/features/workers/presentation/views/widgets/editworker.dart';
import 'package:cleopatra/features/workers/presentation/views/widgets/workeritem.dart';

class worker extends StatefulWidget {
  @override
  State<worker> createState() => _workerState();
}

class _workerState extends State<worker> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final workerheader = [
    "اسم الموظف",
    "رقم الهاتف",
    "الوظيفه",
    "الراتب",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<attendanceworkersCubit>(context)
        .getattendanceworkers();
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
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await BlocProvider.of<attendanceworkersCubit>(context)
                          .getattendanceworkers();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<DateCubit>(context).cleardates();
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              title: Container(
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
                              content: Alertworkersearch(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "الموظفين",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: workerheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<attendanceworkersCubit,
                      attendanceworkersState>(listener: (context, state) {
                if (state is getworkerfailure)
                  showtoast(
                                                                                                      context: context,

                    message: state.errormessage,
                    toaststate: Toaststate.error,
                  );
              }, builder: (context, state) {
                if (state is getworkerloading) return loadingshimmer();
                if (state is getworkerfailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<attendanceworkersCubit>(context)
                      .attendanceworkers
                      .isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onDoubleTap: () {},
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Container(
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
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          content: Workeritem(
                                              componentitem: BlocProvider.of<
                                                          attendanceworkersCubit>(
                                                      context)
                                                  .attendanceworkers[i]));
                                    });
                              },
                              child: Customworkeritem(
                                  job: BlocProvider.of<attendanceworkersCubit>(
                                          context)
                                      .attendanceworkers[i]
                                      .job_title!,
                                  salary:
                                      BlocProvider.of<attendanceworkersCubit>(
                                              context)
                                          .attendanceworkers[i]
                                          .salary!,
                                  workerphone:
                                      BlocProvider.of<attendanceworkersCubit>(
                                                  context)
                                              .attendanceworkers[i]
                                              .phone ??
                                          "",
                                  workername:
                                      BlocProvider.of<attendanceworkersCubit>(
                                              context)
                                          .attendanceworkers[i]
                                          .name!,
                                  edit: IconButton(
                                      color:
                                          const Color.fromARGB(255, 9, 62, 88),
                                      onPressed: () {
                                        BlocProvider.of<attendanceworkersCubit>(
                                                context)
                                            .scanner = BlocProvider.of<
                                                attendanceworkersCubit>(context)
                                            .attendanceworkers[i]
                                            .deviceip;

                                        showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  title: Container(
                                                    height: 20,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: appcolors
                                                              .maincolor,
                                                        )),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  backgroundColor: Colors.white,
                                                  insetPadding:
                                                      EdgeInsets.all(35),
                                                  content: editworkerdialog(
                                                      date: BlocProvider.of<attendanceworkersCubit>(context)
                                                          .attendanceworkers[i]
                                                          .employment_date,
                                                      jop: TextEditingController(
                                                          text: BlocProvider.of<attendanceworkersCubit>(context).attendanceworkers[i].job_title ??
                                                              ""),
                                                      workhours: TextEditingController(
                                                          text: BlocProvider.of<attendanceworkersCubit>(
                                                                      context)
                                                                  .attendanceworkers[i]
                                                                  .workhours ??
                                                              ""),
                                                      salary: TextEditingController(text: BlocProvider.of<attendanceworkersCubit>(context).attendanceworkers[i].salary ?? ""),
                                                      phone: TextEditingController(text: BlocProvider.of<attendanceworkersCubit>(context).attendanceworkers[i].phone ?? ""),
                                                      id: BlocProvider.of<attendanceworkersCubit>(context).attendanceworkers[i].name));
                                            });
                                      },
                                      icon: Icon(editeicon)),
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                attendanceworkersCubit,
                                                attendanceworkersState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deleteattendanceworkersuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                    message:
                                                        state.successmessage,
                                                    toaststate:
                                                        Toaststate.succes,
                                                  );
                                                }
                                                if (state
                                                    is deleteworkerfailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                    message: state.errormessage,
                                                    toaststate:
                                                        Toaststate.error,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is deleteworkerloading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    attendanceworkersCubit>(
                                                                context)
                                                            .deleteworker(
                                                                workerid:
                                                                    "${BlocProvider.of<attendanceworkersCubit>(context).attendanceworkers[i].name}");
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: "cairo",
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle: "هل تريد الحذف ؟");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount:
                            BlocProvider.of<attendanceworkersCubit>(context)
                                .attendanceworkers
                                .length);
                  }
                }
              })),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: appcolors.primarycolor,
                        borderRadius: BorderRadius.circular(7)),
                    child: IconButton(
                        onPressed: () async {
                          navigateto(context: context, page: Addworker());
                        },
                        icon: Icon(
                          color: Colors.white,
                          Icons.add,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ])));
  }
}
