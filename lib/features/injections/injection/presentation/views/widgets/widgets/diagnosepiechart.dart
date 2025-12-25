import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/produsage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Diagnosepiechart extends StatelessWidget {
  final List<dynamic> errors;
  final String ordername;
  const Diagnosepiechart(
      {super.key, required this.errors, required this.ordername});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "اداء الاوردر",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              PieChart(
                dataMap: {
                  "الانتاج السليم":
                      (BlocProvider.of<injectionusagecuibt>(context).total /
                              BlocProvider.of<injectionusagecuibt>(context)
                                  .expecprod) *
                          100,
                  "التوالف":
                      (BlocProvider.of<injectionusagecuibt>(context).scrap /
                              BlocProvider.of<injectionusagecuibt>(context)
                                  .expecprod) *
                          100,
                  "اوقات التوقف      ":
                      (BlocProvider.of<injectionusagecuibt>(context)
                                  .machinestop /
                              (BlocProvider.of<injectionusagecuibt>(context)
                                      .workhours *
                                  60)) *
                          100,
                },
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3,
                colorList: [Colors.purple, appcolors.primarycolor, Colors.blue],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.left,
                  showLegends: true,
                  legendShape: BoxShape.rectangle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
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
                height: 25,
              ),
              Text("الترشيحات لزيادة كفاءة وقت الاوردر",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "cairo",
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, i) => AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  "${i + 1}- ${cashhelper.getdata(key: errors[i])} نتيجة ${errors[i]}",
                                  textStyle: TextStyle(
                                    color: Color(0xff175ADC),
                                    fontFamily: "cairo",
                                    fontSize: 15,
                                  ),
                                  speed: Duration(milliseconds: 60)),
                            ],
                          ),
                      separatorBuilder: (context, i) => Divider(
                            color: Colors.grey,
                          ),
                      itemCount: errors.length))
            ],
          ),
        ));
  }
}
