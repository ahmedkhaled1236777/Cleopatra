import 'dart:io';

import 'package:excel/excel.dart';
import 'package:cleopatra/features/collection1/injcollection/data/model/incollectionmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

shareinjcoexcell(
    {required String name,
    required List<injectioncomodel> categories,
    required Map<String, String> codes}) async {
  Excel excell = Excel.createExcel();
  Sheet sheet = excell[excell.getDefaultSheet()!];
  sheet.isRTL = false;
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
    "اسم العامل",
    "الكود",
    "الوظيفه",
    "رقم الاوردر",
    "الوقت من",
    "الوقت الى",
    "كمية الانتاج",
    "الملاحظات",
  ];
  for (int i = 0; i < 8; i++) {
    var cell22 =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
    cell22.value = TextCellValue(header[i]);
    cell22.cellStyle = cellStyle;

    sheet.setColumnWidth(i, 70);
  }

  for (int i = 0; i < categories.length; i++) {
    sheet.setRowHeight(i, 50);
    sheet.setRowHeight(i + 1, 50);

    var cell =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 0));
    cell.value = TextCellValue(categories[i].workername);
    cell.cellStyle = cellStyle;
    var cell18 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 1));
    cell18.value = TextCellValue(codes[categories[i].workername]!);
    cell18.cellStyle = cellStyle;
    var cell15 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 2));
    cell15.value = TextCellValue(categories[i].job);
    cell15.cellStyle = cellStyle;

    var cell16 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 3));
    cell16.value = TextCellValue(categories[i].ordernumber ?? "لا يوجد");
    cell16.cellStyle = cellStyle;
    var cell1 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 4));
    cell1.value = TextCellValue(categories[i].timefrom ?? "لا يوجد");
    cell1.cellStyle = cellStyle;
    var cell2 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 5));
    cell2.value = TextCellValue(categories[i].timeto ?? "لا يوجد");
    cell2.cellStyle = cellStyle;
    var cell3 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 6));
    cell3.value = TextCellValue(categories[i].productionquantity.toString());
    cell3.cellStyle = cellStyle;

    var cell4 =
        sheet.cell(CellIndex.indexByColumnRow(rowIndex: i + 1, columnIndex: 7));
    cell4.value = TextCellValue(categories[i].notes);
    cell4.cellStyle = cellStyle;

    sheet.setColumnWidth(i, 40);
  }

  var directory = await getExternalStorageDirectory();
  final file = File('${directory!.path}/تفرير تجميع الحقن ${name}.xlsx');
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