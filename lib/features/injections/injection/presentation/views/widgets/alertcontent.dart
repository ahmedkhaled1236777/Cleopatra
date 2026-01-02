import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';

class Alertcontent extends StatelessWidget {
  TextEditingController shift = TextEditingController();
  TextEditingController machine = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo",
                                    fontSize: 12.5),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date2,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate2(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            custommaterialbutton(
                                button_name: "بحث",
                                onPressed: () async {
                                  if (BlocProvider.of<DateCubit>(context)
                                          .date2 ==
                                      "اختر التاريخ") {
                                    showdialogerror(
                                        error: "لابد من اختيار التاريخ",
                                        context: context);
                                  } else {
                                    Navigator.pop(context);

                                    await BlocProvider.of<productioncuibt>(
                                            context)
                                        .shearchforproduction(
                                            date: BlocProvider.of<DateCubit>(
                                                            context)
                                                        .date2 ==
                                                    "اختر التاريخ"
                                                ? null
                                                : BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date2,
                                            machinenumber: machine.text.isEmpty
                                                ? null
                                                : machine.text,
                                            shift: shift.text.isEmpty
                                                ? null
                                                : shift.text);
                                  }
                                })
                          ]))))
            ])));
  }
}
