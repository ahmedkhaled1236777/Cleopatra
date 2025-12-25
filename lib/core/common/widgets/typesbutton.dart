import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';

class typesbuttons extends StatefulWidget {
  String type1;
  String type2;
  Color ctype1 = appcolors.primarycolor;
  Color ctype2 = Colors.white;
  Color text1 = Colors.white;
  Color text2 = Colors.black;

  typesbuttons({
    super.key,
    required this.type1,
    required this.type2,
  });

  @override
  State<typesbuttons> createState() => _typesbuttonsState();
}

class _typesbuttonsState extends State<typesbuttons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
                backgroundColor: MaterialStatePropertyAll(widget.ctype1)),
            onPressed: () {
              widget.ctype1 = appcolors.primarycolor;
              widget.ctype2 = Colors.white;
              widget.text1 = Colors.white;
              widget.text2 = Colors.black;
              BlocProvider.of<injectionhallcuibt>(context)
                  .getinjection(status: false);
              setState(() {});
            },
            child: Text(widget.type1,
                style: TextStyle(
                    fontFamily: "cairo", fontSize: 18, color: widget.text1))),
        TextButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
                backgroundColor: MaterialStatePropertyAll(widget.ctype2)),
            onPressed: () {
              widget.ctype2 = appcolors.primarycolor;
              widget.ctype1 = Colors.white;
              widget.text2 = Colors.white;
              widget.text1 = Colors.black;
              BlocProvider.of<injectionhallcuibt>(context)
                  .getinjection(status: true);
              setState(() {});
            },
            child: Text(widget.type2,
                style: TextStyle(
                    fontFamily: "cairo", fontSize: 18, color: widget.text2))),
      ],
    );
  }
}
