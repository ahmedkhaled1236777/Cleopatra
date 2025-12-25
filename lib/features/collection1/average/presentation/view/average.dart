import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/addaverage.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/customtableaverageitem.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/editdialog.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/widgets/sharedialog.dart';
import 'package:cleopatra/features/collection1/average/presentation/viewmodel/cubit/average_cubit.dart';

class Average extends StatefulWidget {
  @override
  State<Average> createState() => _AverageState();
}

class _AverageState extends State<Average> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final scrapsheader = [
    "الوظيفه",
    "معدل القطعه بالثواني",
    "تحديد",
    "تعديل",
    "حذف"
  ];

  getdata() async {
    await BlocProvider.of<AverageCubit>(context).getaverages();
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                    heroTag: "",
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: appcolors.maincolor,
                    ),
                    backgroundColor: appcolors.primarycolor,
                    onPressed: () async {
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
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: appcolors.maincolor,
                                      )),
                                ),
                                contentPadding: EdgeInsets.all(10),
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.all(35),
                                content: Sharedialog());
                          });
                    }),
                SizedBox(
                  width: 7,
                ),
                FloatingActionButton(
                    heroTag: "ss",
                    backgroundColor: appcolors.primarycolor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (permession.contains('اضافة معدلات العمال'))
                        navigateto(context: context, page: Addaverage());
                      else {
                        showdialogerror(
                            error: "ليس لديك صلاحية الدخول للصفحه",
                            context: context);
                      }
                    }),
              ],
            ),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "المعدلات",
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
                    children: scrapsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" || e == "تحديد"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<AverageCubit, AverageState>(
                    listener: (context, state) {
                  if (state is GetAverageFailure)
                    showtoast(
                                                context: context,

                        message: state.errormessage,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is GetAverageLoading) return loadingshimmer();
                  if (state is GetAverageFailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<AverageCubit>(context).averages.isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => Customtableaverageitem(
                                checkbox: Checkbox(
                                    value:
                                        BlocProvider.of<AverageCubit>(context)
                                            .checks[i],
                                    onChanged: (val) {
                                      BlocProvider.of<AverageCubit>(context)
                                          .changechecbox(
                                              val: val!,
                                              index: i,
                                              average:
                                                  BlocProvider.of<AverageCubit>(
                                                          context)
                                                      .averages[i]);
                                    }),
                                job: BlocProvider.of<AverageCubit>(context)
                                    .averages[i]
                                    .job,
                                rate: BlocProvider.of<AverageCubit>(context)
                                    .averages[i]
                                    .secondsperpiece,
                                edit: IconButton(
                                    onPressed: () {
                                      if (permession
                                          .contains('تعديل معدلات العمال'))
                                        showdialogerror(
                                            error:
                                                "ليس لديك الصلاحيه لتعديل المعدل",
                                            context: context);
                                      else
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
                                                  content: editaverageedialog(
                                                    prieceofpiece:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<AverageCubit>(
                                                                        context)
                                                                .averages[i]
                                                                .prieceofpiece),
                                                    average: BlocProvider.of<
                                                                AverageCubit>(
                                                            context)
                                                        .averages[i],
                                                    job: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    AverageCubit>(
                                                                context)
                                                            .averages[i]
                                                            .job),
                                                    rate: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    AverageCubit>(
                                                                context)
                                                            .averages[i]
                                                            .secondsperpiece
                                                            .toString()),
                                                  ));
                                            });
                                    },
                                    icon: Icon(editeicon)),
                                delete: IconButton(
                                    onPressed: () {
                                      if (permession
                                          .contains('حذف معدلات العمال'))
                                        showdialogerror(
                                            error:
                                                "ليس لديك الصلاحيه لحذف التقرير",
                                            context: context);
                                      else
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<AverageCubit,
                                                AverageState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteAveragefailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                    context: context,
                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                                if (state
                                                    is DeleteAverageSuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                        context: context,

                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DeleteAverageloading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    AverageCubit>(
                                                                context)
                                                            .deleteaverage(
                                                                average: BlocProvider.of<
                                                                            AverageCubit>(
                                                                        context)
                                                                    .averages[i]);
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: "cairo",
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle:
                                                "هل تريد حذف معدل ${BlocProvider.of<AverageCubit>(context).averages[i].job}");
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    )),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<AverageCubit>(context)
                              .averages
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
