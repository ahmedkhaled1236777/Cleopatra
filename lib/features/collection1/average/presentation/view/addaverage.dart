import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';

class Addaverage extends StatelessWidget {
  TextEditingController job = TextEditingController();
  TextEditingController secondsperpiece = TextEditingController();
  TextEditingController prieceofpiece = TextEditingController();
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
          "اضافة وظيفه ومعدلها",
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
                custommytextform(
                  val: "برجاء ادخال الوظيفه",
                  controller: job,
                  hintText: "الوظيفه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  val: "برجاء ادخال عدد الثواني",
                  keyboardType: TextInputType.number,
                  controller: secondsperpiece,
                  hintText: "عدد الثواني لعمل قطعه من الوظيفه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  val: "برجاء ادخال عدد سعر القطعه",
                  keyboardType: TextInputType.number,
                  controller: prieceofpiece,
                  hintText: "سعر القطعه",
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<AverageCubit, AverageState>(
                  listener: (context, state) {
                    if (state is AddAverageFailure)
                      showtoast(
                                                          context: context,    
                          message: state.failuremessage,
                          toaststate: Toaststate.error);
                    if (state is AddAverageSucess) {
                      job.clear();
                      secondsperpiece.clear();
                      prieceofpiece.clear();
                      BlocProvider.of<AverageCubit>(context).getaverages();
                      showtoast(
                                               context: context,

                          message: state.successmessage,
                          toaststate: Toaststate.succes);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddAverageLoading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                        if (formkey.currentState!.validate())
                          BlocProvider.of<AverageCubit>(context).addaverage(
                              average: averagemodel(
                                  prieceofpiece: prieceofpiece.text,
                                  secondsperpiece:
                                      double.parse(secondsperpiece.text),
                                  job: job.text,
                                  id: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}"));
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )))),
    );
  }
}
