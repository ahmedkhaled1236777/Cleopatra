import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';

class Ordermaterialdialog extends StatelessWidget {
  final injectionhallmodel injectionhallmod;
  final double residualquantity;
  const Ordermaterialdialog(
      {super.key,
      required this.injectionhallmod,
      required this.residualquantity});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "تفاصيل الاوردر",
            style: TextStyle(
                fontFamily: "cairo",
                fontSize: 12.5,
                color: appcolors.maincolor),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                Text("نوع الخامه",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(injectionhallmod.materialtype,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                Text("كميه الاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Text(injectionhallmod.quantity!,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor))
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن الخامه البيور اللازمه للاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
    injectionhallmod.sprue==true?            Expanded(
                  child: Text(
                      (((int.parse(injectionhallmod.quantity) *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weight"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (int.parse(injectionhallmod.quantity) *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]!["weight"])))) *
                              (double.parse(injectionhallmod.pureper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.red)),
                ):      Expanded(
                  child: Text(
                      (((int.parse(injectionhallmod.quantity) *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weightbysprue"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (int.parse(injectionhallmod.quantity) *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]!["weightbysprue"])))) *
                              (double.parse(injectionhallmod.pureper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.red)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن الكسر اللازم للاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
         injectionhallmod.sprue?       Expanded(
                  child: Text(
                      (((int.parse(injectionhallmod.quantity) *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weight"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (int.parse(injectionhallmod.quantity) *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]!["weight"])))) *
                              (double.parse(injectionhallmod.breakper) / 100) /
                              1000)
                          .toString(),
                      style: TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.red)),
                ):Expanded(
                  child: Text(
                      (((int.parse(injectionhallmod.quantity) *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weightbysprue"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (int.parse(injectionhallmod.quantity) *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(
                                                      context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]!["weightbysprue"])))) *
                              (double.parse(injectionhallmod.breakper) / 100) /
                              1000)
                          .toString(),
                      style: TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.red)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن الماستر اللازم للاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
           injectionhallmod.sprue==true?     Expanded(
                  child: Text(
                      (((double.parse(injectionhallmod.masterper) / 100) *
                                  (int.parse(injectionhallmod.quantity) *
                                      double.parse(BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "weight"]))) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.red)),
                ):Expanded(
                  child: Text(
                      (((double.parse(injectionhallmod.masterper) / 100) *
                                  (int.parse(injectionhallmod.quantity) *
                                      double.parse(BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "weightbysprue"]))) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.red)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                Text("الكميه المتبقيه لانتهاء الاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: Colors.blue)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Expanded(
                  child: Text(residualquantity.toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.blue)),
                ),
                Text("ق")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("الخامه البيور المتبقيه لانتهاء للاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
          injectionhallmod.sprue==true?      Expanded(
                  child: Text(
                      (((residualquantity *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weight"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (residualquantity *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(context)
                                                      .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                                  "weight"])))) *
                              (double.parse(injectionhallmod.pureper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ): Expanded(
                  child: Text(
                      (((residualquantity *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weightbysprue"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (residualquantity *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(context)
                                                      .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                                  "weightbysprue"])))) *
                              (double.parse(injectionhallmod.pureper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن الكسر المتبقي لانتهاء للاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
          injectionhallmod.sprue==true?      Expanded(
                  child: Text(
                      (((residualquantity *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weight"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (residualquantity *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(context)
                                                      .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                                  "weight"])))) *
                              (double.parse(injectionhallmod.breakper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ): Expanded(
                  child: Text(
                      (((residualquantity *
                                      double.parse(
                                          BlocProvider.of<productioncuibt>(context)
                                                  .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                              "weightbysprue"])) -
                                  ((double.parse(injectionhallmod.masterper) /
                                          100) *
                                      (residualquantity *
                                          double.parse(
                                              BlocProvider.of<productioncuibt>(context)
                                                      .timerrate["${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                                  "weightbysprue"])))) *
                              (double.parse(injectionhallmod.breakper) / 100) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن الماستر المتبقي لانتهاء الاوردر",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
          injectionhallmod.sprue?      Expanded(
                  child: Text(
                      (((double.parse(injectionhallmod.masterper) / 100) *
                                  (residualquantity *
                                      double.parse(BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "weight"]))) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ): Expanded(
                  child: Text(
                      (((double.parse(injectionhallmod.masterper) / 100) *
                                  (residualquantity *
                                      double.parse(BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "weightbysprue"]))) /
                              1000)
                          .toStringAsFixed(1),
                      style: TextStyle(
                          fontFamily: "cairo",
                          fontSize: 12.5,
                          color: Colors.green)),
                ),
                Text("ك")
              ],
            ),
          ),
          SizedBox(
            height: 7,
          ),
      if(injectionhallmod.sprue==false)    Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: appcolors.primarycolor)),
            child: Row(
              children: [
                const Text("وزن خامة المخزن",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                const Text(" : ",
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontSize: 12.5,
                        color: appcolors.maincolor)),
                Expanded(
                  child: Text(
             ((  (   double.parse(injectionhallmod.quantity)/int.parse(BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "numberofpieces"]))*BlocProvider.of<
                                                      productioncuibt>(context)
                                                  .timerrate[
                                              "${injectionhallmod.name}-${injectionhallmod.materialtype}"]![
                                          "sprueweight"])/1000).toStringAsFixed(1),
                      style: TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.red)),
                ),
                Text("ك")
              ],
            ),
          ),
        ],
      )),
    );
  }
}
