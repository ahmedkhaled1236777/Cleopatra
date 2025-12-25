import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' as ss;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintorders/presentation/viewmodel/paintcuibt.dart';
import 'package:cleopatra/features/injections/injection/data/models/productionmodel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

importpaintexcell(
    {required String date,
    required ss.BuildContext context,
    required List<paintreportmodel> productions}) async {
  Excel excell = Excel.createExcel();
  Sheet sheet = excell[excell.getDefaultSheet()!];
  sheet.isRTL = true;
  CellStyle cellStyle = CellStyle(
    bold: true,
    fontFamily: "cairo",
    fontSize: 15,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    leftBorder: Border(borderStyle: BorderStyle.Medium),
    rightBorder: Border(borderStyle: BorderStyle.Medium),
    topBorder: Border(
      borderStyle: BorderStyle.Medium,
    ),
    bottomBorder: Border(
      borderStyle: BorderStyle.Medium,
    ),
  );
  List<String> header = [
    "التاريخ",
    "رقم الاوردر",
    "رقم الورديه",
    "رقم الماكينه",
    "اسم العامل",
    "اسم المنتج",
    "اللون",
    "زمن الدوره",
    "عدد القطع",
    "عدد ساعات التشغيل",
    "بداية العداد",
    "نهاية العداد",
    "كمية الانتاج الفعلي",
    "كمية الهالك",
    "كمية الانتاج المتوقع",
    "الفاقد في الانتاج",
    "وقت توقف الماكينه(دقيقه)",
    "ملاحظات",
  ];
  for (int i = 0; i < 18; i++) {
    var cell22 =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell22.value = TextCellValue(header[i]);
    cell22.cellStyle = cellStyle;
    if (i == 16 || i == 17 || i == 6 || i == 8 || i == 10 || i == 11)
      sheet.setColumnWidth(i, 34);
    else
      sheet.setColumnWidth(i, 18);
  }
  for (int i = 0; i < productions.length; i++) {
    sheet.setRowHeight(i, 35);
    sheet.setRowHeight(i + 1, 35);

    var cell =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 0));
    cell.value = TextCellValue(productions[i].date);
    cell.cellStyle = cellStyle;
    var cell15 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 1));
    cell15.value = TextCellValue(productions[i].ordernuber ?? "لا يوجد");
    cell15.cellStyle = cellStyle;

    var cell16 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 2));
    cell16.value = TextCellValue(productions[i].prodname);
    cell16.cellStyle = cellStyle;
    var cell1 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 3));
    cell1.value = TextCellValue(productions[i].workhours);
    cell1.cellStyle = cellStyle;
    var cell2 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 4));
    cell2.value = TextCellValue(productions[i].numberofworkers);
    cell2.cellStyle = cellStyle;
    var cell3 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 5));
    cell3.value = TextCellValue(productions[i].actualdiskes);
    cell3.cellStyle = cellStyle;
    var cell18 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 6));
    cell18.value =
        TextCellValue(productions[i].numberofskewerintray ?? "لا بوجد");
    cell18.cellStyle = cellStyle;
    var cell4 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 7));
    cell4.value = TextCellValue(productions[i].numberofpiecesinskewer);
    cell4.cellStyle = cellStyle;
    var cell5 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 8));
    cell5.value = TextCellValue(
        ((double.parse(productions[i].workhours) * 60 * 60) /
                (BlocProvider.of<paintaverageCubit>(context)
                    .paintaveragerate[productions[i].prodname]))
            .round()
            .toString());
    cell5.cellStyle = cellStyle;
    var cell6 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 9));
    cell6.value = TextCellValue(productions[i].actualprodquantity.toString());
    cell6.cellStyle = cellStyle;
    var cell7 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 10));
    cell7.value = TextCellValue(productions[i].boyaweightend);
    cell7.cellStyle = cellStyle;
    var cell8 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 11));
    cell8.value = TextCellValue(((productions[i].actualprodquantity +
                productions[i].scrappaintquantity) *
            BlocProvider.of<paintaverageCubit>(context)
                .paintaveragerateweight[productions[i].prodname])
        .toStringAsFixed(1));
    cell8.cellStyle = cellStyle;
    var cell9 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 12));
    cell9.value = TextCellValue(productions[i].scrappaintquantity.toString());
    cell9.cellStyle = cellStyle;
    var cell10 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 13));
    cell10.value = TextCellValue((double.parse(
                productions[i].scrappaintquantity.toString()) /
            (double.parse(productions[i].scrappaintquantity.toString()) +
                (double.parse(productions[i].actualprodquantity.toString()))) *
            100)
        .toStringAsFixed(2));
    cell10.cellStyle = cellStyle;
    var cell11 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 14));
    cell11.value = TextCellValue(productions[i].scrapinjquantity);
    cell11.cellStyle = cellStyle;
    var cell12 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 15));
    cell12.value = TextCellValue((double.parse(
                productions[i].scrapinjquantity.toString()) /
            (double.parse(productions[i].scrappaintquantity.toString()) +
                double.parse(productions[i].scrapinjquantity.toString()) +
                (double.parse(productions[i].actualprodquantity.toString()))) *
            100)
        .toStringAsFixed(2));
    cell12.cellStyle = cellStyle;
    var cell13 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 16));
    cell13.value = TextCellValue(
        (((double.parse(productions[i].workhours) * 60 * 60) /
                        (BlocProvider.of<paintaverageCubit>(context)
                            .paintaveragerate[productions[i].prodname]) -
                    productions[i].actualprodquantity) *
                (BlocProvider.of<paintaverageCubit>(context)
                        .paintaveragerate[productions[i].prodname] /
                    60))
            .toStringAsFixed(2));
    cell13.cellStyle = cellStyle;
    var cell14 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 17));
    cell14.value = TextCellValue(productions[i].notes);
    cell14.cellStyle = cellStyle;

    sheet.setColumnWidth(i, 18);
  }

  var directory = await getExternalStorageDirectory();
