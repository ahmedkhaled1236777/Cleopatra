import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/addmold.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/widgets/alertmoldcontent.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/widgets/customtablemolditem.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/widgets/molditem.dart';

class molds extends StatefulWidget {
  @override
  State<molds> createState() => _moldsState();
}

class _moldsState extends State<molds> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final moldsheader = [
    "التاريخ",
    "اسم الاسطمبه",
    "الوقت",
    "الحاله",
    "حذف",
  ];

  getdata() async {
    if (BlocProvider.of<MoldsCubit>(context).mymolds.isEmpty)
      await BlocProvider.of<MoldsCubit>(context).getmolds();
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (!permession.contains('اضافة اسطمبات')) {
                    showdialogerror(
                        error: "ليس لديك الصلاحيه", context: context);
                  } else
                    navigateto(context: context, page: Addmold());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<MoldsCubit>(context).resetsearch();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
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
                              content: Alertmoldcontent(),
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
                "الاسطمبات",
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
                    children: moldsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تحديد" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<MoldsCubit, MoldsState>(
                    listener: (context, state) {
                  if (state is getmoldfailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getmoldloading) return loadingshimmer();
                  if (state is getmoldfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<MoldsCubit>(context).mymolds.isEmpty)
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
                                          content: molditem(
                                            mold: BlocProvider.of<MoldsCubit>(
                                                    context)
                                                .mymolds[i],
                                          ),
                                        );
                                      });
                                },
                                child: customtablemolditem(
                                    time: BlocProvider.of<MoldsCubit>(context)
                                        .mymolds[i]
                                        .time,
                                    moldname:
                                        BlocProvider.of<MoldsCubit>(context)
                                            .mymolds[i]
                                            .moldname,
                                    date: BlocProvider.of<MoldsCubit>(context)
                                        .mymolds[i]
                                        .date,
                                    status: BlocProvider.of<MoldsCubit>(context)
                                        .mymolds[i]
                                        .status,
                                    delet: IconButton(
                                        onPressed: () {
                                          if (!permession
                                              .contains('حذف اسطمبات'))
                                            showdialogerror(
                                                error: "ليس لديك الصلاحيه",
                                                context: context);
                                          else
                                            awsomdialogerror(
                                                context: context,
                                                mywidget: BlocConsumer<
                                                    MoldsCubit, MoldsState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is deletemoldsuccess) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .success_message,
                                                          toaststate: Toaststate
                                                              .succes);
                                                    }
                                                    if (state
                                                        is deletemoldfailure) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .error_message,
                                                          toaststate:
                                                              Toaststate.error);
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    if (state
                                                        is deletemoldloading)
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
                                                                    .of<MoldsCubit>(
                                                                        context)
                                                                .deltemold(
                                                                    docid:
                                                                        "${BlocProvider.of<MoldsCubit>(context).mymolds[i].date}-${BlocProvider.of<MoldsCubit>(context).mymolds[i].moldname}-${BlocProvider.of<MoldsCubit>(context).mymolds[i].status}-${BlocProvider.of<MoldsCubit>(context).mymolds[i].machinenumber}");
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
                                                    "هل تريد حذف تقرير اسطمبة ${BlocProvider.of<MoldsCubit>(context).mymolds[i].moldname}");
                                        },
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        ))),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<MoldsCubit>(context)
                              .mymolds
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
