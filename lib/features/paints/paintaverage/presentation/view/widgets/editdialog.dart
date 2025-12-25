import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/paints/paintaverage/data/model/paintaveragemodel.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';

class editpaintaverageedialog extends StatelessWidget {
  final paintaveragemodel paintaverage;
  final TextEditingController job;
  final TextEditingController boyaweight;
  final TextEditingController rate;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editpaintaverageedialog(
      {super.key,
      required this.paintaverage,
      required this.boyaweight,
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
              height: 20,
            ),
            BlocConsumer<paintaverageCubit, paintaverageState>(
              listener: (context, state) {
                if (state is UpdatepaintaverageFailure)
                  showdialogerror(error: state.errormessage, context: context);
                if (state is UpdatepaintaverageSuccess) {
                  BlocProvider.of<paintaverageCubit>(context)
                      .getpaintaverages();
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is UpdatepaintaverageLoading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    BlocProvider.of<paintaverageCubit>(context).update(
                        paintaverage: paintaveragemodel(
                            boyaweight: double.parse(boyaweight.text) / 2,
                            secondsperpiece: double.parse(rate.text),
                            job: job.text,
                            id: paintaverage.id));
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
