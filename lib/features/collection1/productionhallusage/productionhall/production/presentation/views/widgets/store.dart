import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/models/productionmodel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class Storepdf {
  static Future<File> generatepdf({
    required BuildContext context,
    required String name,
    required String date,
    required String orderquantity,
    required String totalproduced,
    required String ordernumber,
    required Uint8List imageBytes,
    required List<productionusagemodel> categories,
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
        item.quantity,
        item.date,
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
        buildbasic("${date}", name, ordernumber),
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
                  pw.Text("قسم التجميع",
                      style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColors.blue900,
                          fontBold: pw.Font.courier())),
                ])),
        pw.Table.fromTextArray(
            headerDecoration: pw.BoxDecoration(color: PdfColors.blue900),
            headerHeight: 10,
            cellHeight: 10,
            columnWidths: {
              0: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
              1: pw.FixedColumnWidth(PdfPageFormat.cm * 3),
            },
            cellAlignment: pw.Alignment.center,
            headerAlignment: pw.Alignment.center,
            headerAlignments: {
              0: pw.Alignment.center,
              1: pw.Alignment.center,
            },
            headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontBold: pw.Font.courierBold(),
                fontSize: 14),
            headers: [
              "الكميه",
              "التاريخ",
            ],
            data: data),
        pw.Container(
            width: PdfPageFormat.cm * 50,
            child: pw.Row(children: [
              pw.Container(
                  width: PdfPageFormat.cm * 10.075,
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Text("اجمالى الكميه المنتجه",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(color: PdfColor.fromInt(0xff2d328d))),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.black)))),
              pw.Expanded(
                child: pw.Text(totalproduced,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColor.fromInt(0xff2d328d))),
              )
            ]),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                    top: pw.BorderSide(color: PdfColors.black),
                    right: pw.BorderSide(color: PdfColors.black),
                    left: pw.BorderSide(color: PdfColors.black)))),
        pw.Container(
            width: PdfPageFormat.cm * 50,
            child: pw.Row(children: [
              pw.Container(
                  width: PdfPageFormat.cm * 10.075,
                  child: pw.Text("المتبقي من الاوردر",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(color: PdfColor.fromInt(0xff2d328d))),
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          left: pw.BorderSide(color: PdfColors.black)))),
              pw.Expanded(
                child: pw.Text(
                    "${int.parse(orderquantity) - int.parse(totalproduced)}",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColor.fromInt(0xff2d328d))),
              )
            ]),
            decoration: pw.BoxDecoration(
                border: pw.Border(
                    bottom: pw.BorderSide(color: PdfColors.black),
                    top: pw.BorderSide(color: PdfColors.black),
                    right: pw.BorderSide(color: PdfColors.black),
                    left: pw.BorderSide(color: PdfColors.black)))),
      ],
    ));

    return await savepdf(" متابعة اوردر رقم ${name}", pdf);
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

  static buildbasic(String date, String name, String ordernumber) {
    return pw.Column(children: [
      pw.Row(children: [
        pw.Text("اسم المنتج",
            style: pw.TextStyle(
                decoration: pw.TextDecoration.underline, fontSize: 17)),
        pw.Text("  :  "),
        pw.Text(name, style: pw.TextStyle(fontSize: 17))
      ]),
      pw.SizedBox(height: 5),
      pw.Row(children: [
        pw.Text("رقم الاوردر", style: pw.TextStyle(fontSize: 17)),
        pw.Text("  :  "),
        pw.Text(ordernumber, style: pw.TextStyle(fontSize: 17))
      ]),
      pw.SizedBox(height: 5),
      pw.Row(children: [
        pw.Text("تاريخ بداية الاوردر", style: pw.TextStyle(fontSize: 17)),
        pw.Text("  :  "),
        pw.Text(date, style: pw.TextStyle(fontSize: 17))
      ]),
      pw.SizedBox(height: 5),
    ]); /*
   
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
     pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
      pw.Text(m[0].engineer),
            pw.Text(" : "),

            pw.Text("اسم المهندس")   ,

        ]) ,  
     pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,

      children: [
      pw.Text(m[0].shift),
      pw.Text(" : "),
            pw.Text("الورديه")   ,

        ]) ,  
     pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,

      children: [
      pw.Text(m[0].date),
            pw.Text(" : "),

            pw.Text("التاريخ")   ,

        ]) ,  
      
           ]);*/
  }
}
