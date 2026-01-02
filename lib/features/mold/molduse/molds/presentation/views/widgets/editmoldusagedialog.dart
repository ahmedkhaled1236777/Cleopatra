import 'package:cleopatra/features/mold/molduse/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_state.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/injections/injection/data/models/timermodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';

class editmoldusagedialog extends StatelessWidget {
  final moldusagemodel moldusage;
  final TextEditingController bag;
  final TextEditingController karton;
  final TextEditingController glutinous;
  final TextEditingController can;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editmoldusagedialog(
      {super.key,
      required this.moldusage,
      required this.bag,
      required this.can,
      required this.karton,
      required this.glutinous});

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
            SizedBox(
              height: 10,
            ),
                   custommytextform(
                  controller: karton,
                  hintText: "عدد الكراتين لكل قطعه",
                  val: "برجاء ادخال عدد الكراتين لكل قطعه",
                ),
              SizedBox(height: 10,),
                 custommytextform(
                  controller: can,
                  hintText: "عدد العلب لكل قطعه",
                  val: "برجاء ادخال عدد العلب لكل قطعه",
                ),
              SizedBox(height: 10,),
                 custommytextform(
                  controller: bag,
                  hintText: "عدد الاكياس لكل قطعه",
                  val: "برجاء ادخال عدد الاكياس لكل قطعه",
                ),
              SizedBox(height: 10,),
                 custommytextform(
                  controller: glutinous,
                  hintText: "عدد بكرات اللزق لكل قطعه",
                  val: "برجاء ادخال عدد بكرات اللزق لكل قطعه",
                ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<moldusagesCubit, moldusagesState>(
              listener: (context, state) {
                if (state is editmoldusagefailure)
                  showdialogerror(error: state.error_message, context: context);
                if (state is editmoldusagesuccess) {
                  BlocProvider.of<moldusagesCubit>(context).getmoldusages();
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is editmoldusageloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    BlocProvider.of<moldusagesCubit>(context).editmoldusage(
                        moldusagemodel:  moldusagemodel(
                            numberofuses: moldusage.numberofuses,
                            moldname: moldusage.moldname, bag: double.parse(bag.text), can: double.parse(can.text), 
                            karton: double.parse(karton.text), glutinous: double.parse(glutinous.text),
                          ));
                  },
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
