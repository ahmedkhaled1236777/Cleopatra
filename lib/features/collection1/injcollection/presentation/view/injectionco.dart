import 'dart:io';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/addinjectionco.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/alertcontent.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/customtableproductionitem.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/exceell.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/injcopdf.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/productionitem.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/search.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/viewmodel/cubit/injextionco_dart_cubit.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';
import 'package:share_plus/share_plus.dart';

class injectionco extends StatefulWidget {
  @override
  State<injectionco> createState() => _injectioncoState();
}

class _injectioncoState extends State<injectionco> {
  final injectioncoheader = [
    "التاريخ",
    "اسم العامل",
    "الوظيفه",
    "الكميه",
    "حذف",
  ];

  getdata() async {
    /* await BlocProvider.of<InjextioncoDartCubit>(context).getdata(
        date:
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');*/
    if (BlocProvider.of<AverageCubit>(context).averages.isEmpty)
      await BlocProvider.of<AverageCubit>(context).getaverages();
    if (BlocProvider.of<WorkerCubit>(context).workers.isEmpty)
      await BlocProvider.of<WorkerCubit>(context).getworkers();
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
                              content: Alertcontent(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                diagramsearchreport(),
              
                SizedBox(
                  width: 5,
                )
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "التقرير اليومي",
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
                    children: injectioncoheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: CircularMenu(
                      items: [
                    CircularMenuItem(
                      icon: Icons.add,
                      onTap: () {
                        if (!permession.contains('اضافة تقرير تجميع'))
                          showdialogerror(
                              error: "ليس لديك الصلاحيه لحذف التقرير",
                              context: context);
                        else
                          navigateto(context: context, page: addinjectionco());
                      },
                      color: Colors.green,
                      iconColor: Colors.white,
                    ),
                    CircularMenuItem(
                      icon: Icons.picture_as_pdf,
                      onTap: () async {
                        if (BlocProvider.of<InjextioncoDartCubit>(context)
                            .injectionsco
                            .isEmpty) {
                          showdialogerror(
                              error: "لا توجد بيانات للمشاركه",
                              context: context);
                        } else {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await Injcopdf.generatepdf(
                              context: context,
                              codes:
                                  BlocProvider.of<WorkerCubit>(context).codes,
                              name:
                                  "${BlocProvider.of<InjextioncoDartCubit>(context).injectionsco[0].date}",
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<InjextioncoDartCubit>(context)
                                      .injectionsco);

                          Share.shareXFiles([XFile(file.path)]);
                        }
                      },
                      color: Colors.orange,
                      iconColor: Colors.white,
                    ),
                    CircularMenuItem(
                      icon: Icons.share,
                      onTap: () async {
                        if (BlocProvider.of<InjextioncoDartCubit>(context)
                            .injectionsco
                            .isEmpty) {
                          showdialogerror(
                              error: "لا توجد بيانات للمشاركه",
                              context: context);
                        } else {
                          File file = await shareinjcoexcell(
                              name:
                                  "${BlocProvider.of<InjextioncoDartCubit>(context).injectionsco[0].date}",
                              categories:
                                  BlocProvider.of<InjextioncoDartCubit>(context)
                                      .injectionsco,
                              codes:
                                  BlocProvider.of<WorkerCubit>(context).codes);
                          Share.shareXFiles([XFile(file.path)]);
                        }
                      },
                      color: Colors.deepPurple,
                      iconColor: Colors.white,
                    ),
                  ],
                      toggleButtonSize: 30,
                      toggleButtonColor: appcolors.maincolor,
                      alignment: Alignment.bottomLeft,
                      backgroundWidget: BlocConsumer<InjextioncoDartCubit,
                          InjextioncoDartState>(listener: (context, state) {
                        if (state is getinjectioncofailure)
                          showtoast(
                                                                                context: context,

                              message: state.errormessage,
                              toaststate: Toaststate.error);
                      }, builder: (context, state) {
                        if (state is getinjectioncoloading)
                          return loadingshimmer();
                        if (state is getinjectioncofailure)
                          return SizedBox();
                        else {
                          if (BlocProvider.of<InjextioncoDartCubit>(context)
                              .injectionsco
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color:
                                                            appcolors.maincolor,
                                                      )),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                content: injectioncoitem(
                                                  injectioncos: BlocProvider.of<
                                                              InjextioncoDartCubit>(
                                                          context)
                                                      .injectionsco[i],
                                                ),
                                              );
                                            });
                                      },
                                      child: customtableinjectioncositem(
                                          worker: BlocProvider.of<
                                                  InjextioncoDartCubit>(context)
                                              .injectionsco[i]
                                              .workername,
                                          job: BlocProvider.of<
                                                  InjextioncoDartCubit>(context)
                                              .injectionsco[i]
                                              .job,
                                          quantity: BlocProvider.of<
                                                  InjextioncoDartCubit>(context)
                                              .injectionsco[i]
                                              .productionquantity
                                              .toString(),
                                          date: BlocProvider.of<
                                                  InjextioncoDartCubit>(context)
                                              .injectionsco[i]
                                              .date,
                                          delet: IconButton(
                                              onPressed: () {
                                                if (!permession.contains(
                                                    'حذف تقرير تجميع'))
                                                  showdialogerror(
                                                      error:
                                                          "ليس لديك الصلاحيه لحذف التقرير",
                                                      context: context);
                                                else
                                                  awsomdialogerror(
                                                      context: context,
                                                      mywidget: BlocConsumer<
                                                          InjextioncoDartCubit,
                                                          InjextioncoDartState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is deleteinjectioncosuccess) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                          context: context,         message: state
                                                                    .successmessage,
                                                                toaststate:
                                                                    Toaststate
                                                                        .succes);
                                                          }
                                                          if (state
                                                              is deleteinjectioncofailure) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                          context: context,         message: state
                                                                    .errormessage,
                                                                toaststate:
                                                                    Toaststate
                                                                        .error);
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is deleteinjectioncoloading)
                                                            return deleteloading();
                                                          return SizedBox(
                                                            height: 50,
                                                            width: 100,
                                                            child:
                                                                ElevatedButton(
                                                                    style:
                                                                        const ButtonStyle(
                                                                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await BlocProvider.of<InjextioncoDartCubit>(
                                                                              context)
                                                                          .deleteproduction(
                                                                              prduction: BlocProvider.of<InjextioncoDartCubit>(context).injectionsco[i]);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "تاكيد",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              "cairo",
                                                                          color:
                                                                              Colors.white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                          );
                                                        },
                                                      ),
                                                      tittle:
                                                          "هل تريد حذف تقرير البيان ");
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
                                    BlocProvider.of<InjextioncoDartCubit>(
                                            context)
                                        .injectionsco
                                        .length);
                          }
                        }
                      }))),
            ])));
  }
}
