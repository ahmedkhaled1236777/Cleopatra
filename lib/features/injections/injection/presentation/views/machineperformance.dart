import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/dateper.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/*class Machineperformance extends StatefulWidget {
  final String machinenumber;
  final String month;
  const Machineperformance(
      {super.key, required this.machinenumber, required this.month});

  @override
  State<Machineperformance> createState() => _MachineperformanceState();
}

class _MachineperformanceState extends State<Machineperformance> {
  getdata() async {
    await BlocProvider.of<productioncuibt>(context).getmachinesperformance(
        month: widget.month, machinenumber: widget.machinenumber);
  }

  @override
  void initState() {
    getdata();
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
          "اداء ماكينه ${widget.machinenumber} خلال شهر ${widget.month}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<productioncuibt, productiontates>(
        builder: (context, state) {
          if (state is getmachinesloading) return loading();
          if (state is getmachinesfailure) return SizedBox();
          return BlocProvider.of<productioncuibt>(context).machinecounter == 0
              ? nodata()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ss.PieChart(
                      dataMap: {
                        "اداء الماكينه":
                            BlocProvider.of<productioncuibt>(context)
                                .performance,
                        "التوالف":
                            BlocProvider.of<productioncuibt>(context).scrap,
                        "اوقات التوقف    ":
                            BlocProvider.of<productioncuibt>(context)
                                .machinestop,
                      },
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: [
                        Colors.purple,
                        appcolors.primarycolor,
                        Colors.blue
                      ],
                      initialAngleInDegree: 0,
                      chartType: ss.ChartType.ring,
                      ringStrokeWidth: 32,
                      legendOptions: ss.LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: ss.LegendPosition.left,
                        showLegends: true,
                        legendShape: BoxShape.rectangle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: ss.ChartValuesOptions(
                        showChartValueBackground: true,
                        chartValueBackgroundColor: Colors.cyanAccent,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: true,
                        decimalPlaces: 1,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
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
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            numberFormat: NumberFormat(""),
                            maximumLabels:
                                BlocProvider.of<productioncuibt>(context)
                                    .machinecounter,
                            title: AxisTitle(
                                text: "ايام العمل",
                                textStyle: TextStyle(
                                    fontFamily: "cairo",
                                    color: Colors.redAccent)),
                            borderColor: Colors.transparent,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                            title: AxisTitle(
                                text: "% نسبة الاداء",
                                textStyle: TextStyle(
                                    fontFamily: "cairo",
                                    color: Colors.redAccent)),
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
                                dataSource:
                                    BlocProvider.of<productioncuibt>(context)
                                        .dataSource,
                                xValueMapper: (Dateper data, _) => data.date,
                                yValueMapper: (Dateper data, _) => data.per),
                            SplineSeries(
                                splineType: SplineType.monotonic,
                                width: 4,
                                markerSettings: MarkerSettings(
                                    color: appcolors.primarycolor,
                                    isVisible: true,
                                    shape: DataMarkerType.circle),
                                dataSource:
                                    BlocProvider.of<productioncuibt>(context)
                                        .dataSource,
                                xValueMapper: (Dateper data, _) => data.date,
                                yValueMapper: (Dateper data, _) => data.per),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}*/
