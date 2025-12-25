import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/components/data/models/componentmodel.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';

class Addcomponent extends StatelessWidget {
  TextEditingController quantity = TextEditingController();
  TextEditingController componentname = TextEditingController();
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
          "اضافة مكون",
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
                          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                controller: componentname,
                hintText: "اسم المنتج",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                keyboardType: TextInputType.number,
                controller: quantity,
                hintText: "الكميه",
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<componentCubit, componentState>(
                listener: (context, state) async {
                  if (state is addcomponentsuccess) {
                    showtoast(
                                                                          context: context,

                        message: "تم التسجيل بنجاح",
                        toaststate: Toaststate.succes);

                    await BlocProvider.of<componentCubit>(context)
                        .getcomponents();
                  }
                  if (state is addcomponentfailure)
                    showtoast(
                                                                          context: context,

                        message: "يوجد خطأ برجاء المحاوله لاحقا",
                        toaststate: Toaststate.error);
                },
                builder: (context, state) {
                  if (state is addcomponentloading) return loading();
                  return custommaterialbutton(
                    button_name: "تسجيل",
                    onPressed: () {
                      if (BlocProvider.of<componentCubit>(context)
                          .compenantsnames
                          .contains(componentname.text))
                        showdialogerror(
                            error: "هذا المنتج مسجل لدينا من قبل",
                            context: context);
                      else
                        BlocProvider.of<componentCubit>(context).addcomponent(
                            component: componentsmodel(
                                quantity: int.parse(quantity.text),
                                name: componentname.text));
                    },
                  );
                },
              )
            ],
          ),
        ),
          )))),
    );
  }
}
