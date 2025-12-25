import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';

import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_state.dart';

class Addmoldusage extends StatelessWidget {
  TextEditingController moldname = TextEditingController();
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
                custommytextform(
                  controller: moldname,
                  hintText: "اسم الاسطمبه",
                  val: "برجاء ادخال اسم الاسطمبه",
                ),
                SizedBox(
                  height: 25,
                ),
                BlocConsumer<moldusagesCubit, moldusagesState>(
                  listener: (context, state) async {
                    if (state is addmoldusagesuccess) {
                      moldname.clear();
                      BlocProvider.of<moldusagesCubit>(context).getmoldusages();
                      showtoast(
                                                                                                          context: context,

                          message: state.success_message,
                          toaststate: Toaststate.succes);
                    }
                    if (state is addmoldusagefailure)
                      showtoast(
                                                                                                          context: context,

                          message: state.error_message,
                          toaststate: Toaststate.error);
                  },
                  builder: (context, state) {
                    if (state is addmoldusageloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                        if (formkey.currentState!.validate())
                          BlocProvider.of<moldusagesCubit>(context)
                              .addmoldusage(
                                  moldusagemodel: moldusagemodel(
                            numberofuses: 0,
                            moldname: moldname.text,
                          ));
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
        ))));
  }
}
