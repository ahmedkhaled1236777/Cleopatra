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
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molduse/molds/data/repos/moldrepoimp.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/diagnoses.dart';

class addreport extends StatefulWidget {
  @override
  State<addreport> createState() => _addreportState();
}

class _addreportState extends State<addreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController workername = TextEditingController();

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

  getdata() async {
    try {
      BlocProvider.of<productioncuibt>(context).pageloading = 0;
      await BlocProvider.of<injectionhallcuibt>(context)
          .getinjection(status: false);
      await BlocProvider.of<productioncuibt>(context).gettimers();
      if (BlocProvider.of<productioncuibt>(context).diagnoses.isEmpty)
        await BlocProvider.of<productioncuibt>(context).getdiagnoses();
      BlocProvider.of<productioncuibt>(context).pageloading = 1;
      if (this.mounted) {
        setState(() {});
      }
    } catch (e) {
      BlocProvider.of<productioncuibt>(context).pageloading = 2;
      showtoast(
                                                                                          context: context,

        message: e.toString(), toaststate: Toaststate.error);
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    if (BlocProvider.of<productioncuibt>(context).pageloading != 1) getdata();
  }

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
            body: BlocProvider.of<productioncuibt>(context).pageloading == 0
                ? loading()
                : BlocProvider.of<productioncuibt>(context).pageloading == 1
                    ?Center(
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600
                                  ? 0
                                  : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12, right: 9),
                          child: Form(
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
                                date: BlocProvider.of<DateCubit>(context)
                                    .date1,
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
                              child: BlocBuilder<injectionhallcuibt,
                                  injectionhalltates>(
                                builder: (context, state) {
                                  return DropdownSearch<String>(
                                    dropdownButtonProps:
                                        DropdownButtonProps(
                                            color: Colors.white),
                                    popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps()),
                                    selectedItem:
                                        BlocProvider.of<injectionhallcuibt>(
                                                context)
                                            .ordername,
                                    items:
                                        BlocProvider.of<injectionhallcuibt>(
                                                context)
                                            .orders,
                                    onChanged: (value) {
                                      BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .orderchange(value!);
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                            baseStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "cairo"),
                                            textAlign: TextAlign.center,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              enabled: true,
                                              enabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xff535C91)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xff535C91)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10),
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
                          custommytextform(
                            controller: workername,
                            hintText: "اسم العامل",
                            val: "برجاء ادخال اسم العامل",
                          ),
                          SizedBox(height: 10),
                          const SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                            keyboardType: TextInputType.number,
                            controller: shift,
                            hintText: "رقم الورديه",
                            val: "برجاء ادخال رقم الورديه",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                              controller: workhours,
                              hintText: "عدد ساعات التشغيل",
                              val: "برجاء ادخال عدد ساعات التشغيل",
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                              controller: counterstart,
                              hintText: "بداية العداد",
                              val: "برجاء ادخال بداية العداد",
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                              controller: counterend,
                              hintText: "نهاية العداد",
                              val: "برجاء ادخال نهاية العداد",
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                              onChanged: (val) {
                                if (val.isEmpty) {
                                  expectedprod.clear();
                                  scrapcountity.clear();
                                  proddivision.clear();
                                  machinestop.clear();
                                } else {
                                  expectedprod
                                      .text = ((double.parse(workhours.text) *
                                              60 *
                                              60 *
                                              double.parse(BlocProvider.of<
                                                              productioncuibt>(
                                                          context)
                                                      .timerrate["${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                  ["numberofpieces"])) /
                                          BlocProvider.of<productioncuibt>(
                                                          context)
                                                      .timerrate[
                                                  "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                              ["cycletime"])
                                      .round()
                                      .toString();
                                  scrapcountity.text = (((double.parse(
                                                      counterend.text) -
                                                  double.parse(
                                                      counterstart.text)) *
                                              double.parse(BlocProvider.of<
                                                                  productioncuibt>(
                                                              context)
                                                          .timerrate[
                                                      "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                  ["numberofpieces"])) -
                                          double.parse(val))
                                      .round()
                                      .toString();
                                  proddivision.text = (double.parse(
                                              expectedprod.text) -
                                          ((double.parse(counterend.text) -
                                                  double.parse(
                                                      counterstart.text)) *
                                              double.parse(BlocProvider.of<
                                                                  productioncuibt>(
                                                              context)
                                                          .timerrate[
                                                      "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                  ["numberofpieces"])))
                                      .round()
                                      .toString();
                                  machinestop.text = ((double.parse(
                                                  proddivision.text) *
                                              BlocProvider.of<productioncuibt>(context)
                                                          .timerrate[
                                                      "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                  ["cycletime"]) /
                                          (60 *
                                              double.parse(
                                                  BlocProvider.of<productioncuibt>(
                                                                  context)
                                                              .timerrate[
                                                          "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                      ["numberofpieces"])))
                                      .round()
                                      .toString();
                                }
                                setState(() {});
                              },
                              controller: realprodcountity,
                              hintText: "كمية الانتاج الفعلي",
                              val: "برجاء كمية الانتاج الفعلي",
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xff2BA4C8), width: 0.5)),
                            child: Diagnoses(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                              controller: notes, hintText: "الملاحظات"),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<productioncuibt, productiontates>(
                            listener: (context, state) async {
                              if (state is productiontatesuccess) {
                                await moldusagerepoimp().editmoldusage(
                                    moldmodel: moldusagemodel(
                                        numberofuses:
                                            (int.parse(counterend.text))
                                                .round(),
                                        moldname:
                                            BlocProvider.of<MoldsCubit>(
                                                    context)
                                                .moldname));
                                workername.clear();
                                workhours.clear();
                                proddivision.clear();
                                BlocProvider.of<injectionhallcuibt>(context)
                                    .resetordernumber();
                                expectedprod.clear();
                                counterend.clear();
                                counterstart.clear();
                                scrapcountity.clear();
                                shift.clear();
                                realprodcountity.clear();
                                machinestop.clear();
                                BlocProvider.of<DateCubit>(context)
                                    .cleardates();
                                BlocProvider.of<productioncuibt>(context)
                                    .resetselecteditems();
                    
                                showtoast(
                                                                                                                    context: context,
                    
                                    message: state.success_message,
                                    toaststate: Toaststate.succes);
                              }
                              if (state is productiontatefailure)
                                showtoast(
                                                                                                                    context: context,
                    
                                    message: state.error_message,
                                    toaststate: Toaststate.error);
                            },
                            builder: (context, state) {
                              if (state is productiontateloading)
                                return loading();
                              return custommaterialbutton(
                                  button_name: "تسجيل التقرير",
                                  onPressed: () async {
                                    if (BlocProvider.of<injectionhallcuibt>(
                                                context)
                                            .ordername ==
                                        "اختر الاوردر") {
                                      showdialogerror(
                                          error: "برجاء اختيار رقم الاوردر",
                                          context: context);
                                    } else if (formkey.currentState!
                                        .validate()) {
                                      if (int.parse(shift.text) > 2 ||
                                          int.parse(shift.text) < 1) {
                                        showdialogerror(
                                            error: "رقم الورديه غير صحيح",
                                            context: context);
                                      } else if (BlocProvider.of<
                                                      injectionhallcuibt>(
                                                  context)
                                              .ordername ==
                                          "اختر الاوردر") {
                                        showdialogerror(
                                            error:
                                                "برجاء اختيار رقم الاوردر",
                                            context: context);
                                      } else if (int.parse(realprodcountity.text) >
                                          ((int.parse(counterend.text) -
                                                  int.parse(
                                                      counterstart.text)) *
                                              int.parse(
                                                  BlocProvider.of<productioncuibt>(context)
                                                              .timerrate[
                                                          "${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                      ["numberofpieces"]))) {
                                        showdialogerror(
                                            error:
                                                "كمية الانتاج الفعلي غير صحيحه",
                                            context: context);
                                      } else {
                                        BlocProvider.of<productioncuibt>(context).addproduction(
                                            productionmodel: productionmodel(
                                                diagnoses: BlocProvider.of<productioncuibt>(context)
                                                    .selecteditems,
                                                date: BlocProvider.of<DateCubit>(context)
                                                    .date1,
                                                docid:
                                                    "${BlocProvider.of<DateCubit>(context).date1}-${DateTime.now().hour}-${DateTime.now().second}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["machine"]}",
                                                workername: workername.text,
                                                machinenumber: BlocProvider.of<injectionhallcuibt>(context)
                                                    .ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]
                                                        ["machine"]
                                                    .toString(),
                                                shift: shift.text,
                                                storequantity:
                                                    realprodcountity.text,
                                                prodname: BlocProvider.of<injectionhallcuibt>(context)
                                                        .ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]
                                                    ["mold"],
                                                cycletime: (BlocProvider.of<productioncuibt>(context).timerrate["${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                        ["cycletime"])
                                                    .toString(),
                                                numberofpieces:
                                                    BlocProvider.of<productioncuibt>(context)
                                                            .timerrate["${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["mold"]}-${BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["material"]}"]
                                                        ["numberofpieces"],
                                                workhours: workhours.text,
                                                counterstart: counterstart.text,
                                                color: BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["color"],
                                                counterend: counterend.text,
                                                ordernuber: BlocProvider.of<injectionhallcuibt>(context).ordermap[BlocProvider.of<injectionhallcuibt>(context).ordername]["ordernumber"].toString(),
                                                realprodcountity: realprodcountity.text,
                                                expectedprod: expectedprod.text,
                                                scrapcountity: scrapcountity.text,
                                                proddivision: proddivision.text,
                                                machinestop: machinestop.text,
                                                notes: notes.text));
                                      }
                                    }
                                  });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ])))))))
                                        : Center(child: Text("برجاء المحاوله مره اخري"))));
  }
}
