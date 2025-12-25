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

import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintstate.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';

class addpaintorder extends StatefulWidget {
  @override
  State<addpaintorder> createState() => _addaddpaintorderState();
}

class _addaddpaintorderState extends State<addpaintorder> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController ordernumber = TextEditingController();
  TextEditingController prodcode = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController boyacode = TextEditingController();
  TextEditingController warnishcode = TextEditingController();
  TextEditingController machine = TextEditingController();
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
                "اضافة اوردر",
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
                            date: BlocProvider.of<DateCubit>(context)
                                .producthalldate,
                            onPressed: () {
                              BlocProvider.of<DateCubit>(context)
                                  .changedatehall(context);
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
                      SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: prodcode,
                        hintText: "كود الصنف",
                        val: "برجاء ادخال كود الصنف",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: boyacode,
                        hintText: "كود البويه",
                        val: "برجاء ادخال كود البويه",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: warnishcode,
                        hintText: "كود الورنيش",
                        val: "برجاء ادخال كود الورنيش",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: ordernumber,
                        hintText: "رقم الاوردر",
                        val: "برجاء ادخال رقم الاوردر",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: quantity,
                        hintText: "الكميه المطلوبه",
                        val: "برجاء ادخال الكمية المطلوبه",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: notes,
                        hintText: "الملاحظات",
                        val: "برجاء ادخال الملاحظات",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<paintcuibt, painttates>(
                        listener: (context, state) async {
                          if (state is painttatesuccess) {
                            ordernumber.clear();
                            quantity.clear();

                            BlocProvider.of<DateCubit>(context).cleardates();

                            await BlocProvider.of<paintcuibt>(context)
                                .getpaintorders();

                            showtoast(
                                                                                                                context: context,

                                message: state.success_message,
                                toaststate: Toaststate.succes);
                          }
                          if (state is painttatefailure)
                            showtoast(
                                                                                                                context: context,

                                message: state.error_message,
                                toaststate: Toaststate.error);
                        },
                        builder: (context, state) {
                          if (state is painttateloading) return loading();
                          return custommaterialbutton(
                              button_name: "تسجيل الاوردر",
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  if (BlocProvider.of<paintcuibt>(context)
                                      .orders
                                      .contains(ordernumber.text))
                                    showdialogerror(
                                        error: "هذا الاوردر مسجل لدينا من قبل",
                                        context: context);
                                  else
                                    BlocProvider.of<paintcuibt>(context)
                                        .addpaint(
                                            paint: Paintmodel(
                                      scrapquantity: 0,
                                      actualprod: 0,
                                      prodcode: prodcode.text,
                                      boyacode: boyacode.text,
                                      warnishcode: warnishcode.text,
                                      notes: notes.text,
                                      status: false,
                                      date: BlocProvider.of<DateCubit>(context)
                                          .producthalldate,
                                      ordernumber: ordernumber.text,
                                      name: BlocProvider.of<paintaverageCubit>(
                                              context)
                                          .jobname,
                                      quantity: quantity.text,
                                    ));
                                  /*  for (var i = 0; i < BlocProvider.of<componentCubit>(context).components.length; i++) {
                                 if(BlocProvider.of<componentCubit>(context).prodname==BlocProvider.of<componentCubit>(context).components[i].name){
                                  if(int.parse(quantity.text)>BlocProvider.of<componentCubit>(context).components[i].quantity){
                                    showdialogerror(error: "هذه الكميه ليست متوفره بالمخزن", context: context);
                                  }
                                  else{
BlocProvider.of<painthallcuibt>(context)
                                      .addpaint(paintmodel: painthallmodel(date: BlocProvider.of<DateCubit>(context).producthalldate,
                                       ordernumber: ordernumber.text, name: BlocProvider.of<componentCubit>(context).prodname, quantity: quantity.text, line: BlocProvider.of<painthallcuibt>(context).linename)
                                        );
                                  }
                                 }
                               }*/
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
