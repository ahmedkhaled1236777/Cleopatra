import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cleopatra/features/paints/paint/data/models/paintreportmodel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class paintreportpdf {
  static Future<File> generatepdf({
    required BuildContext context,
    required Uint8List imageBytes,
    required List<paintreportmodel> categories,
  }) async {
    final pdf = pw.Document();
    final theme = pw.ThemeData.withFont(
      base: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
      bold: Font.ttf(await rootBundle
          .load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf')),
    );
    final data = categories.map((item) {
      return [
        (num.parse(item.boyaweightend) - num.parse(item.boyaweightstart)),
        " ${(double.parse(item.scrapinjquantity) / (item.actualprodquantity + item.scrappaintquantity + double.parse(item.scrapinjquantity)) * 100).toStringAsFixed(2)} %",
        item.scrapinjquantity,
        "${((item.scrappaintquantity / (item.actualprodquantity + item.scrappaintquantity)) * 100).toStringAsFixed(2)} %",
        item.scrappaintquantity,
        item.actualprodquantity,
        item.ordernuber,
        item.prodname,
      ];
    }).toList();
    //دائن

    //مدين

    pdf.addPage(pw.MultiPage(
      theme: theme,
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(12),
      textDirection: TextDirection.rtl,
      build: (context) => [
        pw.Container(
          alignment: pw.Alignment.center,
          height: 100,
          child: pw.Image(pw.MemoryImage(imageBytes)),
        ),
        pw.SizedBox(height: 10),
        pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.symmetric(vertical: 5),
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(" تقرير رش  ${categories[0].date}",
                      style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.blue900,
                          fontBold: pw.Font.courier())),
                  pw.SizedBox(height: 10),
                ])),
        pw.Table.fromTextArray(
            headerDecoration: pw.BoxDecoration(color: PdfColors.blue900),
            headerHeight: 10,
            cellHeight: 10,
            columnWidths: {
              0: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              1: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              2: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              3: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              4: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              5: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              6: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              7: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
            },
            cellAlignment: pw.Alignment.center,
            headerAlignment: pw.Alignment.center,
            headerAlignments: {
              0: pw.Alignment.center,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
              3: pw.Alignment.center,
              4: pw.Alignment.center,
              5: pw.Alignment.center,
              6: pw.Alignment.center,
              7: pw.Alignment.center,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontBold: pw.Font.courierBold(),
                fontSize: 14),
            headers: [
              "وزن البويه (جرام)",
              "نشبة هالك الحقن ",
              "كمية هالك الحقن ",
              "نسبة هالك الرش",
              "كمية هالك الرش",
              "كمية الانتاج",
              "رقم الاوردر",
              "اسم المنتج",
            ],
            data: data),
      ],
    ));

    return await savepdf("تقرير رش  ${categories[0].date}", pdf);
  }

  static Future<File> savepdf(String filename, pw.Document pdf) async {
    final bytes = await pdf.save();
    var dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$filename.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openfile(File file) async {
    final url = file.path;
    return await OpenFile.open(url);
  }

  /* static buildtable(
      {required List<Datum> categories,
      required String daen,
      required String maden,
      required String name}) {
    final data = categories.map((item) {
      return [
        item.type=="maintenance"?item.price:"",
        item.type=="maintenance"?"":item.price,
        item.description,
        item.date,
      ];
    }).toList();
    final mdata = [
      {
        "date": "اجمالى الرصيد والحركه",
        "maden":
            "${int.parse(maden) > int.parse(daen) ? int.parse(maden) - int.parse(daen) : 0}",
        "daen":
            "${int.parse(daen) > int.parse(maden) ? int.parse(daen) - int.parse(maden) : 0}"
      }
    ].map((item) {
      return [
        item["daen"],
        item["maden"],
        item["date"],
      ];
    }).toList();

    return pw.Column(children: [
      pw.Container(
          width: double.infinity,
          padding: pw.EdgeInsets.symmetric(vertical: 5),
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child:
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Text("كشف حساب السيد / ",
                style: pw.TextStyle(
                    fontSize: 15,
                    color: PdfColors.deepPurple600,
                    fontBold: pw.Font.courierBold())),
            pw.Text("${name}",
                style: pw.TextStyle(
                    fontSize: 15,
                    color: PdfColors.red500,
                    fontBold: pw.Font.courier())),
          ])),
      pw.Table.fromTextArray(
          headerDecoration: pw.BoxDecoration(color: PdfColors.amber400),
          headerHeight: 10,
          cellHeight: 10,
          columnWidths: {
            0: pw.FixedColumnWidth(PdfPageFormat.cm * 1.5),
            1: pw.FixedColumnWidth(PdfPageFormat.cm * 1.5),
            2: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
            3: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
          },
          cellAlignment: pw.Alignment.center,
          headerAlignment: pw.Alignment.center,
          headerAlignments: {
            0:pw.Alignment.center,
            1:pw.Alignment.center,
            2:pw.Alignment.center,
            3:pw.Alignment.center,
          },
          headerStyle: pw.TextStyle(
            
              color: PdfColors.black,
              fontBold: pw.Font.courierBold(),
              fontSize: 14),
          headers: [
            "تكلفة الصيانه",
            "المبلغ المدفوع",
            "البيان",
            "التاريخ",
          ],
          data: data),
      pw.Container(
          color: PdfColors.deepOrange400,
          child: pw.Table.fromTextArray(
          
              cellStyle: pw.TextStyle(color: PdfColors.white),
              headerStyle: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 17,
                  fontBold: pw.Font.courierBold()),
              cellHeight: 10,
              columnWidths: {
                0: pw.FixedColumnWidth(PdfPageFormat.cm * 1.5),
                1: pw.FixedColumnWidth(PdfPageFormat.cm * 1.5),
                2: pw.FixedColumnWidth(PdfPageFormat.cm * 6),
              },
              cellAlignment: pw.Alignment.center,
              data: mdata))
    ]);

    /* final data=[].map((item){
return[
item.production,
item.job,
item.worker
];
}).toList();
    return  pw.Table.fromTextArray(
      
      headerDecoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey500),
        color: PdfColors.grey500

      ),
      headerHeight: 10,
      cellHeight: 10,border: pw.TableBorder.all(color: PdfColors.grey500),
      
      columnWidths: {0:pw.FixedColumnWidth(PdfPageFormat.cm*3),
      1:pw.FixedColumnWidth(PdfPageFormat.cm*3),
      2:pw.FixedColumnWidth(PdfPageFormat.cm*3),
      
      
      
      },
          cellAlignment: pw.Alignment.center,
          headerAlignment: pw.Alignment.center,
          headerStyle: pw.TextStyle(color: PdfColors.white),

          headers: [
               "دائن",

                   "مدين",

              "البيان",

               "التاريخ",

          
          ],
          data:data);*/
  }*/
}
