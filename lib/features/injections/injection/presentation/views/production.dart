import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/excell.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/addproduction.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/alertcontent.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/customtableproductionitem.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/productionitem.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/timer.dart';

class production extends StatefulWidget {
  @override
  State<production> createState() => _productionState();
}

class _productionState extends State<production> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController workername = TextEditingController();

  TextEditingController machinenumber = TextEditingController();

  TextEditingController cycletime = TextEditingController();

  TextEditingController numberofpieces = TextEditingController();

  TextEditingController workhours = TextEditingController();

  TextEditingController counterstart = TextEditingController();

  TextEditingController counterend = TextEditingController();

  TextEditingController realprodcountity = TextEditingController();

  TextEditingController expectedprod = TextEditingController();

  TextEditingController scrapcountity = TextEditingController();

  TextEditingController proddivision = TextEditingController();

  TextEditingController machinestop = TextEditingController();
  TextEditingController shift = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  String? x;
  final productionheader = [
    "رقم الماكينه",
    "اسم العامل",
    "اسم المنتج",
    "كمية الانتاج",
    "تحديد",
    "حذف",
  ];

  getdata() async {
    /* await BlocProvider.of<productioncuibt>(context).getproduction(
        date:
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');*/
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
                SizedBox(
                  width: 7,
                ),
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
                    toggleButtonSize: 30,
                    toggleButtonColor: appcolors.maincolor,
                    alignment: Alignment.bottomLeft,
                    backgroundWidget: RefreshIndicator(
                      onRefresh: () async {
                        await BlocProvider.of<productioncuibt>(context)
                            .getproduction(
                                date:
                                    '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');
                      },
                      child: BlocConsumer<productioncuibt, productiontates>(
                          listener: (context, state) {
                        if (state is getproductiontatefailure)
                          showtoast(
                                                                                                              context: context,

                              message: state.error_message,
                              toaststate: Toaststate.error);
                      }, builder: (context, state) {
                        if (state is getproductiontateloading)
                          return loadingshimmer();
                        if (state is getproductiontatefailure)
                          return SizedBox();
                        else {
                          if (BlocProvider.of<productioncuibt>(context)
                              .myproduction
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
                                                scrollable: true,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                content: Productionitem(
                                                  productions: BlocProvider.of<
                                                              productioncuibt>(
                                                          context)
                                                      .myproduction[i],
                                                ),
                                              );
                                            });
                                      },
                                      child: customtableproductionsitem(
                                          checkbox: Checkbox(
                                              value: BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .checks[i],
                                              onChanged: (val) {
                                                BlocProvider.of<
                                                            productioncuibt>(
                                                        context)
                                                    .changechecbox(
                                                        val: val!, index: i);
                                              }),
                                          worker: BlocProvider.of<productioncuibt>(
                                                  context)
                                              .myproduction[i]
                                              .workername,
                                          machinenumber:
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .myproduction[i]
                                                  .machinenumber,
                                          productname:
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .myproduction[i]
                                                  .prodname,
                                          productquantity:
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .myproduction[i]
                                                  .realprodcountity,
                                          delet: IconButton(
                                              onPressed: () {
                                                if (cashhelper.getdata(
                                                        key: "email") !=
                                                    "ahmedaaallam123@gmail.com")
                                                  showdialogerror(
                                                      error:
                                                          "ليس لديك الصلاحيه لحذف التقرير",
                                                      context: context);
                                                else
                                                  awsomdialogerror(
                                                      context: context,
                                                      mywidget: BlocConsumer<
                                                          productioncuibt,
                                                          productiontates>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is deleteproductiontatesuccess) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                          context: context,         message: state
                                                                    .success_message,
                                                                toaststate:
                                                                    Toaststate
                                                                        .succes);
                                                          }
                                                          if (state
                                                              is deleteproductiontatefailure) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                          context: context,         message: state
                                                                    .error_message,
                                                                toaststate:
                                                                    Toaststate
                                                                        .error);
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is deleteproductiontateloadind)
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
                                                                      await BlocProvider.of<productioncuibt>(
                                                                              context)
                                                                          .deleteproduction(
                                                                              prduction: BlocProvider.of<productioncuibt>(context).myproduction[i]);
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
                                                          "هل تريد حذف تقرير ماكينه رقم ${BlocProvider.of<productioncuibt>(context).myproduction[i].machinenumber}");
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
                                    BlocProvider.of<productioncuibt>(context)
                                        .myproduction
                                        .length);
                          }
                        }
                      }),
                    ),
                    items: [
                      CircularMenuItem(
                        icon: Icons.add,
                        onTap: () {
                          if (!permession.contains('اضافة تقرير حقن')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: addreport());
                        },
                        color: Colors.green,
                        iconColor: Colors.white,
                      ),
                      CircularMenuItem(
                        icon: Icons.timer,
                        onTap: () {
                          if (!permession.contains('عرض زمن حقن')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: timer());
                        },
                        color: Colors.orange,
                        iconColor: Colors.white,
                      ),
                      CircularMenuItem(
                        icon: Icons.share,
                        onTap: () async {
                          List<productionmodel> prductions = [];
                          for (int i = 0;
                              i <
                                  BlocProvider.of<productioncuibt>(context)
                                      .checks
                                      .length;
                              i++) {
                            if (BlocProvider.of<productioncuibt>(context)
                                    .checks[i] ==
                                true) {
                              prductions.add(
                                  BlocProvider.of<productioncuibt>(context)
                                      .myproduction[i]);
                            }
                          }
                          await shareexcell(
                              date: prductions[0].date,
                              productions: prductions);
                        },
                        color: Colors.deepPurple,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ]);
            })));
  }
}
