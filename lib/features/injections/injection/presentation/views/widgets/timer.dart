import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';

import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/addtimer.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/customtabletimeritem.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/editmolddialog.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/moldcyclespdf.dart';
import 'package:share_plus/share_plus.dart';

class timer extends StatefulWidget {
  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final scrapsheader = [
    "اسم\nالاسطمبه",
    "نوع\nالخامه",
    "عدد\nالقطع",
    "زمن\nالدوره",
    "وزن\nالقطعه",
    "تعديل",
    "حذف"
  ];

  getdata() async {
    if (BlocProvider.of<productioncuibt>(context).timerrate.isEmpty)
      await BlocProvider.of<productioncuibt>(context).gettimers();
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (!permession.contains('اضافة زمن حقن'))
                    showdialogerror(
                        error: "ليس لديك الصلاحيه", context: context);
                  else
                    navigateto(context: context, page: Addtimer());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      final img = await rootBundle
                          .load('assets/images/cleopatra-modified.png');
                      final imageBytes = img.buffer.asUint8List();
                      File file = await Moldcyclespdf.generatepdf(
                          context: context,
                          imageBytes: imageBytes,
                          molds:
                              BlocProvider.of<productioncuibt>(context).timers);
                      Share.shareXFiles([XFile(file.path)]);
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "الاسطمبات",
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
                    children: scrapsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" ||
                                      e == "زمن\nالدوره" ||
                                      e == "وزن\nالقطعه" ||
                                      e == "حذف" ||
                                      e == "عدد\nالقطع"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {      await BlocProvider.of<productioncuibt>(context).gettimers();
},
                child: BlocConsumer<productioncuibt, productiontates>(
                    listener: (context, state) {
                  if (state is GetTimerFailure) {
                    showtoast(
                                                                                                        context: context,

                        message: state.errormessage,
                        toaststate: Toaststate.error);
                  }
                }, builder: (context, state) {
                  if (state is GetTimerLoading) return loadingshimmer();
                  if (state is getorderfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<productioncuibt>(context)
                        .timers
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => Customtabletimeritem(
                                materialtype:
                                    BlocProvider.of<productioncuibt>(context)
                                        .timers[i]
                                        .materialtype,
                                numberofpieces:
                                    BlocProvider.of<productioncuibt>(context)
                                        .timers[i]
                                        .numberofpieces,
                                edit: IconButton(
                                    onPressed: () {
                                      if (!permession.contains('تعديل زمن حقن')) {
                                        showdialogerror(
                                            error: "ليس لديك الصلاحيه",
                                            context: context);
                                      } else {
                                        if (BlocProvider.of<productioncuibt>(
                                                    context)
                                                .timers[i]
                                                .materialtype !=
                                            "لا يوجد") {
                                          BlocProvider.of<MoldsCubit>(context)
                                                  .materialtype =
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .timers[i]
                                                  .materialtype;
                                        }

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
                                                  content: editmolddialog(
                                                    timer: BlocProvider.of<
                                                                productioncuibt>(
                                                            context)
                                                        .timers[i],
                                                    numberofpieces:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<productioncuibt>(
                                                                        context)
                                                                .timers[i]
                                                                .numberofpieces),
                                                    sprueweight:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<productioncuibt>(
                                                                        context)
                                                                .timers[i]
                                                                .sprueweight.toString()),
                                                    cycletime:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<productioncuibt>(
                                                                        context)
                                                                .timers[i]
                                                                .secondsperpiece
                                                                .toString()),
                                                    weight: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    productioncuibt>(
                                                                context)
                                                            .timers[i]
                                                            .weight
                                                            .toString()),
                                                  ));
                                            });
                                      }
                                    },
                                    icon: Icon(editeicon)),
                                mold: BlocProvider.of<productioncuibt>(context)
                                    .timers[i]
                                    .moldname,
                                time: BlocProvider.of<productioncuibt>(context)
                                    .timers[i]
                                    .secondsperpiece,
                                weight:
                                    BlocProvider.of<productioncuibt>(context)
                                        .timers[i]
                                        .weight,
                                delete: IconButton(
                                    onPressed: () {
                                      if (!permession.contains('حذف زمن حقن'))
                                        showdialogerror(
                                            error: "ليس لديك الصلاحيه",
                                            context: context);
                                      else {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                productioncuibt,
                                                productiontates>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteTimerfailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                                if (state
                                                    is DeleteTimerSuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state is DeleteTimerloading)
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
                                                                    productioncuibt>(
                                                                context)
                                                            .deletetimer(
                                                                timer: BlocProvider.of<
                                                                            productioncuibt>(
                                                                        context)
                                                                    .timers[i]);
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
                                            tittle:
                                                "هل تريد حذف معدل ${BlocProvider.of<productioncuibt>(context).timers[i].moldname}");
                                      }
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    )),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<productioncuibt>(context)
                              .timers
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
