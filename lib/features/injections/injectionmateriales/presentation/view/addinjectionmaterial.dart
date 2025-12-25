import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';

import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/model/injectionmaterialmodel.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_cubit.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_state.dart';



class Addinjectionmaterial extends StatelessWidget {
  TextEditingController materialname = TextEditingController();
  TextEditingController purematerialcost = TextEditingController();
    TextEditingController breakmaterialcost = TextEditingController();
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
                  controller: materialname,
                  hintText: "اسم الخامه ",
                  val: "برجاء ادخال اسم الخامه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: purematerialcost,
                  hintText: "تكلفة طن البيور",
                  val: "برجاء ادخال تكلفة ",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: breakmaterialcost,
                  hintText: "تكلفة طن الكسر",
                  val: "برجاء ادخال تكلفة ",
                ),

              
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<InjectionmaterialsCubit, InjectionmaterialsState>(
                  listener: (context, state) async {
                    if (state is addInjectionmaterialsuccess) {
                      materialname.clear();
                      purematerialcost.clear();
                      breakmaterialcost.clear();
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            
                      await BlocProvider.of<InjectionmaterialsCubit>(context).getinjectionmaterials();
                    }
                    if (state is addInjectionmaterialfailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is addInjectionmaterialloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionmaterialsCubit>(context).addinjectionmaterial(
                              injectionmaterial: Injectionmaterialmodel(
                                 purematerialcost :double.parse(purematerialcost.text),
                                 materialname: materialname.text,
                                 breakmaterialcost: double.parse(breakmaterialcost.text),
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
