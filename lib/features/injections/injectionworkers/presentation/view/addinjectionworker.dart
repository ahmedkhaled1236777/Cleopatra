import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';

import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/model/injectioworkermodel.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_cubit.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_state.dart';



class Addinjectionworker extends StatelessWidget {
  TextEditingController workername = TextEditingController();
  TextEditingController workernumber = TextEditingController();
    TextEditingController workhours = TextEditingController();
  TextEditingController workersalary = TextEditingController();
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
                  controller: workername,
                  hintText:  "اسم العامل",
                  val: "برجاء ادخال اسم العامل",
                ),
                SizedBox(
                  height: 10,
                ),
                   custommytextform(
                                                  keyboardType: TextInputType.number,

                  controller: workernumber,
                  hintText: "رقم الهاتف",
                  val: "برجاء ادخال رقم الهاتف ",
                ),
                SizedBox(
                  height: 10,
                ),
               
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: workhours,
                  hintText: "عدد ساعات العمل",
                  val: "برجاء ادخال عدد ساعات العمل",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                                    keyboardType: TextInputType.number,

                  controller: workersalary,
                  hintText: "الراتب",
                  val: "برجاء ادخال الراتب",
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<InjectionworkersCubit, InjectionworkersState>(
                  listener: (context, state) async {
                    if (state is addInjectionworkersuccess) {
                      workername.clear();
                      workernumber.clear();
                      workersalary.clear();
                      workhours.clear();
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            
                      await BlocProvider.of<InjectionworkersCubit>(context).getinjectionworkers();
                    }
                    if (state is addInjectionworkerfailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is addInjectionworkerloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionworkersCubit>(context).addinjectionworker(
                              injectionworker: Injectionworkermodel(
                                workernumber:workernumber.text ,
                                 workerhours :double.parse(workhours.text),
                                 workername: workername.text,
                                 workersalary: double.parse(workersalary.text),
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
