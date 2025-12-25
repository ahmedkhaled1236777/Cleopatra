import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/produsage.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/produsagestate.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/customtableproductionitem%20copy.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/injcopdf.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/injotrderdialog.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/ordermaterialdialog.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as gg;
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/diagnosepiechart.dart';
import 'package:share_plus/share_plus.dart';

class injectionusage extends StatefulWidget {
  final injectionhallmodel injection;

  injectionusage({super.key, required this.injection});
  @override
  State<injectionusage> createState() => _injectionState();
}

class _injectionState extends State<injectionusage> {
  final injectionheader = [
    "التاريخ",
    "اسم\nالمنتج",
    "الكميه",
    "رقم\nالورديه",
  ];

  getdata() async {
    await BlocProvider.of<injectionusagecuibt>(context)
        .getinjection(docid: widget.injection.ordernumber);
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
                      if (BlocProvider.of<productioncuibt>(context).timerrate[
                              "${widget.injection.name}-${widget.injection.materialtype}"] !=
                          null)
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
                                content: Ordermaterialdialog(
                                  injectionhallmod: widget.injection,
                                  residualquantity:
                                      double.parse(widget.injection.quantity) -
                                          BlocProvider.of<injectionusagecuibt>(
                                                  context)
                                              .total,
                                ),
                              );
                            });
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ))
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "رقم امر الشغل : ${widget.injection.ordernumber}\n ${widget.injection.name} ${widget.injection.color} - ${widget.injection.quantity} ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: injectionheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "رقم\nالماكينه" ||
                                      e == "حذف" ||
                                      e == "رقم\nالورديه"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<injectionusagecuibt>(context)
                      .getinjection(docid: widget.injection.ordernumber);
                },
                child: BlocConsumer<injectionusagecuibt, injectionusagetates>(
                    listener: (context, state) {
                  if (state is getinjectionusagetatefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getinjectionusagetateloading)
                    return loadingshimmer();
                  if (state is getinjectionusagetatefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<injectionusagecuibt>(context)
                        .myinjection
                        .isEmpty)
                      return nodata();
                    else {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  gg.Get.to(
                                      Diagnosepiechart(
                                          ordername:
                                              "${widget.injection.ordernumber}\n ${widget.injection.name} ${widget.injection.color} - ${widget.injection.quantity}",
                                          errors: BlocProvider.of<
                                                  injectionusagecuibt>(context)
                                              .diagnoses),
                                      transition:
                                          gg.Transition.rightToLeftWithFade,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                },
                                icon: Icon(
                                  Icons.percent_outlined,
                                  color: appcolors.primarycolor,
                                )),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, i) => InkWell(
                                        onTap: () {
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
                                                          Navigator.of(context)
                                                              .pop();
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
                                                  content: Injotrderdialog(
                                                    productions: BlocProvider
                                                            .of<injectionusagecuibt>(
                                                                context)
                                                        .myinjection[i],
                                                  ),
                                                );
                                              });
                                        },
                                        child: customtableinjectionsusageitem(
                                            shift: BlocProvider.of<
                                                        injectionusagecuibt>(
                                                    context)
                                                .myinjection[i]
                                                .shift!,
                                            date: BlocProvider.of<
                                                        injectionusagecuibt>(
                                                    context)
                                                .myinjection[i]
                                                .date,
                                            name: widget.injection.name,
                                            quantaity: BlocProvider.of<
                                                        injectionusagecuibt>(
                                                    context)
                                                .myinjection[i]
                                                .quantity,
                                            delet: IconButton(
                                                onPressed: () {
                                                  if (int.parse(widget.injection
                                                                  .quantity) -
                                                              BlocProvider.of<
                                                                          injectionusagecuibt>(
                                                                      context)
                                                                  .total ==
                                                          0 ||
                                                      BlocProvider.of<injectionusagecuibt>(
                                                                  context)
                                                              .myinjection[0]
                                                              .status ==
                                                          "نعم")
                                                    showdialogerror(
                                                        error:
                                                            "لقد انتهي الاوردر غير قادر علي الحذف",
                                                        context: context);
                                                  else
                                                    awsomdialogerror(
                                                        context: context,
                                                        mywidget: BlocConsumer<
                                                            injectionusagecuibt,
                                                            injectionusagetates>(
                                                          listener:
                                                              (context, state) {
                                                            if (state
                                                                is deleteinjectionusagetatesuccess) {
                                                              Navigator.pop(
                                                                  context);

                                                              showtoast(
                                                          context: context,           message: state
                                                                      .success_message,
                                                                  toaststate:
                                                                      Toaststate
                                                                          .succes);
                                                            }
                                                            if (state
                                                                is deleteinjectionusagetatefailure) {
                                                              Navigator.pop(
                                                                  context);

                                                              showtoast(
                                                          context: context,           message: state
                                                                      .error_message,
                                                                  toaststate:
                                                                      Toaststate
                                                                          .error);
                                                            }
                                                          },
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is deleteinjectionusagetateloadind)
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
                                                                        await BlocProvider.of<injectionusagecuibt>(context).deleteinjections(
                                                                            prduction:
                                                                                BlocProvider.of<injectionusagecuibt>(context).myinjection[i],
                                                                            docid: widget.injection.ordernumber);
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
                                                            "هل تريد حذف التقرير ");
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
                                      BlocProvider.of<injectionusagecuibt>(
                                              context)
                                          .myinjection
                                          .length),
                            )
                          ]);
                    }
                  }
                }),
              )),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () async {
                        final img = await rootBundle
                            .load("assets/images/cleopatra-modified.png");
                        final imageBytes = img.buffer.asUint8List();
                        File file = await Injorderpdf.generatepdf(
                            prodname: widget.injection.name,
                            color: widget.injection.color,
                            imageBytes: imageBytes,
                            time:
                                " ${((((int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total).toDouble() * BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["cycletime"]) / int.parse(BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["numberofpieces"])) / (60 * 60)).toStringAsFixed(1)} ساعه  - ${((((((int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total).toDouble() * BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["cycletime"]) / int.parse(BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["numberofpieces"])) / (60 * 60))) / 24).toStringAsFixed(1)} يوم",
                            orderquantity: widget.injection.quantity,
                            producedquantity:
                                BlocProvider.of<injectionusagecuibt>(context)
                                    .total
                                    .toString(),
                            ordername: widget.injection.name,
                            timefrom: widget.injection.timestart,
                            timeto: widget.injection.timeend,
                            resetquantity:
                                "${int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total}",
                            context: context,
                            categories:
                                BlocProvider.of<injectionusagecuibt>(context)
                                    .myinjection);
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
                ),
              ),
              SizedBox(
                width: 7,
              ),
              BlocBuilder<injectionusagecuibt, injectionusagetates>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    color: Color(0xff535C91),
                    child: Column(
                      children: [
                        Text(
                          " الكميه المنتجه : ${BlocProvider.of<injectionusagecuibt>(context).total}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "  المتبقي من الاوردر : ${int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        if (BlocProvider.of<productioncuibt>(context).timerrate[
                                    "${widget.injection.name}-${widget.injection.materialtype}"] !=
                                null &&
                            widget.injection.status == false)
                          Text(
                            " الوقت المتبقي لانتهاء الاوردر : ${((((int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total).toDouble() * BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["cycletime"]) / int.parse(BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["numberofpieces"])) / (60 * 60)).toStringAsFixed(1)} ساعه  - ${((((((int.parse(widget.injection.quantity) - BlocProvider.of<injectionusagecuibt>(context).total).toDouble() * BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["cycletime"]) / int.parse(BlocProvider.of<productioncuibt>(context).timerrate["${widget.injection.name}-${widget.injection.materialtype}"]!["numberofpieces"])) / (60 * 60))) / 24).toStringAsFixed(1)} يوم",
                            style: TextStyle(
                                fontFamily: "cairo", color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  );
                },
              )
            ])));
  }
}
