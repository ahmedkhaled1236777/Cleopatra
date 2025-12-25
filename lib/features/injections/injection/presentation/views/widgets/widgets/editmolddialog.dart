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

class editmolddialog extends StatelessWidget {
  final timermodel timer;
  final TextEditingController cycletime;
  final TextEditingController weight;
  final TextEditingController numberofpieces;
  final TextEditingController sprueweight;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editmolddialog(
      {super.key,
      required this.timer,
      required this.weight,
      required this.sprueweight,
      required this.numberofpieces,
      required this.cycletime});

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
            Container(
              color: Color(0xff535C91),
              child: Center(
                child: BlocBuilder<MoldsCubit, MoldsState>(
                  builder: (context, state) {
                    return DropdownSearch<String>(
                      dropdownButtonProps:
                          DropdownButtonProps(color: Colors.white),
                      popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps()),
                      selectedItem:
                          BlocProvider.of<MoldsCubit>(context).materialtype,
                      items: BlocProvider.of<MoldsCubit>(context).materiales,
                      onChanged: (value) {
                        BlocProvider.of<MoldsCubit>(context)
                            .materialchange(value!);
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(
                              color: Colors.white, fontFamily: "cairo"),
                          textAlign: TextAlign.center,
                          dropdownSearchDecoration: InputDecoration(
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff535C91)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff535C91)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
            custommytextform(
              val: "لابد من ادخال عدد القطع",
              controller: numberofpieces,
              hintText: "عدد القطع",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "لابد من ادخال زمن الدوره",
              controller: cycletime,
              hintText: "زمن الدوره",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "لابد من ادخال وزن المنتج",
              controller: weight,
              hintText: "وزن القطعه",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "لابد من ادخال وزن المصب",
              controller: sprueweight,
              hintText: "وزن المصب",
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<productioncuibt, productiontates>(
              listener: (context, state) {
                if (state is UpdateTimerFailure)
                  showdialogerror(error: state.errormessage, context: context);
                if (state is UpdateTimerSuccess) {
                  BlocProvider.of<productioncuibt>(context).gettimers();
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is UpdateTimerLoading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    BlocProvider.of<productioncuibt>(context).update(
                        timer: timermodel(
                            materialtype: BlocProvider.of<MoldsCubit>(context)
                                        .materialtype ==
                                    "نوع الخامه"
                                ? "لا يوجد"
                                : BlocProvider.of<MoldsCubit>(context)
                                    .materialtype,
                            moldname: timer.moldname,
                            sprueweight: double.parse(sprueweight.text) as num,
                            numberofpieces: numberofpieces.text,
                            secondsperpiece: double.parse(cycletime.text),
                            weight: weight.text,
                            id: timer.id));
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
