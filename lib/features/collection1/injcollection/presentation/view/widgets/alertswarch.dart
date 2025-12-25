import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/averagediagram.dart';

class diagramsearch extends StatefulWidget {
  @override
  State<diagramsearch> createState() => _diagramsearchState();
}

class _diagramsearchState extends State<diagramsearch> {
  int? month;

  int? year;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: TextStyle(
                                    fontFamily: "cairo",
                                    color: appcolors.maincolor),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                final selected = await showMonthPicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2050),
                                    locale: Locale('ar'));
                                if (selected != null) {
                                  month = selected.month;
                                  year = selected.year;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xff535C91),
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Color(0xff535C91))),
                                child: Center(
                                  child: Text(
                                    month == null
                                        ? "اختر التاريخ"
                                        : "0${month}-${year}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () {
                                if (month == null) {
                                  showdialogerror(
                                      error: "لابد من اختيار الشهر",
                                      context: context);
                                } else {
                                  Navigator.pop(context);
                                  navigateto(
                                      context: context,
                                      page: Averagediagram(
                                        date:
                                            "${month! < 10 ? "0${month}" : month}-${year}",
                                      ));
                                }
                              },
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
