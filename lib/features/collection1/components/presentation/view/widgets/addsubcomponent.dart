import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/components/data/models/subcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';

class Addsubcomponent extends StatelessWidget {
  final String componentnameid;
  TextEditingController quantity = TextEditingController();
  TextEditingController componentname = TextEditingController();
  TextEditingController weight = TextEditingController();

  Addsubcomponent({super.key, required this.componentnameid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: Text(
          "اضافة جزء من ${componentnameid}",
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
                val: "برجاء ادخال اسم المكون",
                controller: componentname,
                hintText: "اسم المكون",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                val: "برجاء ادخال الكميه",
                keyboardType: TextInputType.number,
                controller: quantity,
                hintText: "الكميه",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                val: "برجاء ادخال الوزن",
                keyboardType: TextInputType.number,
                controller: weight,
                hintText: "الوزن",
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<componentCubit, componentState>(
                listener: (context, state) async {
                  if (state is addsubcomponentloading) {
                    showtoast(
                                                                          context: context,

                        message: "تم التسجيل بنجاح",
                        toaststate: Toaststate.succes);

                    await BlocProvider.of<componentCubit>(context)
                        .getcsubomponents(componentname: componentnameid);
                  }
                  if (state is addsubcomponentfailure)
                    showtoast(
                                                                          context: context,

                        message: "يوجد خطأ برجاء المحاوله لاحقا",
                        toaststate: Toaststate.error);
                },
                builder: (context, state) {
                  if (state is addsubcomponentloading) return loading();
                  return custommaterialbutton(
                    button_name: "تسجيل",
                    onPressed: () {
                      BlocProvider.of<componentCubit>(context).addsubcomponent(
                          componentname: componentnameid,
                          component: Subcomponent(
                              weight: weight.text,
                              qty: quantity.text,
                              name: componentname.text));
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
