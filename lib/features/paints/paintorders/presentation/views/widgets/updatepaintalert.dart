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
import 'package:cleopatra/features/paints/paintorders/data/models/paintmodel.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintstate.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintusagecuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/widgets/radiosreport.dart';

class Updatepaintalert extends StatefulWidget {
  final TextEditingController quantity;
  final TextEditingController prodname;
  final TextEditingController boyacode;
  final TextEditingController prodcode;
  final TextEditingController warnishcode;
  final TextEditingController ordernumber;
  final String scrapquantity;
  final String actualprod;
  final TextEditingController notes;
  const Updatepaintalert({
    super.key,
    required this.quantity,
    required this.prodcode,
    required this.prodname,
    required this.scrapquantity,
    required this.boyacode,
    required this.warnishcode,
    required this.actualprod,
    required this.notes,
    required this.ordernumber,
  });
  @override
  State<Updatepaintalert> createState() => _UpdatepaintalertState();
}

class _UpdatepaintalertState extends State<Updatepaintalert> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
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
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.ordernumber,
                        hintText: "رقم الاوردر",
                        val: "برجاء ادخال رقم الاوردر",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.prodcode,
                        hintText: "كود الصنف",
                        val: "برجاء ادخال كود الصنف",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.boyacode,
                        hintText: "كود البويه",
                        val: "برجاء ادخال كود البويه",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: widget.warnishcode,
                        hintText: "كود الورنيش",
                        val: "برجاء ادخال كود الورنيش",
                        keyboardType: TextInputType.number,
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
                      custommytextform(
                        controller: widget.notes,
                        hintText: "الملاحظات",
                        val: "برجاء ادخال الملاحظات",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<paintcuibt, painttates>(
                        listener: (context, state) async {
                          if (state is updateordersuccess) {
                            Navigator.pop(context);
                            widget.quantity.clear();

                            BlocProvider.of<DateCubit>(context).cleardates();
                            BlocProvider.of<paintusagecuibt>(context).resest();
                            await BlocProvider.of<paintcuibt>(context)
                                .getpaintorders();

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
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<paintcuibt>(context)
                                      .updateorder(
                                          paint: Paintmodel(
                                    prodcode: widget.prodcode.text,
                                    scrapquantity:
                                        int.parse(widget.scrapquantity),
                                    actualprod: int.parse(widget.actualprod),
                                    notes: widget.notes.text,
                                    status: BlocProvider.of<paintusagecuibt>(
                                                    context)
                                                .type ==
                                            "لا"
                                        ? false
                                        : true,
                                    warnishcode: widget.warnishcode.text,
                                    boyacode: widget.boyacode.text,
                                    ordernumber: widget.ordernumber.text,
                                    date: BlocProvider.of<DateCubit>(context)
                                        .producthalldate,
                                    name: widget.prodname.text,
                                    quantity: widget.quantity.text,
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
                    ])))));
  }
}
