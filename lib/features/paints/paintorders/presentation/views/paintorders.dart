import 'package:flutter/material.dart';
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

import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintstate.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagecuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/addpaintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/alertpaintcontent.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/customtablepaintitem.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/paintusage.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/updatepaintalert.dart';

class Paintorders extends StatefulWidget {
  @override
  State<Paintorders> createState() => _PaintordersState();
}

class _PaintordersState extends State<Paintorders> {
  final paintheader = [
    "التاريخ",
    "اسم\nالمنتج",
    "الكميه",
    "حالة\nالاوردر",
    "نسبة\nالهالك",
    "معدل\nتحقيق الاوردر",
  ];

  getdata() async {
    await BlocProvider.of<paintcuibt>(context).getpaintorders();
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
                      BlocProvider.of<paintcuibt>(context).refreshdata();
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
                              content: Alertpaintcontent(),
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
                "اوردرات الرش",
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
                    children: paintheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" ||
                                      e == "حذف" ||
                                      e == "معدل\nتحقيق الاوردر" ||
                                      e == "نسبة\nالهالك" ||
                                      e == "حالة\nالاوردر"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<paintcuibt>(context).getpaintorders();
                },
                child: BlocConsumer<paintcuibt, painttates>(
                    listener: (context, state) {
                  if (state is getpainttatefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getpainttateloading) return loadingshimmer();
                  if (state is getpainttatefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<paintcuibt>(context)
                        .mypaintorders
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  navigateto(
                                      context: context,
                                      page: paintusage(
                                          paintmodel:
                                              BlocProvider.of<paintcuibt>(
                                                      context)
                                                  .mypaintorders[i]));
                                },
                                child: customtablepaintshallitem(
                                    scrapper: BlocProvider.of<paintcuibt>(context)
                                                .mypaintorders[i]
                                                .scrapquantity ==
                                            "0"
                                        ? "0"
                                        : ((double.parse(BlocProvider.of<paintcuibt>(context).mypaintorders[i].scrapquantity.toString()) /
                                                    (double.parse(BlocProvider.of<paintcuibt>(context).mypaintorders[i].scrapquantity.toString()) +
                                                        double.parse(BlocProvider.of<paintcuibt>(context)
                                                            .mypaintorders[i]
                                                            .actualprod
                                                            .toString()))) *
                                                100)
                                            .toStringAsFixed(1),
                                    rightper:
                                        BlocProvider.of<paintcuibt>(context).mypaintorders[i].actualprod == "0"
                                            ? "0"
                                            : (100 - ((double.parse(BlocProvider.of<paintcuibt>(context).mypaintorders[i].scrapquantity.toString()) / (double.parse(BlocProvider.of<paintcuibt>(context).mypaintorders[i].scrapquantity.toString()) + double.parse(BlocProvider.of<paintcuibt>(context).mypaintorders[i].actualprod.toString()))) * 100))
                                                .toStringAsFixed(1),
                                    edit: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<paintusagecuibt>(
                                                  context)
                                              .changetype(
                                                  value: BlocProvider
                                                              .of<DateCubit>(
                                                                  context)
                                                          .producthalldate =
                                                      BlocProvider.of<paintcuibt>(
                                                                      context)
                                                                  .mypaintorders[
                                                                      i]
                                                                  .status ==
                                                              false
                                                          ? "لا"
                                                          : "نعم");

                                          BlocProvider.of<DateCubit>(context)
                                                  .producthalldate =
                                              BlocProvider.of<paintcuibt>(
                                                      context)
                                                  .mypaintorders[i]
                                                  .date;

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
                                                    backgroundColor:
                                                        Colors.white,
                                                    insetPadding:
                                                        EdgeInsets.all(35),
                                                    content: Updatepaintalert(
                                                        boyacode: TextEditingController(
                                                            text: BlocProvider.of<paintcuibt>(context)
                                                                .mypaintorders[
                                                                    i]
                                                                .boyacode
                                                                .toString()),
                                                        prodcode: TextEditingController(
                                                            text: BlocProvider.of<
                                                                    paintcuibt>(context)
                                                                .mypaintorders[i]
                                                                .prodcode
                                                                .toString()),
                                                        warnishcode: TextEditingController(text: BlocProvider.of<paintcuibt>(context).mypaintorders[i].warnishcode.toString()),
                                                        scrapquantity: BlocProvider.of<paintcuibt>(context).mypaintorders[i].scrapquantity.toString(),
                                                        actualprod: BlocProvider.of<paintcuibt>(context).mypaintorders[i].actualprod.toString(),
                                                        notes: TextEditingController(text: BlocProvider.of<paintcuibt>(context).mypaintorders[i].notes),
                                                        quantity: TextEditingController(text: BlocProvider.of<paintcuibt>(context).mypaintorders[i].quantity),
                                                        ordernumber: TextEditingController(text: BlocProvider.of<paintcuibt>(context).mypaintorders[i].ordernumber),
                                                        prodname: TextEditingController(text: BlocProvider.of<paintcuibt>(context).mypaintorders[i].name)));
                                              });
                                        },
                                        icon: Icon(editeicon)),
                                    status: BlocProvider.of<paintcuibt>(context).mypaintorders[i].status,
                                    date: BlocProvider.of<paintcuibt>(context).mypaintorders[i].date,
                                    name: "${BlocProvider.of<paintcuibt>(context).mypaintorders[i].name}",
                                    quantaity: BlocProvider.of<paintcuibt>(context).mypaintorders[i].quantity,
                                    delet: IconButton(
                                        onPressed: () {
                                          if (permession
                                              .contains('حذف اوردرت الرش'))
                                            showdialogerror(
                                                error: "ليس لديك الصلاحيه",
                                                context: context);
                                          else
                                            awsomdialogerror(
                                                context: context,
                                                mywidget: BlocConsumer<
                                                    paintcuibt, painttates>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is deletepainttatesuccess) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .success_message,
                                                          toaststate: Toaststate
                                                              .succes);
                                                    }
                                                    if (state
                                                        is deletepainttatefailure) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .error_message,
                                                          toaststate:
                                                              Toaststate.error);
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    if (state
                                                        is deletepainttateloadind)
                                                      return deleteloading();
                                                    return SizedBox(
                                                      height: 50,
                                                      width: 100,
                                                      child: ElevatedButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        37,
                                                                        163,
                                                                        42)),
                                                          ),
                                                          onPressed: () async {
                                                            await BlocProvider
                                                                    .of<paintcuibt>(
                                                                        context)
                                                                .deletepaintorder(
                                                                    paint: BlocProvider.of<paintcuibt>(
                                                                            context)
                                                                        .mypaintorders[i]);
                                                          },
                                                          child: const Text(
                                                            "تاكيد",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "cairo",
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                    );
                                                  },
                                                ),
                                                tittle:
                                                    "هل تريد حذف الاوردر رقم ${BlocProvider.of<paintcuibt>(context).mypaintorders[i].ordernumber}");
                                        },
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        ))),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<paintcuibt>(context)
                              .mypaintorders
                              .length);
                    }
                  }
                }),
              )),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () async {
                        if (!permession.contains('اضافة اوردرت الرش')) {
                          showdialogerror(
                              error: "ليس لديك الصلاحيه", context: context);
                        } else
                          navigateto(context: context, page: addpaintorder());
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
              ),
            ])));
  }
}
