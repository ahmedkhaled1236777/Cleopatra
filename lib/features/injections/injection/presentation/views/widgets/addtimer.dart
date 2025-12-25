import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/injections/injection/data/models/timermodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';

class Addtimer extends StatelessWidget {
  TextEditingController secondsperpiece = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController sprueweight = TextEditingController();
  TextEditingController numberofpieces = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
          "اضافة اسطمبه",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
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
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
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
                          BlocProvider.of<MoldsCubit>(context).moldname,
                      items: cashhelper.getdata(key: "mymolds")==null ? []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                      onChanged: (value) {
                        BlocProvider.of<MoldsCubit>(context)
                            .moldchange(value!);
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
                          BlocProvider.of<MoldsCubit>(context).materialtype,
                      items:
                          BlocProvider.of<MoldsCubit>(context).materiales,
                      onChanged: (value) {
                        BlocProvider.of<MoldsCubit>(context)
                            .materialchange(value!);
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
                                    custommytextform(
                                      controller: numberofpieces,
                                      hintText: "عدد القطع",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    custommytextform(
                                      controller: secondsperpiece,
                                      hintText: "عدد الثواني",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    custommytextform(
                                      controller: weight,
                                      hintText: "(جرام) وزن القطعه ",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    custommytextform(
                                      controller: sprueweight,
                                      hintText: "(جرام) وزن المصب ",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    BlocConsumer<productioncuibt, productiontates>(
                                      listener: (context, state) {
                                        if (state is AddTimerFailure)
                                          showtoast(
                                                                                                      context: context,
                    
                      message: state.failuremessage,
                      toaststate: Toaststate.error);
                                        if (state is AddTimerSucess) {
                                          weight.clear();
                                          secondsperpiece.clear();
                                          BlocProvider.of<MoldsCubit>(context).resetmold();
                                          BlocProvider.of<productioncuibt>(context).gettimers();
                                          showtoast(
                                                                                                      context: context,
                    
                      message: state.successmessage,
                      toaststate: Toaststate.succes);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is AddTimerLoading) return loading();
                    
                                        return custommaterialbutton(
                                          button_name: "تسجيل",
                                          onPressed: () {
                    if (BlocProvider.of<MoldsCubit>(context).moldname ==
                        "اختر الاسطمبه") {
                      showdialogerror(
                          error: "برجاء اختيار اسم الاسطمبه",
                          context: context);
                    } else if (BlocProvider.of<MoldsCubit>(context)
                            .materialtype ==
                        "نوع الخامه") {
                      showdialogerror(
                          error: "برجاء اختيار نوع الخامه",
                          context: context);
                    } else {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<productioncuibt>(context).addtimer(
                            timer: timermodel(
                              sprueweight:double.parse(sprueweight.text),
                                materialtype:
                                    BlocProvider.of<MoldsCubit>(context)
                                        .materialtype,
                                numberofpieces: numberofpieces.text,
                                moldname:
                                    BlocProvider.of<MoldsCubit>(context)
                                        .moldname,
                                secondsperpiece:
                                    double.parse(secondsperpiece.text),
                                weight: weight.text,
                                id: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}"));
                      }
                    }
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
          )))));
  }
}
