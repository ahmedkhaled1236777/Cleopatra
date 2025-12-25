import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';

import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/model/injectionmachinemodel.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_cubit.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_state.dart';



class Addinjectionmachine extends StatelessWidget {
  TextEditingController machinename = TextEditingController();
  TextEditingController machinenumber = TextEditingController();
    TextEditingController cost = TextEditingController();
    TextEditingController machinedeprecation = TextEditingController();
  TextEditingController costelectrichour = TextEditingController();
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
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
          "اضافة ماكينه",
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
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
               
                
               
              
              
                custommytextform(
                  controller: machinename,
                  hintText: "اسم الماكينه ",
                  val: "برجاء ادخال اسم الماكينه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  keyboardType: TextInputType.number,
                  controller: machinenumber,
                  hintText: "رقم الماكينه",
                                  val: "برجاء ادخال رقم الماكينه",
            
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: cost,
                  hintText: "تكلفة الماكينه",
                  val: "برجاء ادخال تكلفة الماكينه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: costelectrichour,
                  hintText: "تكلفة ساعه الكهرباء",
                  val: "برجاء ادخال تكلفة ساعه الكهرباء",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: machinedeprecation,
                  hintText: "عدد سنوات اهلاك الماكينه",
                  val: "برجاء ادخال عدد سنوات اهلاك الماكينه",
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<InjectionmachinesCubit, InjectionmachinesState>(
                  listener: (context, state) async {
                    if (state is addInjectionmachinesuccess) {
                      machinename.clear();
                      machinenumber.clear();
                      cost.clear();
                      costelectrichour.clear();
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            
                      await BlocProvider.of<InjectionmachinesCubit>(context).getinjectionmachines();
                    }
                    if (state is addInjectionmachinefailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is addInjectionmachineloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionmachinesCubit>(context).addinjectionmachine(
                              injectionmachine: Injectionmachinemodel(
                                machinenumber:int.parse(machinenumber.text) ,
                                 machinecost :double.parse(cost.text),
                                 machinedeprecation :double.parse(machinedeprecation.text),
                                 machinename: machinename.text,
                                 machinehourelectriccost: double.parse(costelectrichour.text),
                                 ));
                       } },
                    );
                  },
                ),SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
