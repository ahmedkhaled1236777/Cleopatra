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
import 'package:cleopatra/features/paints/paintaverage/presentation/view/addpaintaverage.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/view/widgets/customtableaverageitem.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/view/widgets/editdialog.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_cubit.dart';
import 'package:cleopatra/features/paints/paintaverage/presentation/viewmodel/cubit/paintaverage_state.dart';

class paintaverage extends StatefulWidget {
  @override
  State<paintaverage> createState() => _paintaverageState();
}

class _paintaverageState extends State<paintaverage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final scrapsheader = [
    "الوظيفه",
    "معدل القطعه بالثواني",
    "وزن البويه للقطعه",
    "تحديد",
    "تعديل",
    "حذف"
  ];

  getdata() async {
    await BlocProvider.of<paintaverageCubit>(context).getpaintaverages();
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
                    onPressed: () async {}),
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
                      if (!permession.contains('اضافة ازمنة الرش'))
                        showdialogerror(
                            error: "ليس لديك الصلاحيه", context: context);
                      else
                        navigateto(context: context, page: Addpaintaverage());
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
                child: BlocConsumer<paintaverageCubit, paintaverageState>(
                    listener: (context, state) {
                  if (state is GetpaintaverageFailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.errormessage,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is GetpaintaverageLoading) return loadingshimmer();
                  if (state is GetpaintaverageFailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<paintaverageCubit>(context)
                        .paintaverages
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) =>
                              Customtablepaintaverageitem(
                                boyaweight:
                                    BlocProvider.of<paintaverageCubit>(context)
                                        .paintaverages[i]
                                        .boyaweight,
                                job: BlocProvider.of<paintaverageCubit>(context)
                                    .paintaverages[i]
                                    .job,
                                rate:
                                    BlocProvider.of<paintaverageCubit>(context)
                                        .paintaverages[i]
                                        .secondsperpiece,
                                edit: IconButton(
                                    onPressed: () {
                                      if (!permession
                                          .contains('تعديل ازمنة الرش'))
                                        showdialogerror(
                                            error: "ليس لديك الصلاحيه",
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
                                                  content:
                                                      editpaintaverageedialog(
                                                    boyaweight: TextEditingController(
                                                        text: (BlocProvider.of<
                                                                        paintaverageCubit>(
                                                                    context)
                                                                .paintaverages[
                                                                    i]
                                                                .boyaweight)
                                                            .toString()),
                                                    paintaverage: BlocProvider
                                                            .of<paintaverageCubit>(
                                                                context)
                                                        .paintaverages[i],
                                                    job: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    paintaverageCubit>(
                                                                context)
                                                            .paintaverages[i]
                                                            .job),
                                                    rate: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    paintaverageCubit>(
                                                                context)
                                                            .paintaverages[i]
                                                            .secondsperpiece
                                                            .toString()),
                                                  ));
                                            });
                                    },
                                    icon: Icon(editeicon)),
                                delete: IconButton(
                                    onPressed: () {
                                      if (!permession
                                          .contains('حذف ازمنة الرش'))
                                        showdialogerror(
                                            error: "ليس لديك الصلاحيه",
                                            context: context);
                                      else
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                paintaverageCubit,
                                                paintaverageState>(
                                              listener: (context, state) {
                                                if (state
                                                    is Deletepaintaveragefailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,
                                                                      
                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                                if (state
                                                    is DeletepaintaverageSuccess) {
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
                                                    is Deletepaintaverageloading)
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
                                                                    paintaverageCubit>(
                                                                context)
                                                            .deletepaintaverage(
                                                                paintaverage: BlocProvider.of<
                                                                            paintaverageCubit>(
                                                                        context)
                                                                    .paintaverages[i]);
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
                                                "هل تريد حذف معدل ${BlocProvider.of<paintaverageCubit>(context).paintaverages[i].job}");
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    )),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<paintaverageCubit>(context)
                              .paintaverages
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
