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
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/componentsdialog.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/views/addproduction.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/views/widgets/customtableproductionitem.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/production.dart';

class productionhall extends StatefulWidget {
  final bool status;
  final int index;
  const productionhall({super.key, required this.status, required this.index});
  @override
  State<productionhall> createState() => _productionState();
}

class _productionState extends State<productionhall> {
  final productionheader = [
    "رقم\nالاوردر",
    "اسم\nالمنتج",
    "الكميه",
    "اللون",
    "حالة\nالاوردر",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<productionhallcuibt>(context)
        .getproduction(status: widget.status);
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: [
          Container(
            height: 50,
            color: appcolors.maincolor.withOpacity(0.7),
            child: Row(
                children: productionheader
                    .map((e) => customheadertable(
                          title: e,
                          flex: e == "تحديد" ||
                                  e == "حذف" ||
                                  e == "اللون" ||
                                  e == "حالة\nالاوردر"
                              ? 2
                              : 3,
                        ))
                    .toList()),
          ),
          Expanded(
              child: BlocConsumer<productionhallcuibt, productionhalltates>(
                  listener: (context, state) {
            if (state is getproductionhalltatefailure)
              showtoast(
                                                                                                  context: context,

                  message: state.error_message, toaststate: Toaststate.error);
          }, builder: (context, state) {
            if (state is getproductionhalltateloading) return loadingshimmer();
            if (state is getproductionhalltatefailure)
              return SizedBox();
            else {
              if (BlocProvider.of<productionhallcuibt>(context)
                  .myproduction
                  .isEmpty)
                return nodata();
              else {
                return ListView.separated(
                    itemBuilder: (context, i) => InkWell(
                          onLongPress: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
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
                                    content: Componentsdialog(
                                      prodname:
                                          BlocProvider.of<productionhallcuibt>(
                                                  context)
                                              .myproduction[i]
                                              .name,
                                      qty: int.parse(
                                          BlocProvider.of<productionhallcuibt>(
                                                  context)
                                              .myproduction[i]
                                              .quantity),
                                    ),
                                  );
                                });
                          },
                          onTap: () {
                            navigateto(
                                context: context,
                                page: productionusage(
                                    production:
                                        BlocProvider.of<productionhallcuibt>(
                                                context)
                                            .myproduction[i]));
                          },
                          child: customtableproductionshallitem(
                              status:
                                  BlocProvider.of<productionhallcuibt>(context)
                                      .myproduction[i]
                                      .status,
                              line:
                                  BlocProvider.of<productionhallcuibt>(context)
                                      .myproduction[i]
                                      .line,
                              ordernumber:
                                  BlocProvider.of<productionhallcuibt>(context)
                                      .myproduction[i]
                                      .ordernumber,
                              name:
                                  "${BlocProvider.of<productionhallcuibt>(context).myproduction[i].name}",
                              quantaity:
                                  BlocProvider.of<productionhallcuibt>(context)
                                      .myproduction[i]
                                      .quantity,
                              delet: IconButton(
                                  onPressed: () {
                                    if (!permession
                                        .contains('حذف اوردرات التجميع')) {
                                      showdialogerror(
                                          error: "ليس لديك الصلاحيه",
                                          context: context);
                                    } else
                                      awsomdialogerror(
                                          context: context,
                                          mywidget: BlocConsumer<
                                              productionhallcuibt,
                                              productionhalltates>(
                                            listener: (context, state) {
                                              if (state
                                                  is deleteproductionhalltatesuccess) {
                                                Navigator.pop(context);

                                                showtoast(
                                                                                                                                    context: context,

                                                    message:
                                                        state.success_message,
                                                    toaststate:
                                                        Toaststate.succes);
                                              }
                                              if (state
                                                  is deleteproductionhalltatefailure) {
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
                                                  is deleteproductionhalltateloadind)
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
                                                                  productionhallcuibt>(
                                                              context)
                                                          .deleteproduction(
                                                              prduction: BlocProvider
                                                                      .of<productionhallcuibt>(
                                                                          context)
                                                                  .myproduction[i]);
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
                                              "هل تريد حذف الاوردر رقم ${BlocProvider.of<productionhallcuibt>(context).myproduction[i].ordernumber}");
                                  },
                                  icon: Icon(
                                    deleteicon,
                                    color: Colors.red,
                                  ))),
                        ),
                    separatorBuilder: (context, i) => Divider(
                          color: Colors.grey,
                        ),
                    itemCount: BlocProvider.of<productionhallcuibt>(context)
                        .myproduction
                        .length);
              }
            }
          })),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.index == 0)
                InkWell(
                    onTap: () async {
                      if (!permession.contains('اضافة اوردرات التجميع')) {
                        showdialogerror(
                            error: "ليس لديك الصلاحيه", context: context);
                      } else {
                        await BlocProvider.of<productionhallcuibt>(context)
                            .linechange("اختر الخط");
                        await BlocProvider.of<componentCubit>(context)
                            .prodchange("اختر المنتج");

                        navigateto(context: context, page: addhallreport());
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
          ),
          SizedBox(
            height: 5,
          )
        ]));
  }
}
