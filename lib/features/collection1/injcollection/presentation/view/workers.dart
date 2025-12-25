
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/injcollection/presentation/viewmodel/cubit/injextionco_dart_cubit.dart';

class injectionco extends StatefulWidget {
  @override
  State<injectionco> createState() => _injectioncoState();
}

class _injectioncoState extends State<injectionco> {
  final injectioncoheader = [
    "التاريخ",
    "اسم العامل",
    "نوع\nالتجميع",
    "الوظيفه",
    "النسبه",
  ];

  getdata() async {
   
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
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                   
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "التقرير اليومي",
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
                    children: injectioncoheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child:
                      BlocConsumer<InjextioncoDartCubit, InjextioncoDartState>(
                          listener: (context, state) {
                if (state is getinjectioncofailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error);
              }, builder: (context, state) {
                if (state is getinjectioncoloading) return loadingshimmer();
                if (state is getinjectioncofailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<InjextioncoDartCubit>(context)
                      .injectionsco
                      .isEmpty)
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
                                        content: injectioncoitem(
                                          injectioncos: BlocProvider.of<
                                                  InjextioncoDartCubit>(context)
                                              .injectionsco[i],
                                        ),
                                      );
                                    });
                              },
                              child: customtableinjectioncositem(
                                  edit: IconButton(
                                      onPressed: () {}, icon: Icon(editeicon)),
                                  worker: BlocProvider.of<InjextioncoDartCubit>(
                                          context)
                                      .injectionsco[i]
                                      .workername,
                                  job: BlocProvider.of<InjextioncoDartCubit>(
                                          context)
                                      .injectionsco[i]
                                      .job,
                                  status: BlocProvider.of<InjextioncoDartCubit>(
                                          context)
                                      .injectionsco[i]
                                      .status,
                                  date: BlocProvider.of<InjextioncoDartCubit>(
                                          context)
                                      .injectionsco[i]
                                      .date,
                                  delet: IconButton(
                                      onPressed: () {
                                        if (cashhelper.getdata(key: "email") !=
                                            "ahmedaaallam123@gmail.com")
                                          showdialogerror(
                                              error:
                                                  "ليس لديك الصلاحيه لحذف التقرير",
                                              context: context);
                                        else
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  InjextioncoDartCubit,
                                                  InjextioncoDartState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deleteinjectioncosuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                          context: context, message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes);
                                                  }
                                                  if (state
                                                      is deleteinjectioncofailure) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                          context: context, message:
                                                            state.errormessage,
                                                        toaststate:
                                                            Toaststate.error);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is deleteinjectioncoloading)
                                                    return deleteloading();
                                                  return SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                        ),
                                                        onPressed: () async {
                                                          await BlocProvider.of<
                                                                      InjextioncoDartCubit>(
                                                                  context)
                                                              .deleteproduction(
                                                                  prduction: BlocProvider.of<
                                                                              InjextioncoDartCubit>(
                                                                          context)
                                                                      .injectionsco[i]);
                                                        },
                                                        child: const Text(
                                                          "تاكيد",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "cairo",
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  );
                                                },
                                              ),
                                              tittle:
                                                  "هل تريد حذف تقرير البيان ");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount:
                            BlocProvider.of<InjextioncoDartCubit>(context)
                                .injectionsco
                                .length);
                  }
                }
              })),
              if (MediaQuery.sizeOf(context).width < 600)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () async {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await Injcopdf.generatepdf(
                              name:
                                  "${BlocProvider.of<InjextioncoDartCubit>(context).injectionsco[0].date}",
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<InjextioncoDartCubit>(context)
                                      .injectionsco);
                          await Injcopdf.openfile(file);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {
                          final img = await rootBundle
                              .load('assets/images/cleopatra-modified.png');
                          final imageBytes = img.buffer.asUint8List();
                          File file = await Injcopdf.generatepdf(
                              name:
                                  "${BlocProvider.of<InjextioncoDartCubit>(context).injectionsco[0].date}",
                              imageBytes: imageBytes,
                              categories:
                                  BlocProvider.of<InjextioncoDartCubit>(context)
                                      .injectionsco);
                          Share.shareXFiles([XFile(file.path)]);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          print(cashhelper.getdata(key: "email"));
                          if (cashhelper.getdata(key: "email") !=
                                  "ahmedaaallam123@gmail.com" &&
                              cashhelper.getdata(key: "email") !=
                                  "mohamed@gmail.com")
                            showdialogerror(
                                error: "ليس لديك صلاحية اضافة التقارير",
                                context: context);
                          else
                            navigateto(
                                context: context, page: addinjectionco());
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )
            ])));
  }
}*/ 
