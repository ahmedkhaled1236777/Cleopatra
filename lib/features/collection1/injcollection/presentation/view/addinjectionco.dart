import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/time.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/viewmodel/cubit/injextionco_dart_cubit.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';

//hhhhhhh
//hhhhhh
class addinjectionco extends StatefulWidget {
  String hhh = "kk";
  @override
  State<addinjectionco> createState() => _addinjectioncoState();
}

class _addinjectioncoState extends State<addinjectionco> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController productionquantity = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

  String? x;
  getdata() async {
    BlocProvider.of<WorkerCubit>(context).resetworkername();
    BlocProvider.of<productionhallcuibt>(context).resetordernumber();

    if (BlocProvider.of<WorkerCubit>(context).workers.isEmpty)
      await BlocProvider.of<WorkerCubit>(context).getworkers();
    await BlocProvider.of<productionhallcuibt>(context)
        .getproduction(status: false);
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body:Center(
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
                        date: BlocProvider.of<DateCubit>(context).date1,
                        onPressed: () {
                          BlocProvider.of<DateCubit>(context)
                              .changedate(context);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Color(0xff535C91),
                    child: Center(
                      child: BlocBuilder<WorkerCubit, WorkerState>(
                        builder: (context, state) {
                          return DropdownSearch<String>(
                            dropdownButtonProps:
                                DropdownButtonProps(color: Colors.white),
                            popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps()),
                            selectedItem: BlocProvider.of<WorkerCubit>(context)
                                .workername,
                            items:
                                BlocProvider.of<WorkerCubit>(context).myworkers,
                            onChanged: (value) {
                              BlocProvider.of<WorkerCubit>(context)
                                  .workerchange(value!);
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                textAlign: TextAlign.center,
                                dropdownSearchDecoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Color(0xff535C91),
                    child: Center(
                      child:
                          BlocBuilder<productionhallcuibt, productionhalltates>(
                        builder: (context, state) {
                          return DropdownSearch<String>(
                            dropdownButtonProps:
                                DropdownButtonProps(color: Colors.white),
                            popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps()),
                            selectedItem:
                                BlocProvider.of<productionhallcuibt>(context)
                                    .ordername,
                            items: BlocProvider.of<productionhallcuibt>(context)
                                .orders,
                            onChanged: (value) {
                              BlocProvider.of<productionhallcuibt>(context)
                                  .orderchange(value!);
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                textAlign: TextAlign.center,
                                dropdownSearchDecoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
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
                      child: BlocBuilder<AverageCubit, AverageState>(
                        builder: (context, state) {
                          return DropdownSearch<String>(
                            dropdownButtonProps:
                                DropdownButtonProps(color: Colors.white),
                            popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps()),
                            selectedItem:
                                BlocProvider.of<AverageCubit>(context).jobname,
                            items: BlocProvider.of<AverageCubit>(context)
                                .myaverages,
                            onChanged: (value) {
                              BlocProvider.of<AverageCubit>(context)
                                  .averagechange(value!);
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                textAlign: TextAlign.center,
                                dropdownSearchDecoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff535C91)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "الوقت من",
                            style: TextStyle(
                                color: appcolors.maincolor,
                                fontFamily: "cairo"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Time(
                            inittime: DateTime.now(),
                            onChange: (date) {
                              BlocProvider.of<DateCubit>(context)
                                  .changetimefrom(date);
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "الوقت الي",
                            style: TextStyle(
                                color: appcolors.maincolor,
                                fontFamily: "cairo"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Time(
                            inittime: DateTime.now(),
                            onChange: (date) {
                              BlocProvider.of<DateCubit>(context)
                                  .changetimeto(date);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  custommytextform(
                    controller: productionquantity,
                    hintText: "كمية الانتاج",
                    val: "برجاء ادخال كمية الانتاج ",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  custommytextform(
                    controller: notes,
                    hintText: "الملاحظات",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<InjextioncoDartCubit, InjextioncoDartState>(
                      listener: (context, state) async {
                    if (state is addinjectioncosuccess) {
                      productionquantity.clear();
                      BlocProvider.of<AverageCubit>(context).resetaverage();

                      BlocProvider.of<DateCubit>(context).cleardates();
                      BlocProvider.of<WorkerCubit>(context).resetworkername();
                      showtoast(
                                                                            context: context,

                          message: state.successmessage,
                          toaststate: Toaststate.succes);
                    }
                    if (state is addinjectioncofailure)
                      showtoast(
                                                                            context: context,

                          message: state.errormessage,
                          toaststate: Toaststate.error);
                  }, builder: (context, state) {
                    if (state is addinjectioncoloading) return loading();
                    return custommaterialbutton(
                        button_name: "تسجيل التقرير",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (BlocProvider.of<productionhallcuibt>(context)
                                    .ordername ==
                                "اختر الاوردر") {
                              showdialogerror(
                                  error: "برجاء اختيار رقم الاوردر",
                                  context: context);
                            } else if (BlocProvider.of<WorkerCubit>(context)
                                    .workername ==
                                "اسم العامل") {
                              showdialogerror(
                                  error: "برجاء اختيار اسم العامل",
                                  context: context);
                            } else if (BlocProvider.of<DateCubit>(context)
                                    .timefrom ==
                                "الوقت من") {
                              showdialogerror(
                                  error: "برجاء اختيار بداية الوقت",
                                  context: context);
                            } else if (BlocProvider.of<DateCubit>(context)
                                    .timeto ==
                                "الوقت الي") {
                              showdialogerror(
                                  error: "برجاء اختيار نهاية الوقت",
                                  context: context);
                            } else if (BlocProvider.of<AverageCubit>(context)
                                    .jobname ==
                                "اختر الوظيفه") {
                              showdialogerror(
                                  error: "برجاء اختيار وظيفة العامل",
                                  context: context);
                            } else {
                              var format = DateFormat("HH:mm");
                              var start = format.parse(
                                  BlocProvider.of<DateCubit>(context).timefrom);
                              var end = format.parse(
                                  BlocProvider.of<DateCubit>(context).timeto);
                              Duration diff = end.difference(start).abs();
                              if (start.isAfter(end)||start.isAtSameMomentAs(end)) {
                                showdialogerror(
                                    error:
                                        "يجب ان تكون نهاية الوقت اكبر من بداية الوقت",
                                    context: context);
                              } 
                              
                              else
                                BlocProvider.of<InjextioncoDartCubit>(context)
                                    .adddatat(
                                        injec: injectioncomodel(
                                  status: "فردى",
                                  timefrom: BlocProvider.of<DateCubit>(context)
                                      .timefrom,
                                  timeto: BlocProvider.of<DateCubit>(context)
                                      .timeto,
                                  ordernumber:
                                      BlocProvider.of<productionhallcuibt>(
                                              context)
                                          .ordername,
                                  productionquantity:
                                      int.parse(productionquantity.text),
                                  notes: notes.text,
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
                                  docid:
                                      "${BlocProvider.of<DateCubit>(context).date1}-${DateTime.now().hour}-${DateTime.now().second}-${BlocProvider.of<WorkerCubit>(context).workername}",
                                  workername:
                                      BlocProvider.of<WorkerCubit>(context)
                                          .workername,
                                  job: BlocProvider.of<AverageCubit>(context)
                                      .jobname,
                                ));
                            }
                          }
                        });
                  })
                ]))))))));
  }
}
