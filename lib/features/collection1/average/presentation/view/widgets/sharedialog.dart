import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/features/collection1/average/data/model/averagemodel.dart';
import 'package:cleopatra/features/collection1/average/data/model/cyclemodel.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/cyclepdf.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:share_plus/share_plus.dart';

class Sharedialog extends StatelessWidget {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
              val: "لابد من ادخال اسم المنتج ",
              controller: name,
              hintText: "اسم المنتج",
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            custommaterialbutton(
              button_name: "مشاركه",
              onPressed: () async {
                double totaltime = 0;
                if (formkey.currentState!.validate()) {
                  final img =
                      await rootBundle.load('assets/images/cleopatra-modified.png');
                  final imageBytes = img.buffer.asUint8List();
                  BlocProvider.of<AverageCubit>(context)
                      .averageschecks
                      .forEach((e) {
                    totaltime = totaltime + e.secondsperpiece;
                  });
                  File file = await cyclepdf.generatepdf(
                      totaltime: totaltime,
                      context: context,
                      imageBytes: imageBytes,
                      categories:
                          BlocProvider.of<AverageCubit>(context).averageschecks,
                      name: name.text);
                  await cyclepdf.openfile(file);
                  Share.shareXFiles([XFile(file.path)]);
                }
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
