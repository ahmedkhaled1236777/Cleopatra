import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injection/data/models/diagnosemodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';

class Adddiagnoseandfix extends StatelessWidget {
  TextEditingController diagnosename = TextEditingController();
  TextEditingController fix = TextEditingController();
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
          "اضافة عطل",
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
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                controller: diagnosename,
                hintText: "نوع العطل",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                controller: fix,
                hintText: "طريقة اصلاحه",
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<productioncuibt, productiontates>(
                listener: (context, state) async {
                  if (state is adddiagnosesuccess) {
                    showtoast(
                                                                                                        context: context,

                        message: "تم التسجيل بنجاح",
                        toaststate: Toaststate.succes);

                    await BlocProvider.of<productioncuibt>(context)
                        .getdiagnoses();
                  }
                  if (state is adddiagnosefailure)
                    showtoast(
                                                                                                        context: context,

                        message: "يوجد خطأ برجاء المحاوله لاحقا",
                        toaststate: Toaststate.error);
                },
                builder: (context, state) {
                  if (state is adddiagnoseloading) return loading();
                  return custommaterialbutton(
                    button_name: "تسجيل",
                    onPressed: () {
                      BlocProvider.of<productioncuibt>(context).adddiagnose(
                          diagnose: Diagnosemodel(
                              diagnose: diagnosename.text, fix: fix.text));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
