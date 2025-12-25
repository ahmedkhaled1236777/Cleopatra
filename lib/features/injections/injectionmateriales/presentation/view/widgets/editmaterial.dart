import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionmateriales/data/model/injectionmaterialmodel.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_cubit.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_state.dart';




class editmaterialdialog extends StatelessWidget {
   final String materialname ;
  final  TextEditingController purematerialcost ;
final  TextEditingController breakmaterialcost ;
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  editmaterialdialog(
      {super.key,
      required this.materialname,
      required this.purematerialcost,
      required this.breakmaterialcost,
      });

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
                    if (state is updateInjectionmaterialsuccess) {
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            Navigator.pop(context);
                      await BlocProvider.of<InjectionmaterialsCubit>(context).getinjectionmaterials();
                    }
                    if (state is updateInjectionmaterialfailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is updateInjectionmaterialloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionmaterialsCubit>(context).updatinjectionmaterials(
                              injectionmaterial: Injectionmaterialmodel(
                                 purematerialcost :double.parse(purematerialcost.text),
                                 materialname: materialname,
                                 breakmaterialcost: double.parse(breakmaterialcost.text),
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
