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
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/addproduction.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/widgets/customtableproductionitem.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/widgets/store.dart';
import 'package:share_plus/share_plus.dart';

class productionusage extends StatefulWidget {
  final productionhallmodel production;

  const productionusage({super.key, required this.production});
  @override
  State<productionusage> createState() => _productionState();
}

class _productionState extends State<productionusage> {
  final productionheader = [
    "التاريخ",
    "اسم\nالمنتج",
    "الكميه",
    "اسم الخط",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<productionusagecuibt>(context)
        .getproduction(docid: widget.production.ordernumber);
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
                      final img = await rootBundle
                          .load('assets/images/cleopatra-modified.png');
                      final imageBytes = img.buffer.asUint8List();
                      File file = await Storepdf.generatepdf(
                          orderquantity: widget.production.quantity,
                          totalproduced:
                              "${BlocProvider.of<productionusagecuibt>(context).total}",
                          date: widget.production.date,
                          name: widget.production.name,
                          ordernumber: widget.production.ordernumber,
                          context: context,
                          imageBytes: imageBytes,
                          categories:
                              BlocProvider.of<productionusagecuibt>(context)
                                  .myproduction);
                      Share.shareXFiles([XFile(file.path)]);
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "${widget.production.name} - ${widget.production.quantity}\n رقم امر الشغل : ${widget.production.ordernumber}",
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
                    children: productionheader
                        .map((e) => customheadertable(
                              title: e,
                              flex:
                                  e == "تحديد" || e == "حذف" || e == "اسم الخط"
                                      ? 2
                                      : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<productionusagecuibt>(context)
                      .getproduction(docid: widget.production.ordernumber);
                },
                child: BlocConsumer<productionusagecuibt, productionusagetates>(
                    listener: (context, state) {
                  if (state is getproductionusagetatefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getproductionusagetateloading)
                    return loadingshimmer();
                  if (state is getproductionusagetatefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<productionusagecuibt>(context)
                        .myproduction
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: customtableproductionsusageitem(
                                    line: widget.production.line,
                                    date: BlocProvider.of<productionusagecuibt>(
                                            context)
                                        .myproduction[i]
                                        .date,
                                    name: widget.production.name,
                                    quantaity:
                                        BlocProvider.of<productionusagecuibt>(
                                                context)
                                            .myproduction[i]
                                            .quantity,
                                    delet: IconButton(
                                        onPressed: () {
                                          if (!permession.contains(
                                              'حذف توريد تقرير تجميع')) {
                                            showdialogerror(
                                                error: "ليس لديك صلاحية الحذف",
                                                context: context);
                                          } else {
                                            if (int.parse(widget.production
                                                            .quantity) -
                                                        BlocProvider.of<
                                                                    productionusagecuibt>(
                                                                context)
                                                            .total ==
                                                    0 ||
                                                BlocProvider.of<productionusagecuibt>(
                                                            context)
                                                        .myproduction[0]
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
                                                      productionusagecuibt,
                                                      productionusagetates>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is deleteproductionusagetatesuccess) {
                                                        Navigator.pop(context);

                                                        showtoast(
                                                          context: context,     message: state
                                                                .success_message,
                                                            toaststate:
                                                                Toaststate
                                                                    .succes);
                                                      }
                                                      if (state
                                                          is deleteproductionusagetatefailure) {
                                                        Navigator.pop(context);

                                                        showtoast(
                                                          context: context,     message: state
                                                                .error_message,
                                                            toaststate:
                                                                Toaststate
                                                                    .error);
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      if (state
                                                          is deleteproductionusagetateloadind)
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
                                                            onPressed:
                                                                () async {
                                                              await BlocProvider
                                                                      .of<productionusagecuibt>(
                                                                          context)
                                                                  .deleteproduction(
                                                                      prduction:
                                                                          BlocProvider.of<productionusagecuibt>(context).myproduction[
                                                                              i],
                                                                      docid: widget
                                                                          .production
                                                                          .ordernumber);
                                                            },
                                                            child: const Text(
                                                              "تاكيد",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "cairo",
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                      );
                                                    },
                                                  ),
                                                  tittle:
                                                      "هل تريد حذف التقرير ");
                                          }
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
                              BlocProvider.of<productionusagecuibt>(context)
                                  .myproduction
                                  .length);
                    }
                  }
                }),
              )),
              BlocBuilder<productionusagecuibt, productionusagetates>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            if (BlocProvider.of<productionusagecuibt>(context)
                                .myproduction
                                .isEmpty) {
                              navigateto(
                                  context: context,
                                  page: addusagereport(
                                    reset: int.parse(
                                            widget.production.quantity) -
                                        BlocProvider.of<productionusagecuibt>(
                                                context)
                                            .total,
                                    production: widget.production,
                                  ));
                            } else {
                              if (BlocProvider.of<productionusagecuibt>(context)
                                          .total ==
                                      widget.production ||
                                  BlocProvider.of<productionusagecuibt>(context)
                                          .myproduction[0]
                                          .status ==
                                      "نعم") {
                                showdialogerror(
                                    error: "تم انتهاء الاوردر",
                                    context: context);
                              } else
                                navigateto(
                                    context: context,
                                    page: addusagereport(
                                      reset: int.parse(
                                              widget.production.quantity) -
                                          BlocProvider.of<productionusagecuibt>(
                                                  context)
                                              .total,
                                      production: widget.production,
                                    ));
                            }
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
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<productionusagecuibt, productionusagetates>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    color: Color(0xff535C91),
                    child: Column(
                      children: [
                        Text(
                          " الكميه المنتجه : ${BlocProvider.of<productionusagecuibt>(context).total}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "  المتبقي من الاوردر : ${int.parse(widget.production.quantity) - BlocProvider.of<productionusagecuibt>(context).total}",
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
