import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/notification.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/time.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/orderradio.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/widgets/radiosreport.dart';

class Updatealert extends StatefulWidget {
  final TextEditingController quantity;
  final TextEditingController color;
  final TextEditingController machine;
  final String ordernumber;
  final TextEditingController purepercentaege;
  final TextEditingController breakpercentage;
  final TextEditingController masterpersentage;
  final TextEditingController notes;
  final DateTime inittimefrom;
  final DateTime inittimeto;
  const Updatealert(
      {super.key,
      required this.quantity,
      required this.breakpercentage,
      required this.purepercentaege,
      required this.masterpersentage,
      required this.inittimefrom,
      required this.inittimeto,
      required this.notes,
      required this.color,
      required this.ordernumber,
      required this.machine});
  @override
  State<Updatealert> createState() => _UpdatealertState();
}

class _UpdatealertState extends State<Updatealert> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:Center(
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "نهاية الاوردر",
                        style: TextStyle(
                            fontFamily: "cairo", color: appcolors.maincolor),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<productionusagecuibt, productionusagetates>(
                        builder: (context, state) {
                          return radiosreport(
                              firstradio: "نعم",
                              secondradio: "لا",
                              firstradiotitle: "نعم",
                              secondradiotitle: "لا");
                        },
                      ),
                      SizedBox(height: 10,),
                      BlocBuilder<injectionhallcuibt, injectionhalltates>(
                builder: (context, state) {
                  return Orderradio(
                      firstradio: "بمصب",
                      secondradio: "بدون",
                      firstradiotitle: "بمصب",
                      secondradiotitle: "بدون");
                },
              ),
                      SizedBox(
                        height: 10,
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
                          child: BlocBuilder<MoldsCubit, MoldsState>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<MoldsCubit>(context)
                                        .moldname,
                                items: cashhelper.getdata(key: "mymolds")==null ? []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                                onChanged: (value) {
                                  BlocProvider.of<MoldsCubit>(context)
                                      .moldchange(value!);
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Color(0xff535C91),
                        child: Center(
                          child: BlocBuilder<MoldsCubit, MoldsState>(
                            builder: (context, state) {
                              return DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<MoldsCubit>(context)
                                        .materialtype,
                                items: BlocProvider.of<MoldsCubit>(context)
                                    .materiales,
                                onChanged: (value) {
                                  BlocProvider.of<MoldsCubit>(context)
                                      .materialchange(value!);
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 70,
                              child: custommytextform(
                                keyboardType: TextInputType.number,
                                controller: widget.purepercentaege,
                                hintText: "نسبة البيور",
                                val: "برجاء ادخال نسبة البيور",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 70,
                              child: custommytextform(
                                keyboardType: TextInputType.number,
                                controller: widget.breakpercentage,
                                hintText: "نسبة الكسر",
                                val: "برجاء ادخال نسبة الكسر",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 70,
                              child: custommytextform(
                                keyboardType: TextInputType.number,
                                controller: widget.masterpersentage,
                                hintText: "نسبة الماستر",
                                val: "برجاء ادخال نسبة الماستر",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.color,
                        hintText: "اللون",
                        val: "برجاء ادخال رقم اللون",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        keyboardType: TextInputType.number,
                        controller: widget.machine,
                        hintText: "رقم الماكينه",
                        val: "برجاء ادخال رقم الماكينه",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.quantity,
                        hintText: "الكميه المطلوبه",
                        val: "برجاء ادخال الكمية المطلوبه",
                        keyboardType: TextInputType.number,
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
                                "وقت بداية الاوردر",
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Time(
                                inittime: widget.inittimefrom,
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
                                "وقت نهاية الاوردر",
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Time(
                                inittime: widget.inittimeto,
                                onChange: (date) {
                                  BlocProvider.of<DateCubit>(context)
                                      .changetimeto(date);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.notes,
                        hintText: "الملاحظات",
                        val: "برجاء ادخال الملاحظات",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<injectionhallcuibt, injectionhalltates>(
                        listener: (context, state) async {
                          if (state is updateordersuccess) {
                            if (BlocProvider.of<productionusagecuibt>(context)
                                    .type ==
                                "نعم") {
                              sendnotification(
                                  data:
                                      "تم انتهاء اوردر رقم ${widget.ordernumber} ${BlocProvider.of<MoldsCubit>(context).moldname} ${widget.color.text} بكم برجاء مراجعه المخزن في التسليمات وكميه الخامه المستلمه");
                            }
                            Navigator.pop(context);
                            widget.quantity.clear();

                            BlocProvider.of<DateCubit>(context).cleardates();
                            BlocProvider.of<productionusagecuibt>(context)
                                .resest();
                            await BlocProvider.of<injectionhallcuibt>(context)
                                .getinjection(status: false);
                            await BlocProvider.of<MoldsCubit>(context)
                                .resetmold();

                            showtoast(
                                                                                                                context: context,

                                message: state.successmessage,
                                toaststate: Toaststate.succes);
                          }
                          if (state is updateorderfailure)
                            showdialogerror(
                                error: state.errormessage, context: context);
                        },
                        builder: (context, state) {
                          if (state is updateorderloading) return loading();
                          return custommaterialbutton(
                              button_name: "تعديل الاوردر",
                              onPressed: () async {
                                if (BlocProvider.of<MoldsCubit>(context)
                                        .moldname ==
                                    "اختر الاسطمبه") {
                                  showdialogerror(
                                      error: "يجب اختيار الاسطمبه",
                                      context: context);
                                } else {
                                  if (formkey.currentState!.validate()) {
                                    if (BlocProvider.of<DateCubit>(context)
                                            .timefrom ==
                                        "الوقت من") {
                                      showdialogerror(
                                          error: "برجاء اختيار بداية الوقت",
                                          context: context);
                                    } else if (BlocProvider.of<DateCubit>(
                                                context)
                                            .timeto ==
                                        "الوقت الي") {
                                      showdialogerror(
                                          error: "برجاء اختيار نهاية الوقت",
                                          context: context);
                                    } else
                                      BlocProvider.of<injectionhallcuibt>(
                                              context)
                                          .updateorder(
                                              injectionmodel:
                                                  injectionhallmodel(
                                      sprue: BlocProvider.of<injectionhallcuibt>(context).type=="بمصب"?true:false,

                                        pureper: widget.purepercentaege.text,
                                        breakper: widget.breakpercentage.text,
                                        masterper: widget.masterpersentage.text,
                                        materialtype:
                                            BlocProvider.of<MoldsCubit>(context)
                                                .materialtype,
                                        timeend:
                                            BlocProvider.of<DateCubit>(context)
                                                .timeto,
                                        timestart:
                                            BlocProvider.of<DateCubit>(context)
                                                .timefrom,
                                        update: false,
                                        notes: widget.notes.text,
                                        status:
                                            BlocProvider.of<productionusagecuibt>(
                                                            context)
                                                        .type ==
                                                    "لا"
                                                ? false
                                                : true,
                                        ordernumber: widget.ordernumber,
                                        color: widget.color.text,
                                        machine: widget.machine.text,
                                        date:
                                            BlocProvider.of<DateCubit>(context)
                                                .producthalldate,
                                        name:
                                            BlocProvider.of<MoldsCubit>(context)
                                                .moldname,
                                        quantity: widget.quantity.text,
                                      ));
                                    /*  for (var i = 0; i < BlocProvider.of<componentCubit>(context).components.length; i++) {
                                 if(BlocProvider.of<componentCubit>(context).prodname==BlocProvider.of<componentCubit>(context).components[i].name){
                                  if(int.parse(quantity.text)>BlocProvider.of<componentCubit>(context).components[i].quantity){
                                    showdialogerror(error: "هذه الكميه ليست متوفره بالمخزن", context: context);
                                  }
                                  else{
BlocProvider.of<injectionhallcuibt>(context)
                                      .addinjection(injectionmodel: injectionhallmodel(date: BlocProvider.of<DateCubit>(context).producthalldate,
                                       ordernumber: ordernumber.text, name: BlocProvider.of<componentCubit>(context).prodname, quantity: quantity.text, line: BlocProvider.of<injectionhallcuibt>(context).linename)
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
                    ]))))))));
  }
}
