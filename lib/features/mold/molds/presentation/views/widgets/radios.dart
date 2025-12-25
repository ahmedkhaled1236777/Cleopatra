import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';

class radios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var moldbloc = BlocProvider.of<MoldsCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
            activeColor: appcolors.seconderycolor,
            value: firstradio,
            groupValue: moldbloc.type,
            onChanged: (val) {
              moldbloc.changetype(value: val!);
            }),
        Text(firstradiotitle),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 10,
        ),
        Radio(
            activeColor: appcolors.seconderycolor,
            value: secondradio,
            groupValue: moldbloc.type,
            onChanged: (val) {
              moldbloc.changetype(value: val!);
            }),
        Text(secondradiotitle),
      ],
    );
  }
}
