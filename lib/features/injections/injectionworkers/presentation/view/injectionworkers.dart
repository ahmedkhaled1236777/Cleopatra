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
import 'package:cleopatra/features/injections/injectionworkers/presentation/view/addinjectionworker.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/view/widgets/customtabeinjectionworkeritem.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/view/widgets/editworker.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/view/widgets/workeritem.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_cubit.dart';
import 'package:cleopatra/features/injections/injectionworkers/presentation/viewmodel/cubit/injectionworkers_state.dart';



class injectionworkers extends StatefulWidget {
  @override
  State<injectionworkers> createState() => _injectionworkersState();
}

class _injectionworkersState extends State<injectionworkers> {
 

  final injectionworkersheader = [
    "اسم العامل",
    "رقم الهاتف",
    "عدد ساعات العمل",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    if (BlocProvider.of<InjectionworkersCubit>(context).injectionworkers.isEmpty)
      await BlocProvider.of<InjectionworkersCubit>(context).getinjectionworkers();
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
                
                    navigateto(context: context, page: Addinjectionworker());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<InjectionworkersCubit>(context).getinjectionworkers();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
             
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "عمال الحقن",
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
                    children: injectionworkersheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ||e=="عدد ساعات العمل"? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<InjectionworkersCubit, InjectionworkersState>(
                    listener: (context, state) {
                  if (state is getInjectionworkerfailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getInjectionworkerloading) return loadingshimmer();
                  if (state is getInjectionworkerfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<InjectionworkersCubit>(context).injectionworkers.isEmpty)
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
                                          content: injectionworkeritem(
                                            injectionworkermodel: BlocProvider.of<InjectionworkersCubit>(
                                                    context)
                                                .injectionworkers[i],
                                          ),
                                        );
                                      });
                                },
                                child: customtableinjectionworkeritem(
                                  workerhours:  BlocProvider.of<
                                                                InjectionworkersCubit>(
                                                            context)
                                                        .injectionworkers[i].workerhours.toString(),
                                   edit: IconButton(
                                    onPressed: () {
                                   

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
                                                  content: editworkerdialog(
                                                    workername: BlocProvider.of<
                                                                InjectionworkersCubit>(
                                                            context)
                                                        .injectionworkers[i].workername,
                                                    workernumber:
                                                   TextEditingController(text:     BlocProvider.of<
                                                                InjectionworkersCubit>(
                                                            context)
                                                        .injectionworkers[i].workernumber),
                                                    workersalary:
                                                        TextEditingController(
                                                            text: BlocProvider.of<
                                                                InjectionworkersCubit>(
                                                            context)
                                                        .injectionworkers[i].workersalary.toString()),
                                                    workhours:
                                                        TextEditingController(
                                                            text: BlocProvider.of<
                                                                InjectionworkersCubit>(
                                                            context)
                                                        .injectionworkers[i].workerhours
                                                                .toString()),
                                                  
                                                  ));
                                            });
                                      
                                    },
                                    icon: Icon(editeicon)),
                                    injectionworkernumber: BlocProvider.of<InjectionworkersCubit>(context)
                                        .injectionworkers[i]
                                        .workernumber.toString(),
                                    injectionworkername:
                                        BlocProvider.of<InjectionworkersCubit>(context)
                                            .injectionworkers[i]
                                            .workername,
                                  
                                    delet: IconButton(
                                        onPressed: () {
                                        
                                            awsomdialogerror(
                                                context: context,
                                                mywidget: BlocConsumer<
                                                    InjectionworkersCubit, InjectionworkersState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is deleteInjectionworkersuccess) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .success_message,
                                                          toaststate: Toaststate
                                                              .succes);
                                                    }
                                                    if (state
                                                        is deleteInjectionworkerfailure) {
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
                                                        is deleteInjectionworkerloading)
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
                                                                    .of<InjectionworkersCubit>(
                                                                        context)
                                                                .deleteinjectionworkers(
                                                                    injectionworker:
                                                                       BlocProvider.of<InjectionworkersCubit>(context).injectionworkers[i]);
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
                                                    "هل تريد حذف العامل ${BlocProvider.of<InjectionworkersCubit>(context).injectionworkers[i].workernumber}");
                                        },
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        ))),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<InjectionworkersCubit>(context)
                              .injectionworkers
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