//getApplicationDocumentsDirectory();

  final file = File('${directory!.path}/تفرير انتاج ${date}.xlsx');
  var fileBytes = excell.save();

  await file.writeAsBytes(fileBytes!);
  await OpenFile.open(file.path);
}

sharepaintexcell(
    {required String date,
    required ss.BuildContext context,
    required List<paintreportmodel> productions}) async {
  Excel excell = Excel.createExcel();
  Sheet sheet = excell[excell.getDefaultSheet()!];
  sheet.isRTL = true;
  CellStyle cellStyle = CellStyle(
    bold: true,
    fontFamily: "cairo",
    fontSize: 15,
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    leftBorder: Border(borderStyle: BorderStyle.Medium),
    rightBorder: Border(borderStyle: BorderStyle.Medium),
    topBorder: Border(
      borderStyle: BorderStyle.Medium,
    ),
    bottomBorder: Border(
      borderStyle: BorderStyle.Medium,
    ),
  );
  List<String> header = [
    "التاريخ",
    "رقم الاوردر",
    "اسم الصنف",
    "كود الصنف",
    "عدد ساعات التشغيل",
    "كود البويا",
    "بداية الوزن",
    "نهاية الوزن",
    "اجمالي الوزن",
    "كود الورنيش",
    "بداية الوزن",
    "نهاية الوزن",
    "اجمالي الوزن",
    "كمية الانتاج الفعلي",
    "هالك الرش",
    "هالك الحقن",
    "عدد العمال",
    "عدد الاسطوانات",
    "عدد الاسياخ للاسطوانه",
    "عدد القطع للسيخ",
    "كمية الانتاج المتوقع",
    "(جرام) وزن البويه المتوقعه",
    "نسبة هالك الرش",
    "نسبة هالك الحقن",
    "وقت توقف الرش(دقيقه)",
    "ملاحظات",
  ];
  for (int i = 0; i < 26; i++) {
    var cell22 =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell22.value = TextCellValue(header[i]);
    cell22.cellStyle = cellStyle;
    sheet.setColumnWidth(i, 34);
  }
  for (int i = 0; i < productions.length; i++) {
    sheet.setRowHeight(i, 35);
    sheet.setRowHeight(i + 1, 35);

    var cell =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 0));
    cell.value = TextCellValue(productions[i].date);
    cell.cellStyle = cellStyle;
    var cell15 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 1));
    cell15.value = TextCellValue(productions[i].ordernuber ?? "لا يوجد");
    cell15.cellStyle = cellStyle;

    var cell16 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 2));
    cell16.value = TextCellValue(productions[i].prodname);
    cell16.cellStyle = cellStyle;
    var cell1 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 3));
    cell1.value = TextCellValue(BlocProvider.of<paintcuibt>(context)
        .orderquantity[productions[i].ordernuber]["prodcode"]);
    cell1.cellStyle = cellStyle;
    var cell2 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 4));
    cell2.value = TextCellValue(productions[i].workhours);
    cell2.cellStyle = cellStyle;
    var cell3 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 5));
    cell3.value = TextCellValue(BlocProvider.of<paintcuibt>(context)
        .orderquantity[productions[i].ordernuber]["boyacode"]);
    cell3.cellStyle = cellStyle;
    var cell18 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 6));
    cell18.value = TextCellValue(productions[i].boyaweightstart ?? "لا بوجد");
    cell18.cellStyle = cellStyle;
    var cell4 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 7));
    cell4.value = TextCellValue(productions[i].boyaweightend);
    cell4.cellStyle = cellStyle;
    var cella4 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 8));
    cella4.value = TextCellValue((num.parse(productions[i].boyaweightend) -
            num.parse(productions[i].boyaweightstart))
        .round()
        .toString());
    cella4.cellStyle = cellStyle;
    cell3.value = TextCellValue(BlocProvider.of<paintcuibt>(context)
        .orderquantity[productions[i].ordernuber]["warnishcode"]);
    cell3.cellStyle = cellStyle;
    var cell118 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 9));
    cell118.value =
        TextCellValue(productions[i].warnishweightstart ?? "لا بوجد");
    cell118.cellStyle = cellStyle;
    var cell14 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 10));
    cell14.value = TextCellValue(productions[i].warnishweightend);
    cell14.cellStyle = cellStyle;
    var cel1la4 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 11));
    cel1la4.value = TextCellValue((num.parse(productions[i].warnishweightend) -
            num.parse(productions[i].warnishweightstart))
        .round()
        .toString());
    cel1la4.cellStyle = cellStyle;
    var cell6 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 12));
    cell6.value = TextCellValue(productions[i].actualprodquantity.toString());
    cell6.cellStyle = cellStyle;
    var cell9 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 13));
    cell9.value = TextCellValue(productions[i].scrappaintquantity.toString());
    cell9.cellStyle = cellStyle;
    var cell11 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 14));
    cell11.value = TextCellValue(productions[i].scrapinjquantity);
    cell11.cellStyle = cellStyle;
    var cell111 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 15));
    cell111.value = TextCellValue(productions[i].numberofworkers);
    cell111.cellStyle = cellStyle;
    var cell1111 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 16));
    cell1111.value = TextCellValue(productions[i].actualdiskes);
    cell1111.cellStyle = cellStyle;
    var cell11151 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 17));
    cell11151.value = TextCellValue(productions[i].numberofskewerintray);
    cell11151.cellStyle = cellStyle;
    var cell111512 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 18));
    cell111512.value = TextCellValue(productions[i].numberofpiecesinskewer);
    cell111512.cellStyle = cellStyle;
    var cell5 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 19));
    cell5.value = TextCellValue(
        ((double.parse(productions[i].workhours) * 60 * 60) /
                (BlocProvider.of<paintaverageCubit>(context)
                    .paintaveragerate[productions[i].prodname]))
            .round()
            .toString());
    cell5.cellStyle = cellStyle;

    var cell8 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 20));
    cell8.value = TextCellValue(((productions[i].actualprodquantity +
                productions[i].scrappaintquantity) *
            BlocProvider.of<paintaverageCubit>(context)
                .paintaveragerateweight[productions[i].prodname])
        .toStringAsFixed(1));
    cell8.cellStyle = cellStyle;

    var celdl8 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 21));
    celdl8.value = TextCellValue(
      ((productions[i].actualprodquantity + productions[i].scrappaintquantity) *
              BlocProvider.of<paintaverageCubit>(context)
                  .paintaveragerateweight[productions[i].prodname])
          .toStringAsFixed(1),
    );
    celdl8.cellStyle = cellStyle;

    var cell10 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 22));
    cell10.value = TextCellValue((double.parse(
                productions[i].scrappaintquantity.toString()) /
            (double.parse(productions[i].scrappaintquantity.toString()) +
                (double.parse(productions[i].actualprodquantity.toString()))) *
            100)
        .toStringAsFixed(2));
    cell10.cellStyle = cellStyle;

    var cell12 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 23));
    cell12.value = TextCellValue((double.parse(
                productions[i].scrapinjquantity.toString()) /
            (double.parse(productions[i].scrappaintquantity.toString()) +
                double.parse(productions[i].scrapinjquantity.toString()) +
                (double.parse(productions[i].actualprodquantity.toString()))) *
            100)
        .toStringAsFixed(2));
    cell12.cellStyle = cellStyle;
    var cell13 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 24));
    cell13.value = TextCellValue(
        (((double.parse(productions[i].workhours) * 60 * 60) /
                        (BlocProvider.of<paintaverageCubit>(context)
                            .paintaveragerate[productions[i].prodname]) -
                    productions[i].actualprodquantity) *
                (BlocProvider.of<paintaverageCubit>(context)
                        .paintaveragerate[productions[i].prodname] /
                    60))
            .toStringAsFixed(2));
    cell13.cellStyle = cellStyle;
    var cell154 = sheet
        .cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 25));
    cell154.value = TextCellValue(productions[i].notes);
    cell154.cellStyle = cellStyle;

    sheet.setColumnWidth(i, 26);
  }

  var directory = await getExternalStorageDirectory();
  final file = File('${directory!.path}/تفرير انتاج ${date}.xlsx');
  var fileBytes = excell.save();

  await file.writeAsBytes(fileBytes!);
  await Share.shareXFiles([XFile(file.path)]);
}
 /*for(int i=0;i<productions.length;i++){
  var cell= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 0));
 cell.value=TextCellValue(productions[i].date);
   cell.cellStyle = cellStyle;
  var cell1= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 1));
 cell1.value=TextCellValue(productions[i].machinenumber);
   cell1.cellStyle = cellStyle;
  var cell2= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 2));
 cell2.value=TextCellValue(productions[i].workername);
   cell2.cellStyle = cellStyle;
  var cell3= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 3));
 cell3.value=TextCellValue(productions[i].prodname);
   cell3.cellStyle = cellStyle;
  var cell4= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 4));
 cell4.value=TextCellValue(productions[i].cycletime);
   cell4.cellStyle = cellStyle;
  var cell5= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 5));
 cell5.value=TextCellValue(productions[i].numberofpieces);
   cell5.cellStyle = cellStyle;
  var cell6= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 6));
 cell6.value=TextCellValue(productions[i].workhours);
   cell6.cellStyle = cellStyle;
  var cell7= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 7));
 cell7.value=TextCellValue(productions[i].counterstart);
   cell7.cellStyle = cellStyle;
  var cell8= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 8));
 cell8.value=TextCellValue(productions[i].counterend);
   cell8.cellStyle = cellStyle;
  var cell9= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 9));
 cell9.value=TextCellValue(productions[i].realprodcountity);
   cell9.cellStyle = cellStyle;
  var cell10= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 10));
 cell10.value=TextCellValue(productions[i].scrapcountity);
   cell10.cellStyle = cellStyle;
  var cell11= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 11));
 cell11.value=TextCellValue(productions[i].expectedprod);
   cell11.cellStyle = cellStyle;
  var cell12= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 12));
 cell12.value=TextCellValue(productions[i].proddivision);
   cell12.cellStyle = cellStyle;
  var cell13= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 13));
 cell13.value=TextCellValue(productions[i].machinestop);
   cell13.cellStyle = cellStyle;
  var cell14= sheet.cell(CellIndex.indexByColumnRow(rowIndex: i, columnIndex: 14));
 cell14.value=TextCellValue(productions[i].notes);
   cell14.cellStyle = cellStyle;
  

  sheet.setColumnWidth(i, 18);
}  */