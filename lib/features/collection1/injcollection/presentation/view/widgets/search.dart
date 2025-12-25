import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/view/widgets/alertswarch.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';

class diagramsearchreport extends StatefulWidget {
  @override
  State<diagramsearchreport> createState() => _diagramsearchreportState();
}

class _diagramsearchreportState extends State<diagramsearchreport> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!permession.contains('عرض تقرير شهري تجميع')) {
          showdialogerror(error: "ليس لديك الصلاحيه للدخول", context: context);
        } else
          showDialog(
            context: context,

            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  title: Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          BlocProvider.of<DateCubit>(context).cleardates();

                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close)),
                  ),
                  content: diagramsearch());
            },
          );
      },
      child: const Icon(
        Icons.show_chart_sharp,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
