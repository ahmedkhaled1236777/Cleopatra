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
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodstates.dart';

class addhallreport extends StatefulWidget {
  final String ordernumber;

  const addhallreport({super.key, required this.ordernumber});
  @override
  State<addhallreport> createState() => _addreportState();
}

class _addreportState extends State<addhallreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController color = TextEditingController();
  TextEditingController code = TextEditingController();

  TextEditingController quantity = TextEditingController();

  getdate() async {
    if (BlocProvider.of<componentCubit>(context).firstime == false) {
      BlocProvider.of<componentCubit>(context).getcomponents();
      BlocProvider.of<componentCubit>(context).firstime == true;
    }
  }

  @override
  void initState() {
    getdate();
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
                          child: BlocBuilder<productionhallcuibt,
                              productionhalltates>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<productionhallcuibt>(
                                            context)
                                        .linename,
                                items: BlocProvider.of<productionhallcuibt>(
                                        context)
                                    .lines,
                                onChanged: (value) {
                                  BlocProvider.of<productionhallcuibt>(context)
                                      .linechange(value!);
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
                          child: BlocBuilder<componentCubit, componentState>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<componentCubit>(context)
                                        .prodname,
                                items: BlocProvider.of<componentCubit>(context)
                                    .compenantsnames,
                                onChanged: (value) {
                                  BlocProvider.of<componentCubit>(context)
                                      .prodchange(value!);
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
                        controller: color,
                        hintText: "اللون",
                        val: "برجاء ادخال اللون",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: widget.ordernumber),
                        hintText: "رقم الاوردر",
                        val: "برجاء ادخال رقم الاوردر",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: code,
                        hintText: "كود المنتج",
                        val: "برجاء ادخال كود المنتج",
                      ),
                      const SizedBox(
                        height: 10,
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
                        height: 20,
                      ),
                      BlocConsumer<productionhallcuibt, productionhalltates>(
                        listener: (context, state) async {
                          if (state is productionhalltatesuccess) {
                            quantity.clear();
                            color.clear();
                            code.clear();

                            BlocProvider.of<DateCubit>(context).cleardates();

                            await BlocProvider.of<componentCubit>(context)
                                .prodchange("اختر المنتج");
                            await BlocProvider.of<productionhallcuibt>(context)
                                .getproduction(status: false);

                            showtoast(
                                                                                  context: context,

                                message: state.success_message,
                                toaststate: Toaststate.succes);
                          }
                          if (state is productionhalltatefailure)
                            showtoast(
                              
                                                                                  context: context,

                                message: state.error_message,
                                toaststate: Toaststate.error);
                        },
                        builder: (context, state) {
                          if (state is productionhalltateloading)
                            return loading();
                          return custommaterialbutton(
                              button_name: "تسجيل الاوردر",
                              onPressed: () async {
                                if (BlocProvider.of<componentCubit>(context)
                                        .prodname ==
                                    "اختر المنتج") {
                                  showdialogerror(
                                      error: "يجب اختيار المنتج",
                                      context: context);
                                } 
                                else {
                                  if (formkey.currentState!.validate()) {
                                    BlocProvider.of<productionhallcuibt>(
                                            context)
                                        .addproduction(
                                            productionmodel:
                                                productionhallmodel(
                                                    status: false,
                                                    code: code.text,
                                                    date: BlocProvider.of<
                                                            DateCubit>(context)
                                                        .producthalldate,
                                                    ordernumber:
                                                       widget. ordernumber,
                                                    name: BlocProvider.of<
                                                                componentCubit>(
                                                            context)
                                                        .prodname,
                                                    quantity: quantity.text,
                                                    line: color.text));
                                    /*  for (var i = 0; i < BlocProvider.of<componentCubit>(context).components.length; i++) {
                                 if(BlocProvider.of<componentCubit>(context).prodname==BlocProvider.of<componentCubit>(context).components[i].name){
                                  if(int.parse(quantity.text)>BlocProvider.of<componentCubit>(context).components[i].quantity){
                                    showdialogerror(error: "هذه الكميه ليست متوفره بالمخزن", context: context);
                                  }
                                  else{
BlocProvider.of<productionhallcuibt>(context)
                                      .addproduction(productionmodel: productionhallmodel(date: BlocProvider.of<DateCubit>(context).producthalldate,
                                       ordernumber: ordernumber.text, name: BlocProvider.of<componentCubit>(context).prodname, quantity: quantity.text, line: BlocProvider.of<productionhallcuibt>(context).linename)
                                        );
                                  }
                                 }
                               }*/
                                  }
                                }
                              });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ])))))))));
  }
}
