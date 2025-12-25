import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';

import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportcuibt.dart';
import 'package:cleopatra/features/paints/paint/presentation/viewmodel/paintreportstates.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintstate.dart';

class addpaintreport extends StatefulWidget {
  @override
  State<addpaintreport> createState() => _addpaintreportState();
}

class _addpaintreportState extends State<addpaintreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController numberofworkers = TextEditingController();

  TextEditingController actualprodquantity = TextEditingController();

  TextEditingController workhours = TextEditingController();
  TextEditingController boyaweightstart = TextEditingController();
  TextEditingController boyaweightend = TextEditingController();
  TextEditingController warnishstart = TextEditingController();
  TextEditingController warnishend = TextEditingController();

  TextEditingController scrapinjquantity = TextEditingController();

  TextEditingController numberofpiecesinskewer = TextEditingController();

  TextEditingController numberofskewerintray = TextEditingController();

  TextEditingController actualdiskes = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  String? x;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اضافة تقرير",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Form(
                key: formkey,
                child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 9),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      const SizedBox(
                        height: 50,
                      ),
                      BlocBuilder<DateCubit, DateState>(
                        builder: (context, state) {
                          return choosedate(
                            date: BlocProvider.of<DateCubit>(context).date1,
                            onPressed: () {
                              BlocProvider.of<DateCubit>(context)
                                  .changedate(context);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Color(0xff535C91),
                        child: Center(
                          child: BlocBuilder<paintcuibt, painttates>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<paintcuibt>(context)
                                        .ordername,
                                items:
                                    BlocProvider.of<paintcuibt>(context).orders,
                                onChanged: (value) {
                                  BlocProvider.of<paintcuibt>(context)
                                      .orderchange(value!);
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                    textAlign: TextAlign.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Color(0xff535C91),
                        child: Center(
                          child:
                              BlocBuilder<paintaverageCubit, paintaverageState>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<paintaverageCubit>(context)
                                        .jobname,
                                items:
                                    BlocProvider.of<paintaverageCubit>(context)
                                        .mypaintaverages,
                                onChanged: (value) {
                                  BlocProvider.of<paintaverageCubit>(context)
                                      .paintaveragechange(value!);
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                    textAlign: TextAlign.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: numberofworkers,
                        hintText: "عدد العمال",
                        val: "برجاء ادخال عدد العمال",
                      ),
                      SizedBox(height: 10),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: workhours,
                        hintText: "عدد ساعات التشغيل",
                        val: "برجاء ادخال عدد ساعات التشغيل",
                      ),
                      SizedBox(height: 10),
                      custommytextform(
                        controller: actualdiskes,
                        hintText: "عدد الاسطوانات",
                        val: "برجاء ادخال عدد الاسطوانات",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: numberofskewerintray,
                        hintText: "عدد الاسياخ في الصينيه",
                        val: "برجاء ادخال عدد الاسياخ في الصينيه",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: numberofpiecesinskewer,
                          hintText: "عدد القطع في السيخ",
                          val: "برجاء ادخال عدد القطع في السيخ",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: actualprodquantity,
                          hintText: "كمية الانتاج الفعلي",
                          val: "برجاء ادخال كمية الانتاج الفعلي",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: boyaweightstart,
                          hintText: "بداية وزن البويه",
                          val: "برجاء ادخال بداية وزن البويا المستخدمه",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: boyaweightend,
                          hintText: "نهاية وزن البويه",
                          val: "برجاء ادخال نهاية وزن البويا المستخدمه",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: warnishstart,
                          hintText: "بداية وزن الورنيس",
                          val: "برجاء ادخال بداية وزن الورنيش المستخد",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: warnishend,
                          hintText: "نهاية وزن الورنيش",
                          val: "برجاء ادخال نهاية وزن الورنيش المستخدم",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: scrapinjquantity,
                          hintText: "كمية هالك الحقن",
                          val: "برجاء ادخال كمية هالك الحقن",
                          keyboardType: TextInputType.number),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                          controller: notes, hintText: "الملاحظات"),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<paintreportcuibt, paintreportstates>(
                        listener: (context, state) async {
                          if (state is addpaintreportsuccess) {
                            workhours.clear();
                            workhours.clear();
                            scrapinjquantity.clear();
                            actualdiskes.clear();
                            BlocProvider.of<paintcuibt>(context)
                                .resetordernumber();
                            BlocProvider.of<paintaverageCubit>(context)
                                .resetpaintaverage();
                            actualprodquantity.clear();
                            numberofpiecesinskewer.clear();
                            boyaweightend.clear();
                            boyaweightstart.clear();
                            warnishend.clear();
                            warnishstart.clear();
                            numberofskewerintray.clear();
                            numberofworkers.clear();
                            await BlocProvider.of<paintreportcuibt>(context)
                                .getpaintreport(
                                    date:
                                        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');
                            BlocProvider.of<DateCubit>(context).cleardates();

                            showtoast(
                                                                                                                context: context,

                                message: state.successmessage,
                                toaststate: Toaststate.succes);
                          }
                          if (state is addpaintreportfailure)
                            showtoast(
                                                                                                                context: context,

                                message: state.errormessage,
                                toaststate: Toaststate.error);
                        },
                        builder: (context, state) {
                          if (state is addpaintreportloading) return loading();
                          return custommaterialbutton(
                              button_name: "تسجيل التقرير",
                              onPressed: () async {
                                if (BlocProvider.of<paintcuibt>(context)
                                        .ordername ==
                                    "اختر الاوردر") {
                                  showdialogerror(
                                      error: "برجاء اختيار رقم الاوردر",
                                      context: context);
                                } else if (BlocProvider.of<paintaverageCubit>(
                                            context)
                                        .jobname ==
                                    "اختر المنتج") {
                                  showdialogerror(
                                      error: "برجاء اختيار اسم المنتج ",
                                      context: context);
                                } else if (formkey.currentState!.validate()) {
                                  if (((int.parse(actualdiskes.text) * int.parse(numberofskewerintray.text) * int.parse(numberofpiecesinskewer.text)) -
                                          int.parse(actualprodquantity.text)) <
                                      0) {
                                    showdialogerror(
                                        error:
                                            "كمية الانتاج الفعلي غير منطقيه برجاء مراجعه عدد الاسطوانات والاسياخ مره اخري",
                                        context: context);
                                  } else if (int.parse(actualprodquantity.text) >
                                      int.parse(BlocProvider.of<paintcuibt>(context)
                                              .orderquantity[BlocProvider.of<paintcuibt>(context).ordername]
                                                  ["totalprod"]
                                              .toString()) -
                                          int.parse(BlocProvider.of<paintcuibt>(context)
                                              .orderquantity[BlocProvider.of<paintcuibt>(context).ordername]
                                                  ["actprod"]
                                              .toString())) {
                                    showdialogerror(
                                        error:
                                            "الكميه المنتجه اكبر من الكميه المتبقيه من الاوردر",
                                        context: context);
                                  } else if (num.parse(boyaweightstart.text) -
                                              num.parse(boyaweightend.text) <
                                          1 ||
                                      num.parse(warnishstart.text) -
                                              num.parse(warnishend.text) <
                                          1) {
                                    showdialogerror(
                                        error:
                                            "كميات البويه او الورنيش غير صحيحه",
                                        context: context);
                                  } else
                                    BlocProvider.of<paintreportcuibt>(context).addpaintreport(
                                        paintreportmodel: paintreportmodel(
                                            boyaweightstart:
                                                boyaweightstart.text,
                                            boyaweightend: boyaweightend.text,
                                            warnishweightend: warnishend.text,
                                            warnishweightstart:
                                                warnishstart.text,
                                            actualprodquantity: int.parse(
                                                actualprodquantity.text),
                                            scrapinjquantity:
                                                scrapinjquantity.text,
                                            scrappaintquantity: ((int.parse(
                                                        actualdiskes.text) *
                                                    int.parse(numberofskewerintray
                                                        .text) *
                                                    int.parse(
                                                        numberofpiecesinskewer
                                                            .text)) -
                                                int.parse(actualprodquantity.text)),
                                            date: BlocProvider.of<DateCubit>(context).date1,
                                            docid: "${BlocProvider.of<DateCubit>(context).date1}-${DateTime.now().hour}-${DateTime.now().second}",
                                            numberofworkers: numberofworkers.text,
                                            numberofpiecesinskewer: numberofpiecesinskewer.text,
                                            numberofskewerintray: numberofskewerintray.text,
                                            actualdiskes: actualdiskes.text,
                                            prodname: BlocProvider.of<paintaverageCubit>(context).jobname,
                                            workhours: workhours.text,
                                            ordernuber: BlocProvider.of<paintcuibt>(context).ordername,
                                            notes: notes.text));
                                }
                              });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ]))))));
  }
}
