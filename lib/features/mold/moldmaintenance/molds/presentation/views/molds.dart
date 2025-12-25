import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/pdf/pdf.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/maintenancestate.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/addmaintenance.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/widgets/alertmoldcontent.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/widgets/customtablemolditem.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/widgets/editdialog.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/widgets/molditem.dart';
import 'package:share_plus/share_plus.dart';

class maintenances extends StatefulWidget {
  @override
  State<maintenances> createState() => _maintenancesState();
}

class _maintenancesState extends State<maintenances> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final maintenancesheader = [
    "تاريخ\nالصيانه",
    "اسم\nالاسطمبه",
    "نوع\nالصيانه",
    "الحاله",
    "تعديل",
  ];

  getdata() async {
    await BlocProvider.of<maintenancesCubit>(context).getmaintenances();
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
                    onPressed: () {
                      BlocProvider.of<maintenancesCubit>(context).resetsearch();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
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
                                      BlocProvider.of<DateCubit>(context)
                                          .cleardates();

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
                              content: Alertmaintenancecontent(),
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
                "صيانه الاسطمبات",
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
                    children: maintenancesheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<maintenancesCubit, maintenancesState>(
                    listener: (context, state) {
                  if (state is getmaintenancefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getmaintenanceloading) return loadingshimmer();
                  if (state is getmaintenancefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<maintenancesCubit>(context)
                        .mymaintenances
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  showDialog(
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
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          content: maintenanceitem(
                                            mold: BlocProvider.of<
                                                    maintenancesCubit>(context)
                                                .mymaintenances[i],
                                          ),
                                        );
                                      });
                                },
                                child: customtablemaintenanceitem(
                                  type: BlocProvider.of<maintenancesCubit>(
                                          context)
                                      .mymaintenances[i]
                                      .type,
                                  edit: IconButton(
                                      onPressed: () {
                                        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                        print(permession);
                                        if (!permession.contains(
                                            "تعديل صيانه الاسطمبات")) {
                                          showdialogerror(
                                              error: "ليس لديك صلاحية التعديل",
                                              context: context);
                                        } else {
                                          BlocProvider.of<DateCubit>(context)
                                              .date6 = BlocProvider.of<
                                                              maintenancesCubit>(
                                                          context)
                                                      .mymaintenances[i]
                                                      .retrundate ==
                                                  null
                                              ? "تاريخ نهاية الصيانه"
                                              : BlocProvider.of<
                                                          maintenancesCubit>(
                                                      context)
                                                  .mymaintenances[i]
                                                  .retrundate!;
                                          BlocProvider.of<maintenancesCubit>(
                                                  context)
                                              .maintenancestatus = BlocProvider
                                                  .of<maintenancesCubit>(
                                                      context)
                                              .mymaintenances[i]
                                              .status;
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
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
                                                  content: editmaintenancedialog(
                                                      name:
                                                          BlocProvider.of<maintenancesCubit>(context)
                                                              .mymaintenances[i]
                                                              .moldname,
                                                      type:
                                                          BlocProvider.of<maintenancesCubit>(context)
                                                              .mymaintenances[i]
                                                              .type,
                                                      location: BlocProvider.of<maintenancesCubit>(context)
                                                                  .mymaintenances[
                                                                      i]
                                                                  .type ==
                                                              "خارجيه"
                                                          ? BlocProvider.of<maintenancesCubit>(
                                                                  context)
                                                              .mymaintenances[i]
                                                              .location!
                                                          : "",
                                                      notes: TextEditingController(
                                                          text: BlocProvider.of<
                                                                  maintenancesCubit>(context)
                                                              .mymaintenances[i]
                                                              .notes),
                                                      docid: "${BlocProvider.of<maintenancesCubit>(context).mymaintenances[i].godate}-${BlocProvider.of<maintenancesCubit>(context).mymaintenances[i].moldname}-${BlocProvider.of<maintenancesCubit>(context).mymaintenances[i].type}"),
                                                );
                                              });
                                        }
                                      },
                                      icon: Icon(editeicon)),
                                  moldname: BlocProvider.of<maintenancesCubit>(
                                          context)
                                      .mymaintenances[i]
                                      .moldname,
                                  date: BlocProvider.of<maintenancesCubit>(
                                          context)
                                      .mymaintenances[i]
                                      .godate!,
                                  status: BlocProvider.of<maintenancesCubit>(
                                          context)
                                      .mymaintenances[i]
                                      .status,
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<maintenancesCubit>(context)
                              .mymaintenances
                              .length);
                    }
                  }
                }),
              )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () async {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await pdf.generatepdf(
                              name: "${DateTime.now()}",
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<maintenancesCubit>(context)
                                      .mymaintenances);
                          await pdf.openfile(file);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await pdf.generatepdf(
                              name: "${DateTime.now()}",
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<maintenancesCubit>(context)
                                      .mymaintenances);
                          Share.shareXFiles([XFile(file.path)]);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          if (!permession.contains('اضافة صيانه الاسطمبات')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(
                                context: context, page: Addmaintenance());
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),SizedBox(height: 11,)
            ])));
  }
}
