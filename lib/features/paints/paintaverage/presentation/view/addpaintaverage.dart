import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintaveragemodel.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';

class Addpaintaverage extends StatelessWidget {
  TextEditingController job = TextEditingController();
  TextEditingController secondsperpiece = TextEditingController();
  TextEditingController boyaeight = TextEditingController();
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
                  val: "برجاء ادخال اسم المنتج",
                  controller: job,
                  hintText: "المنتج",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  keyboardType: TextInputType.number,
                  val: "برجاء ادخال عدد الثواني",
                  controller: secondsperpiece,
                  hintText: "عدد الثواني لرش قطعه",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  keyboardType: TextInputType.number,
                  val: "برجاء ادخال وزن البويا",
                  controller: boyaeight,
                  hintText: "وزن البويا",
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<paintaverageCubit, paintaverageState>(
                  listener: (context, state) {
                    if (state is AddpaintaverageFailure)
                      showtoast(
                                                                                                          context: context,

                          message: state.failuremessage,
                          toaststate: Toaststate.error);
                    if (state is AddpaintaverageSucess) {
                      job.clear();
                      secondsperpiece.clear();
                      BlocProvider.of<paintaverageCubit>(context)
                          .getpaintaverages();
                      showtoast(
                                                                                                          context: context,

                          message: state.successmessage,
                          toaststate: Toaststate.succes);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddpaintaverageLoading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () {
                        BlocProvider.of<paintaverageCubit>(context).addpaintaverage(
                            paintaverage: paintaveragemodel(
                                boyaweight: double.parse(boyaeight.text),
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
      ),
    );
  }
}
