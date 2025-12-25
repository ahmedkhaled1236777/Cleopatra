import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';

class editaverageedialog extends StatelessWidget {
  final averagemodel average;
  final TextEditingController job;
  final TextEditingController rate;
  final TextEditingController prieceofpiece;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editaverageedialog(
      {super.key,
      required this.average,
      required this.prieceofpiece,
      required this.job,
      required this.rate});

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
            custommytextform(
              val: "لابد من ادخال الوظيفه",
              controller: job,
              hintText: "الوظيفه",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "لابد من ادخال عدد الثواني لكل قطعه",
              controller: rate,
              hintText: "عدد الثواني لكل قططعه",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "لابد من ادخال سعر القطعه",
              controller: prieceofpiece,
              hintText: "سعر القطعه",
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<AverageCubit, AverageState>(
              listener: (context, state) {
                if (state is UpdateAverageFailure)
                  showdialogerror(error: state.errormessage, context: context);
                if (state is UpdateAverageSuccess) {
                  BlocProvider.of<AverageCubit>(context).getaverages();
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is UpdateAverageLoading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    if (formkey.currentState!.validate())
                      BlocProvider.of<AverageCubit>(context).update(
                          average: averagemodel(
                              prieceofpiece: prieceofpiece.text,
                              secondsperpiece: double.parse(rate.text),
                              job: job.text,
                              id: average.id));
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
