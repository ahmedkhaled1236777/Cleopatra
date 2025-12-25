import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionmachines/data/model/injectionmachinemodel.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_cubit.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_state.dart';



class editmachinedialog extends StatelessWidget {
  final int machinenumber;
   final TextEditingController machinename ;
  final  TextEditingController cost ;
final  TextEditingController costelectrichour ;
final  TextEditingController machinedeprecation ;
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  editmachinedialog(
      {super.key,
      required this.machinename,
      required this.machinenumber,
      required this.machinedeprecation,
      required this.cost,
      required this.costelectrichour});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                ), SizedBox(
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
                    if (state is updateInjectionmachinesuccess) {
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            Navigator.pop(context);
                      await BlocProvider.of<InjectionmachinesCubit>(context).getinjectionmachines();
                    }
                    if (state is updateInjectionmachinefailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is updateInjectionmachineloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionmachinesCubit>(context).updatinjectionmachines(
                              injectionmachine: Injectionmachinemodel(
                                machinenumber:machinenumber ,
                                 machinecost :double.parse(cost.text),
                                 machinedeprecation :double.parse(machinedeprecation.text),
                                 machinename: machinename.text,
                                 machinehourelectriccost: double.parse(costelectrichour.text),
                                 ));
                       } },
                    );
                  },
                ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
