import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/dateper.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workercomodel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../injections/injection/presentation/views/widgets/widgets/injcopdf.dart';

class graph extends StatelessWidget {
  final List<Dateper> jobs;
  final String name;
  final List<Workercomodel> works;
  graph(
      {super.key, required this.jobs, required this.works, required this.name});
  double sum = 0;
  getsum() {
    for (int i = 0; i < jobs.length; i++) {
      sum = sum + ((jobs[i].per / 100) * (1500 / 26));
    }
    return sum.ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [],
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: Text(
          "توضيح معدل ${name}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "",
              child: Icon(
                Icons.picture_as_pdf,
                color: appcolors.maincolor,
              ),
              backgroundColor: appcolors.primarycolor,
              onPressed: () async {
                double totalval = 0;
                works.forEach((e) {
                  totalval = totalval +
                      (e.quantity *
                          BlocProvider.of<AverageCubit>(context)
                              .averagerateprice[e.job]!);
                });
                final img =
                    await rootBundle.load('assets/images/cleopatra-modified.png');
                final imageBytes = img.buffer.asUint8List();
                File file = await Injworkercopdf.generatepdf(
                    context: context,
                    imageBytes: imageBytes,
                    totalval: totalval,
                    categories: works);
                await Injworkercopdf.openfile(file);
              }),
          SizedBox(
            width: 7,
          ),
          FloatingActionButton(
              heroTag: "aa",
              child: Icon(
                Icons.share,
                color: appcolors.maincolor,
              ),
              backgroundColor: appcolors.primarycolor,
              onPressed: () async {
                double totalval = 0;
                works.forEach((e) {
                  totalval = totalval +
                      (e.quantity *
                          BlocProvider.of<AverageCubit>(context)
                              .averagerateprice[e.job]!);
                });
                final img =
                    await rootBundle.load('assets/images/cleopatra-modified.png');
                final imageBytes = img.buffer.asUint8List();
                File file = await Injworkercopdf.generatepdf(
                    context: context,
                    imageBytes: imageBytes,
                    totalval: totalval,
                    categories: works);
                await Injworkercopdf.openfile(file);
                Share.shareXFiles([XFile(file.path)]);
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              " أجمالي الحوافزالمستحقه : ${getsum()} ",
              style: TextStyle(fontFamily: "cairo", fontSize: 15),
            ),
            SizedBox(
              height: 85,
            ),
            SizedBox(
              height: 400,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                plotAreaBorderColor: Colors.white,
                plotAreaBackgroundColor: Colors.white,
                margin: EdgeInsets.all(15),
                plotAreaBorderWidth: 10,
                borderWidth: 0,
                borderColor: Colors.white,
                primaryXAxis: NumericAxis(
                  labelStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  numberFormat: NumberFormat(""),
                  maximumLabels: jobs.length,
                  title: AxisTitle(
                      text: "ايام العمل",
                      textStyle: TextStyle(
                          fontFamily: "cairo", color: Colors.redAccent)),
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                  title: AxisTitle(
                      text: "% نسبة الانتاج",
                      textStyle: TextStyle(
                          fontFamily: "cairo", color: Colors.redAccent)),
                  borderColor: Colors.transparent,
                ),
                series: <CartesianSeries<Dateper, int>>[
                  SplineAreaSeries(
                      splineType: SplineType.monotonic,
                      gradient: LinearGradient(
                          colors: [
                            appcolors.maincolor,
                            appcolors.dropcolor,
                            appcolors.maincolor.withOpacity(0.3)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      dataSource: jobs,
                      xValueMapper: (Dateper data, _) => data.date,
                      yValueMapper: (Dateper data, _) => data.per),
                  SplineSeries(
                      splineType: SplineType.monotonic,
                      width: 4,
                      markerSettings: MarkerSettings(
                          color: appcolors.primarycolor,
                          isVisible: true,
                          shape: DataMarkerType.circle),
                      dataSource: jobs,
                      xValueMapper: (Dateper data, _) => data.date,
                      yValueMapper: (Dateper data, _) => data.per),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
