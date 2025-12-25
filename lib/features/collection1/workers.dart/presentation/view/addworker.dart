import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/workers.dart/data/model/workermodel.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';

class Addworker extends StatelessWidget {
  TextEditingController workername = TextEditingController();
  TextEditingController code = TextEditingController();
  GlobalKey<FormState> formkry = GlobalKey<FormState>();
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
          "اضافة عامل",
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
            key: formkry,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  val: "برجاء ادخال اسم العامل",
                  controller: workername,
                  hintText: "اسم العامل",
                ),
                SizedBox(
                  height: 10,
                ),
                custommytextform(
                  val: "برجاء ادخال الكود ",
                  controller: code,
                  hintText: "الكود",
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<WorkerCubit, WorkerState>(
                  listener: (context, state) {
                    if (state is AddWorkerfailure) {
                      showtoast(
                                                                                                          context: context,

                          message: state.errormessage,
                          toaststate: Toaststate.error);
                    }
                    if (state is AddWorkersuccess) {
                      workername.clear();
                      code.clear();

                      BlocProvider.of<WorkerCubit>(context).getworkers();
                      showtoast(
                                                                                                          context: context,

                          message: state.successmessage,
                          toaststate: Toaststate.succes);
                    }
                    // TODO: imp
                  },
                  builder: (context, state) {
                    if (state is AddWorkerloading) return loading();
                    return custommaterialbutton(
                      button_name: "تسجيل",
                      onPressed: () async {
                        if (formkry.currentState!.validate())
                          await BlocProvider.of<WorkerCubit>(context).addworker(
                              workermodel: Worker(
                                  workername: workername.text,
                                  code: code.text));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )))),
    );
  }
}
