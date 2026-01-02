import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/alertcontent.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/addproduction.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/customtableproductionitem.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/injectionusage.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/updatealert.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';

class injectionhall extends StatefulWidget {
  final bool status;
  final int index;
  const injectionhall({super.key, required this.status, required this.index});
  @override
  State<injectionhall> createState() => _injectionState();
}

class _injectionState extends State<injectionhall> {
  final injectionheader = [
    "رقم\nالاوردر",
    "اسم\nالمنتج",
    "الكميه",
    "الكميه\nالمتبقيه",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<injectionhallcuibt>(context)
        .getinjection(status: widget.status);

  
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 50,
        color: appcolors.maincolor.withOpacity(0.7),
        child: Row(
            children: injectionheader
                .map((e) => customheadertable(
                      title: e,
                      flex: e == "تعديل" ||
                              e == "حذف" ||
                              e == "اسم\nالخط" ||
                              e == "حالة\nالاوردر"
                          ? 2
                          : 3,
                    ))
                .toList()),
      ),
      Expanded(
          child: RefreshIndicator(
        onRefresh: () async {},
        child: BlocConsumer<injectionhallcuibt, injectionhalltates>(
            listener: (context, state) {
          if (state is getinjectionhalltatefailure)
            showtoast(
                                                                                                context: context,

                message: state.error_message, toaststate: Toaststate.error);
        }, builder: (context, state) {
          if (state is getinjectionhalltateloading) return loadingshimmer();
          if (state is getinjectionhalltatefailure)
            return SizedBox();
          else {
            if (BlocProvider.of<injectionhallcuibt>(context)
                .myinjection
                .isEmpty)
              return nodata();
            else {
              return ListView.separated(
                  itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          navigateto(
                              context: context,
                              page: injectionusage(
                                  injection:
                                      BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .myinjection[i]));
                        },
                        child: customtableinjectionshallitem(
                            edit: IconButton(
                                onPressed: () {
                                  if (BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .myinjection[i]
                                          .status ==
                                      true) {
                                    showdialogerror(
                                        error: "عفوا تم انتهاء الاوردر",
                                        context: context);
                                  } else {
                                    if (!permession.contains('تعديل اوردر حقن')) {
                                      showdialogerror(
                                          error: "ليس لديك الصلاحيه",
                                          context: context);
                                    } else {
                                
                                      BlocProvider.of<productionusagecuibt>(
                                              context)
                                          .changetype(
                                              value: BlocProvider.of<DateCubit>(
                                                          context)
                                                      .producthalldate =
                                                  BlocProvider.of<injectionhallcuibt>(
                                                                  context)
                                                              .myinjection[i]
                                                              .status ==
                                                          false
                                                      ? "لا"
                                                      : "نعم");
                                      BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .changeordersprue(
                                              val: BlocProvider.of<injectionhallcuibt>(
                                                          context)
                                                      .type =
                                                  BlocProvider.of<injectionhallcuibt>(
                                                                  context)
                                                              .myinjection[i]
                                                              .sprue ==
                                                          false
                                                      ? "بدون"
                                                      : "بمصب");
                                      BlocProvider.of<MoldsCubit>(context)
                                          .moldchange(BlocProvider.of<
                                                  injectionhallcuibt>(context)
                                              .myinjection[i]
                                              .name);

                                      BlocProvider.of<MoldsCubit>(context)
                                          .materialchange(BlocProvider.of<
                                                  injectionhallcuibt>(context)
                                              .myinjection[i]
                                              .materialtype);
                                      BlocProvider.of<DateCubit>(context)
                                              .producthalldate =
                                          BlocProvider.of<injectionhallcuibt>(
                                                  context)
                                              .myinjection[i]
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
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color:
                                                            appcolors.maincolor,
                                                      )),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                backgroundColor: Colors.white,
                                                insetPadding:
                                                    EdgeInsets.all(35),
                                                content: Updatealert(
                                                  producedquantity: BlocProvider.of<injectionhallcuibt>(context)
                                                            .myinjection[i].producedquantity,
                                                    notes: TextEditingController(
                                                        text: BlocProvider.of<injectionhallcuibt>(context)
                                                            .myinjection[i]
                                                            .notes),
                                                    quantity: TextEditingController(
                                                        text: BlocProvider.of<injectionhallcuibt>(context)
                                                            .myinjection[i]
                                                            .quantity),
                                                    purepercentaege: TextEditingController(
                                                        text: BlocProvider.of<injectionhallcuibt>(context)
                                                            .myinjection[i]
                                                            .pureper),
                                                    breakpercentage: TextEditingController(
                                                        text: BlocProvider.of<injectionhallcuibt>(context).myinjection[i].breakper),
                                                    masterpersentage: TextEditingController(text: BlocProvider.of<injectionhallcuibt>(context).myinjection[i].masterper),
                                                    color: TextEditingController(text: BlocProvider.of<injectionhallcuibt>(context).myinjection[i].color),
                                                    ordernumber: BlocProvider.of<injectionhallcuibt>(context).myinjection[i].ordernumber,
                                                    machine: TextEditingController(text: BlocProvider.of<injectionhallcuibt>(context).myinjection[i].machine)));
                                          });
                                    }
                                  }
                                },
                                icon: Icon(editeicon)),
                            producedquantity: BlocProvider.of<injectionhallcuibt>(context)
                                .myinjection[i]
                                .producedquantity,
                            ordernumber:
                                BlocProvider.of<injectionhallcuibt>(context)
                                    .myinjection[i]
                                    .ordernumber,
                            name:
                                "${BlocProvider.of<injectionhallcuibt>(context).myinjection[i].name}-${BlocProvider.of<injectionhallcuibt>(context).myinjection[i].color}",
                            quantaity:
                                BlocProvider.of<injectionhallcuibt>(context)
                                    .myinjection[i]
                                    .quantity,
                            delet: IconButton(
                                onPressed: () {
                                  if (BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .myinjection[i]
                                          .status ==
                                      true) {
                                    showdialogerror(
                                        error: "عفوا تم انتهاء الاوردر",
                                        context: context);
                                  } else {
                                    if (!permession.contains('حذف اوردر حقن')) {
                                      showdialogerror(
                                          error: "ليس لديك الصلاحيه",
                                          context: context);
                                    } else {
                                      awsomdialogerror(
                                          context: context,
                                          mywidget: BlocConsumer<
                                              injectionhallcuibt,
                                              injectionhalltates>(
                                            listener: (context, state) {
                                              if (state
                                                  is deleteinjectionhalltatesuccess) {
                                                Navigator.pop(context);

                                                showtoast(
                                                                                                                                    context: context,

                                                    message:
                                                        state.success_message,
                                                    toaststate:
                                                        Toaststate.succes);
                                              }
                                              if (state
                                                  is deleteinjectionhalltatefailure) {
                                                Navigator.pop(context);

                                                showtoast(
                                                                                                                                    context: context,

                                                    message:
                                                        state.error_message,
                                                    toaststate:
                                                        Toaststate.error);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is deleteinjectionhalltateloadind)
                                                return deleteloading();
                                              return SizedBox(
                                                height: 50,
                                                width: 100,
                                                child: ElevatedButton(
                                                    style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Color.fromARGB(
                                                                  255,
                                                                  37,
                                                                  163,
                                                                  42)),
                                                    ),
                                                    onPressed: () async {
                                                      await BlocProvider.of<
                                                                  injectionhallcuibt>(
                                                              context)
                                                          .deleteinjection(
                                                              prduction: BlocProvider
                                                                      .of<injectionhallcuibt>(
                                                                          context)
                                                                  .myinjection[i]);
                                                    },
                                                    child: const Text(
                                                      "تاكيد",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "cairo",
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              );
                                            },
                                          ),
                                          tittle:
                                              "هل تريد حذف الاوردر رقم ${BlocProvider.of<injectionhallcuibt>(context).myinjection[i].ordernumber}");
                                    }
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
                  itemCount: BlocProvider.of<injectionhallcuibt>(context)
                      .myinjection
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
                            content: Alertinjectioncontent(),
                          );
                        }); 
                },
                child: Container(
                  height: 45,
                  width: 45,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: appcolors.primarycolor,
                      borderRadius: BorderRadius.circular(7)),
                )),SizedBox(width: 10,),
            InkWell(
                onTap: () async {
 await BlocProvider.of<injectionhallcuibt>(context)
        .getinjection(status: widget.status);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: appcolors.primarycolor,
                      borderRadius: BorderRadius.circular(7)),
                )),SizedBox(width: 10,),
          if (widget.index == 0)
            InkWell(
                onTap: () async {
                  if (permession.contains('اضافة اوردر حقن')) {
                    navigateto(context: context, page: addinreport(

                      ordernumber: "${DateTime.now().year}${DateTime.now().month<10?"0${DateTime.now().month}":"${DateTime.now().month}"}${DateTime.now().day<10?"0${DateTime.now().day}":"${DateTime.now().day}"}${DateTime.now().hashCode<10?"0${DateTime.now().hour}":"${DateTime.now().hour}"}${DateTime.now().minute<10?"0${DateTime.now().minute}":"${DateTime.now().minute}"}${DateTime.now().second<10?"0${DateTime.now().second}":"${DateTime.now().second}"}",
                    ));
                  } else {
                    showdialogerror(
                        error: "ليس لديك الصلاحيه للدخول لهذه الصفحه",
                        context: context);
                  }
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: appcolors.primarycolor,
                      borderRadius: BorderRadius.circular(7)),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
          
          SizedBox(
            width: 15,
          ),
        ],
      ),
      SizedBox(height: 10,)
    ]);
  }
}
