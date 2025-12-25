import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/moldcyclespdf.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/qc/presentation/view/addqc.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/alertcontent.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/customtableqcitem.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/editqc.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/mobilescanner.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/qcitem.dart';
import 'package:cleopatra/features/qc/presentation/view/widgets/qcpdf.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_cubit.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_state.dart';
import 'package:share_plus/share_plus.dart';




class qc extends StatefulWidget {
  @override
  State<qc> createState() => _qcState();
}

class _qcState extends State<qc> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final qcheader = [
     "التاريخ",
     "وقت الفحص",
    "اسم المنتج",
    "تعديل",
    "حذف",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: appcolors.primarycolor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
            
                navigateto(context: context, page: Qcscanner());
            }),
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
             IconButton(
                    onPressed: () async {
                      final img = await rootBundle
                          .load('assets/images/cleopatra-modified.png');
                      final imageBytes = img.buffer.asUint8List();
                      File file = await Qcpdf.generatepdf(
                          context: context,
                          imageBytes: imageBytes,
                          qcs:
                              BlocProvider.of<qcsCubit>(context).qcs);
                      Share.shareXFiles([XFile(file.path)]);
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
            IconButton(
                onPressed: () {
 BlocProvider.of<MoldsCubit>(
                                      context,
                                    ).resetmold();
                                              BlocProvider.of<DateCubit>(context).cleardates();
                   showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Container(
                                height: 20,
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<DateCubit>(context)
                                          .cleardates();

                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: appcolors.maincolor,
                                    )),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.all(35),
                              content: Alertqccontent(),
                            );
                          });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
         
          ],
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "تقارير الجوده",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(children: [
          Container(
            height: 50,
            color: appcolors.maincolor.withOpacity(0.7),
            child: Row(
                children: qcheader
                    .map((e) => customheadertable(
                          title: e,
                          flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                        ))
                    .toList()),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {},
            child: BlocConsumer<qcsCubit, qcsState>(
                listener: (context, state) {
              if (state is getqcfailure)
                showtoast(
                                                                                                    context: context,

                    message: state.error_message,
                    toaststate: Toaststate.error);
            }, builder: (context, state) {
              if (state is getqcloading) return loadingshimmer();
              if (state is getqcfailure)
                return SizedBox();
              else {
                if (BlocProvider.of<qcsCubit>(context).qcs.isEmpty)
                  return nodata();
                else {
                  return ListView.separated(
                      itemBuilder: (context, i) => InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Container(
                                        height: 20,
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: appcolors.maincolor,
                                            )),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      content: qcitem(
                                        qc: BlocProvider.of<qcsCubit>(
                                                context)
                                            .qcs[i],
                                      ),
                                    );
                                  });
                            },
                            child: customtableqcitem(
                              date:  BlocProvider.of<qcsCubit>(
                                                context)
                                            .qcs[i].date,
                              prodname: BlocProvider.of<qcsCubit>(
                                                context)
                                            .qcs[i].productname ,
                              time:  BlocProvider.of<qcsCubit>(
                                                context)
                                            .qcs[i].checktime,
                               edit: IconButton(
                                onPressed: () {
                              var start = DateTime.now();
                                      var end = DateTime.now();
                                      if (BlocProvider.of<qcsCubit>(
                                                      context)
                                                  .qcs[i]
                                                  .endtime !=
                                              "لا يوجد" &&
                                          BlocProvider.of<qcsCubit>(
                                                      context)
                                                  .qcs[i]
                                                  .starttime !=
                                              "لا يوجد") {
                                        BlocProvider.of<DateCubit>(context)
                                                .timeto =
                                            BlocProvider.of<qcsCubit>(
                                                    context)
                                                .qcs[i]
                                                .endtime!;
                                        BlocProvider.of<DateCubit>(context)
                                                .timefrom =
                                            BlocProvider.of<qcsCubit>(
                                                    context)
                                                .qcs[i]
                                                .starttime;
                                        var format = DateFormat("HH:mm");
                                        start = format.parse(
                                            BlocProvider.of<DateCubit>(context)
                                                .timefrom);
                                        end = format.parse(
                                            BlocProvider.of<DateCubit>(
                                                    context)
                                                
                                                .timeto);
                                      }
                                  
       BlocProvider.of<productioncuibt>(context)
                                                        .selecteditems=  BlocProvider.of<qcsCubit>(
                                                context)
                                            .qcs[i].cause;   
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Container(
                                                height: 20,
                                                alignment:
                                                    Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: appcolors
                                                          .maincolor,
                                                    )),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              backgroundColor: Colors.white,
                                              insetPadding:
                                                  EdgeInsets.all(35),
                                              content: editqcdialog(
                                                notes:TextEditingController(text:  BlocProvider.of<
                                                            qcsCubit>(
                                                        context)
                                                    .qcs[i].notes),
                                              qc: BlocProvider.of<
                                                            qcsCubit>(
                                                        context)
                                                    .qcs[i],
                                                endtime:
                                                  end,
                                                starttime:
                                                  start,
                                              
                                              ));
                                        });
                                  
                                },
                                icon: Icon(editeicon)),
                              
                              
                                delet: IconButton(
                                    onPressed: () {
                                    
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                qcsCubit, qcsState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deleteqcsuccess) {
                                                  Navigator.pop(context);
    
                                                  showtoast(
                                                                                                                                      context: context,

                                                      message: state
                                                          .success_message,
                                                      toaststate: Toaststate
                                                          .succes);
                                                }
                                                if (state
                                                    is deleteqcfailure) {
                                                  Navigator.pop(context);
    
                                                  showtoast(
                                                                                                                                      context: context,

                                                      message: state
                                                          .error_message,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is deleteqcloading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style:
                                                          const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider
                                                                .of<qcsCubit>(
                                                                    context)
                                                            .deleteqcs(
                                                                qc:
                                                                   BlocProvider.of<qcsCubit>(context).qcs[i]);
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "cairo",
                                                            color: Colors
                                                                .white),
                                                        textAlign: TextAlign
                                                            .center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle:
                                                "هل تريد حذف التقرير ماكينه ${BlocProvider.of<qcsCubit>(context).qcs[i].machinenumber}");
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    ))),
                          ),
                      separatorBuilder: (context, i) => Divider(
                            color: Colors.grey,
                          ),
                      itemCount: BlocProvider.of<qcsCubit>(context)
                          .qcs
                          .length);
                }
              }
            }),
          )),
        ]));
  }
}
