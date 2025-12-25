import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as trans;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/dateper.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';
import 'package:cleopatra/features/collection1/graph/graph.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/workercomodel.dart';
import 'package:cleopatra/features/collection1/injcollection/presentation/viewmodel/cubit/injextionco_dart_cubit.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Averagediagram extends StatefulWidget {
  final String date;

  const Averagediagram({super.key, required this.date});
  @override
  State<Averagediagram> createState() => _AveragediagramState();
}

class _AveragediagramState extends State<Averagediagram> {
  @override
  void initState() {
    BlocProvider.of<InjextioncoDartCubit>(context)
        .getworkercodate(month: widget.date, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 32, 62),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [],
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "معدلات العمال",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<InjextioncoDartCubit, InjextioncoDartState>(
        builder: (context, state) {
          if (state is getworkercodataloading)
            return loading();
          else if (state is getworkercodatafailure) return SizedBox();

          if (state is getworkercodatasuccess) {
            if (BlocProvider.of<InjextioncoDartCubit>(context)
                .workersco
                .isEmpty) return nodata();
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: SfCartesianChart(
                enableAxisAnimation: true,
                isTransposed: true,
                primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelRotation: -360,
                  labelPosition: ChartDataLabelPosition.outside,
                  maximumLabels: 100,
                  labelStyle: TextStyle(
                      fontFamily: "cairo", color: Colors.white, fontSize: 10),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: "(بالنسبه المئويه) معدلات العمال",
                      textStyle:
                          TextStyle(color: Colors.white, fontFamily: "cairo")),
                ),
                series: [
                  ColumnSeries<saledate, String>(
                      pointColorMapper: (datum, index) =>
                          chartcolors[index % 7],
                      onPointTap: (pointInteractionDetails) async {
                        List<Workercomodel> jobs = [];
                        List<Dateper> jobswithoutrepet = [];
                        List<String> dates = [];
                        BlocProvider.of<InjextioncoDartCubit>(context)
                            .workersco
                            .forEach((e) {
                          if (e.name ==
                              BlocProvider.of<WorkerCubit>(context).myworkers[
                                  pointInteractionDetails.pointIndex!]) {
                            jobs.add(e);
                          }
                        });
                        for (int i = 0; i < jobs.length; i++) {
                          int counter = 0;
                          double per = 0;
                          if (dates.contains(jobs[i].date))
                            continue;
                          else {
                            for (int j = i; j < jobs.length; j++) {
                              if (jobs[i].date == jobs[j].date) {
                                counter++;
                                per = per +
                                    double.parse(
                                        "${((jobs[j].quantity / ((jobs[j].time * 60) / BlocProvider.of<AverageCubit>(context).averagerate[jobs[j].job])) * 100).round()}");
                              }
                            }
                            dates.add(jobs[i].date);
                            jobswithoutrepet.add(Dateper(
                                per: per / counter,
                                date: DateFormat('yyyy-MM-dd')
                                    .parse(jobs[i].date)
                                    .day));
                          }
                        }

                        jobswithoutrepet
                            .sort((a, b) => a.date.compareTo(b.date));
                        if (jobs.isNotEmpty)
                          Get.to(
                              () => graph(
                                    name: jobs[0].name,
                                    jobs: jobswithoutrepet,
                                    works: jobs,
                                  ),
                              transition: trans.Transition.rightToLeftWithFade,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);

                        /*  final img = await rootBundle
                            .load('assets/images/cleopatra-modified.png');
                        final imageBytes = img.buffer.asUint8List();
                        File file = await Injworkercopdf.generatepdf(
                            context: context,
                            imageBytes: imageBytes,
                            categories: jobs);
                        await Injworkercopdf.openfile(file);*/
                      },
                      dataLabelSettings: DataLabelSettings(
                          margin: EdgeInsets.all(3),
                          labelAlignment: ChartDataLabelAlignment.outer,
                          showCumulativeValues: true,
                          angle: 0,
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 10),
                          color: appcolors.primarycolor),
                      dataSource: getcolumndata(context: context),
                      xValueMapper: (saledate sale, _) => BlocProvider.of<
                                      InjextioncoDartCubit>(context)
                                  .workersdiagram["${sale.x}-{workdays}"]!
                                  .length ==
                              0
                          ? "${sale.x}"
                          : "${sale.x}-${BlocProvider.of<InjextioncoDartCubit>(context).workersdiagram["${sale.x}-{workdays}"]!.length}-${((sale.y / 100) * (1500 / 26) * BlocProvider.of<InjextioncoDartCubit>(context).workersdiagram["${sale.x}-{workdays}"]!.length).ceil()}",
                      yValueMapper: (saledate sale, _) => sale.y)
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class saledate {
  final String x;
  final double y;

  saledate({required this.x, required this.y});
}

getcolumndata({required BuildContext context}) {
  List<String> workers = BlocProvider.of<WorkerCubit>(context).myworkers;
  List<saledate> columndata = workers.map((e) {
    double trueval = 0;
    double expectedval = 0;
    BlocProvider.of<InjextioncoDartCubit>(context)
        .workersdiagram["${e}-{true}"]!
        .forEach((e) {
      trueval = trueval + e;
    });
    BlocProvider.of<InjextioncoDartCubit>(context)
        .workersdiagram["${e}-{expected}"]!
        .forEach((e) {
      expectedval = expectedval + e;
    });

    return saledate(x: e, y: ((trueval * 100) / expectedval).ceilToDouble());
  }).toList();
  return columndata;
}
