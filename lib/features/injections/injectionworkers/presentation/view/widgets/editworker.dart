import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injectionworkers/data/model/injectioworkermodel.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_cubit.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_state.dart';



class editworkerdialog extends StatelessWidget {
  final TextEditingController workernumber;
  final String workername;
  final  TextEditingController workhours ;
final  TextEditingController workersalary ;
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  editworkerdialog(
      {super.key,
      required this.workersalary,
      required this.workername,
      required this.workernumber,
      required this.workhours});

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
             Text(
            workername,
            style: TextStyle(
                fontFamily: "cairo",
                fontSize: 12.5,
                color: appcolors.maincolor),
          ),
          SizedBox(height: 10,),
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
                    if (state is updateInjectionworkersuccess) {
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
            Navigator.pop(context);
                      await BlocProvider.of<InjectionworkersCubit>(context).getinjectionworkers();
                    }
                    if (state is updateInjectionworkerfailure )
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is updateInjectionworkerloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                       if(formkey.currentState!.validate()){
                          BlocProvider.of<InjectionworkersCubit>(context).updatinjectionworkers(
                              injectionworker: Injectionworkermodel(
                                workernumber:workernumber.text ,
                                 workerhours :double.parse(workhours.text),
                                 workername: workername,
                                 workersalary: double.parse(workersalary.text),
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
