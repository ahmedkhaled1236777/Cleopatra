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
import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportcuibt.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportstates.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/addpaintreport.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/widgets/alertcontent.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/widgets/customtablepaintreportitem.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/widgets/paintreport.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/widgets/widgets/paintexcell.dart';
import 'package:cleopatra/features/paints/paint/presentation/views/widgets/widgets/paintreportpdf.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/view/paintaverage.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/paintorders.dart';

import 'package:share_plus/share_plus.dart';

class Paintreports extends StatefulWidget {
  @override
  State<Paintreports> createState() => _PaintreportsState();
}

class _PaintreportsState extends State<Paintreports> {
  final productionheader = [
    "اسم المنتج",
    "كمية\nالانتاج",
    "كمية هالك الرش",
    "كمية هالك الحقن",
    "تحديد",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<paintcuibt>(context).getpaintorders();
    await BlocProvider.of<paintaverageCubit>(context).getpaintaverages();
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
                              content: Alertcontentpaintreport(),
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
                "التقرير اليومي",
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
                Expanded(
                    child: CircularMenu(
                        items: [
                      CircularMenuItem(
                        icon: Icons.add,
                        onTap: () {
                          if (!permession.contains('اضافة تقرير رش')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(
                                context: context, page: addpaintreport());
                        },
                        color: Colors.green,
                        iconColor: Colors.white,
                      ),
                      CircularMenuItem(
                        icon: Icons.menu,
                        onTap: () async {
                          if (!permession.contains('اوردرات الرش')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: Paintorders());
                        },
                        color: Colors.orange,
                        iconColor: Colors.white,
                      ),
                      CircularMenuItem(
                        icon: Icons.share,
                        onTap: () async {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await paintreportpdf.generatepdf(
                              context: context,
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<paintreportcuibt>(context)
                                      .mypaintreport);
                          await Share.shareXFiles([XFile(file.path)]);
                        },
                        color: Colors.deepPurple,
                        iconColor: Colors.white,
                      ),
                    ],
                        toggleButtonSize: 30,
                        toggleButtonColor: appcolors.maincolor,
                        alignment: Alignment.bottomLeft,
                        backgroundWidget:
                            BlocConsumer<paintreportcuibt, paintreportstates>(
                                listener: (context, state) {
                          if (state is getpaintreportsfailure)
                            showtoast(
                                                                                                                context: context,

                                message: state.errormessage,
                                toaststate: Toaststate.error);
                        }, builder: (context, state) {
                          if (state is getpaintreportsloading)
                            return loadingshimmer();
                          if (state is getpaintreportsfailure)
                            return SizedBox();
                          else {
                            if (BlocProvider.of<paintreportcuibt>(context)
                                .mypaintreport
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: appcolors
                                                              .maincolor,
                                                        )),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  content: paintreportitem(
                                                    paintreports: BlocProvider
                                                            .of<paintreportcuibt>(
                                                                context)
                                                        .mypaintreport[i],
                                                  ),
                                                );
                                              });
                                        },
                                        child: customtablepaintreportsitem(
                                            checkbox: Checkbox(
                                                value:
                                                    BlocProvider.of<paintreportcuibt>(
                                                            context)
                                                        .checks[i],
                                                onChanged: (val) {
                                                  BlocProvider.of<
                                                              paintreportcuibt>(
                                                          context)
                                                      .changechecbox(
                                                          val: val!, index: i);
                                                }),
                                            prodname: BlocProvider.of<
                                                    paintreportcuibt>(context)
                                                .mypaintreport[i]
                                                .prodname,
                                            injscrap: BlocProvider.of<
                                                    paintreportcuibt>(context)
                                                .mypaintreport[i]
                                                .scrapinjquantity,
                                            paintscrap:
                                                BlocProvider.of<paintreportcuibt>(
                                                        context)
                                                    .mypaintreport[i]
                                                    .scrappaintquantity
                                                    .toString(),
                                            productquantity:
                                                BlocProvider.of<paintreportcuibt>(
                                                        context)
                                                    .mypaintreport[i]
                                                    .actualprodquantity
                                                    .toString(),
                                            delet: IconButton(
                                                onPressed: () {
                                                  if (!permession.contains(
                                                    'حذف تقرير الرش',
                                                  ))
                                                    showdialogerror(
                                                        error:
                                                            "ليس لديك الصلاحيه لحذف التقرير",
                                                        context: context);
                                                  else
                                                    awsomdialogerror(
                                                        context: context,
                                                        mywidget: BlocConsumer<
                                                            paintreportcuibt,
                                                            paintreportstates>(
                                                          listener:
                                                              (context, state) {
                                                            if (state
                                                                is deletepaintreportsuccess) {
                                                              Navigator.pop(
                                                                  context);

                                                              showtoast(
                                                          context: context,           message: state
                                                                      .successmessage,
                                                                  toaststate:
                                                                      Toaststate
                                                                          .succes);
                                                            }
                                                            if (state
                                                                is deletepaintreportfailure) {
                                                              Navigator.pop(
                                                                  context);

                                                              showtoast(
                                                          context: context,           message: state
                                                                      .errormessage,
                                                                  toaststate:
                                                                      Toaststate
                                                                          .error);
                                                            }
                                                          },
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is deletepaintreportloading)
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
                                                                        await BlocProvider.of<paintreportcuibt>(context).deletepaintreport(
                                                                            prduction:
                                                                                BlocProvider.of<paintreportcuibt>(context).mypaintreport[i]);
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
                                                                            TextAlign.center,
                                                                      )),
                                                            );
                                                          },
                                                        ),
                                                        tittle:
                                                            "هل تريد تقرير  ${BlocProvider.of<paintreportcuibt>(context).mypaintreport[i].date}");
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
                                      BlocProvider.of<paintreportcuibt>(context)
                                          .mypaintreport
                                          .length);
                            }
                          }
                        }))),
              ]);
            })));
  }
}
