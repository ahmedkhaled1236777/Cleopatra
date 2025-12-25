import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';

class waitingradioradios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String groupvalue;
  final int index;
  waitingradioradios(
      {super.key,
      required this.firstradio,
      required this.index,
      required this.secondradio,
      required this.groupvalue,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.primarycolor,
              value: firstradio,
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<HrCubit>(context)
                    .changestatus(status: val!, index: index);
              }),
          Text(
            firstradiotitle,
            style: TextStyle(fontFamily: "cairo"),
          ),
          Radio(
              activeColor: appcolors.primarycolor,
              value: secondradio,
              groupValue: groupvalue,
              onChanged: (val) {
                BlocProvider.of<HrCubit>(context)
                    .changestatus(status: val!, index: index);
              }),
          Text(
            secondradiotitle,
            style: TextStyle(fontFamily: "cairo"),
          ),
        ],
      ),
    );
  }
}
