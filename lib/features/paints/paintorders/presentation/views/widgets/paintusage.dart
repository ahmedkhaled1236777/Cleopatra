import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagecuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagestate.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/customtablepaintitem%20copy.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/views/widgets/paintorderspdf.dart';
import 'package:share_plus/share_plus.dart';

class paintusage extends StatefulWidget {
  final Paintmodel paintmodel;

  paintusage({super.key, required this.paintmodel});
  @override
  State<paintusage> createState() => _injectionState();
}

class _injectionState extends State<paintusage> {
  final injectionheader = [
    "التاريخ",
    "كمية الانتاج",
    "كمية هالك الرش",
    "كمية هالك الحقن",
  ];

  getdata() async {
    print("pppppppppppppppppppppppppppppppppppppppppppppp");
    print(widget.paintmodel.name);
    await BlocProvider.of<paintusagecuibt>(context)
        .getpaint(docid: widget.paintmodel.ordernumber);
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
              actions: [],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "رقم امر الشغل : ${widget.paintmodel.ordernumber}\n ${widget.paintmodel.name} - ${widget.paintmodel.quantity} ",
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
                  await BlocProvider.of<paintusagecuibt>(context)
                      .getpaint(docid: widget.paintmodel.ordernumber);
                },
                child: BlocConsumer<paintusagecuibt, paintusagetates>(
                    listener: (context, state) {
                  if (state is getpaintusagetatefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getpaintusagetateloading)
                    return loadingshimmer();
                  if (state is getpaintusagetatefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<paintusagecuibt>(context)
                        .mypaint
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: Container(
                                  color: (BlocProvider.of<paintusagecuibt>(
                                                          context)
                                                      .mypaint[i]
                                                      .paintscrapquantity /
                                                  (BlocProvider.of<
                                                                  paintusagecuibt>(
                                                              context)
                                                          .mypaint[i]
                                                          .paintscrapquantity +
                                                      BlocProvider.of<
                                                                  paintusagecuibt>(
                                                              context)
                                                          .mypaint[i]
                                                          .quantity)) *
                                              100 >
                                          1
                                      ? Colors.red
                                      : Colors.white,
                                  child: customtablepaintsusageitem(
                                    injscrap: BlocProvider.of<paintusagecuibt>(
                                            context)
                                        .mypaint[i]
                                        .injscrapquantity,
                                    date: BlocProvider.of<paintusagecuibt>(
                                            context)
                                        .mypaint[i]
                                        .date,
                                    paintscrap:
                                        BlocProvider.of<paintusagecuibt>(
                                                context)
                                            .mypaint[i]
                                            .paintscrapquantity
                                            .toString(),
                                    quantaity: BlocProvider.of<paintusagecuibt>(
                                            context)
                                        .mypaint[i]
                                        .quantity
                                        .toString(),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<paintusagecuibt>(context)
                              .mypaint
                              .length);
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
                            .load('assets/images/cleopatra-modified.png');
                        final imageBytes = img.buffer.asUint8List();
                        File file = await Paintorderspdf.generatepdf(
                            name: widget.paintmodel.name,
                            resetproduced:
                                "${int.parse(widget.paintmodel.quantity) - BlocProvider.of<paintusagecuibt>(context).total}",
                            totalboya:
                                "${BlocProvider.of<paintusagecuibt>(context).totalboya.toStringAsFixed(1)}",
                            totalproduced:
                                "${BlocProvider.of<paintusagecuibt>(context).total}",
                            totalscrappaint:
                                "${BlocProvider.of<paintusagecuibt>(context).totalscrap}",
                            context: context,
                            imageBytes: imageBytes,
                            categories:
                                BlocProvider.of<paintusagecuibt>(context)
                                    .mypaint);
                        await Share.shareXFiles([XFile(file.path)]);
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
              BlocBuilder<paintusagecuibt, paintusagetates>(
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    color: Color(0xff535C91),
                    child: Column(
                      children: [
                        Text(
                          " الكميه المنتجه : ${BlocProvider.of<paintusagecuibt>(context).total}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "  اجمالى هالك الرش : ${BlocProvider.of<paintusagecuibt>(context).totalscrap}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "  اجمالى البويا المستخدمه : ${BlocProvider.of<paintusagecuibt>(context).totalboya.toStringAsFixed(1)}  جرام",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "  المتبقي من الاوردر : ${int.parse(widget.paintmodel.quantity) - BlocProvider.of<paintusagecuibt>(context).total}",
                          style: TextStyle(
                              fontFamily: "cairo", color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "    الوقت المتوقع لانتهاء الاوردر : ${(((num.parse(widget.paintmodel.quantity) - num.parse(BlocProvider.of<paintusagecuibt>(context).total.toString())) * num.parse(BlocProvider.of<paintaverageCubit>(context).paintaveragerate[widget.paintmodel.name].toString())) / 60).toStringAsFixed(1)}  ساعه",
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
