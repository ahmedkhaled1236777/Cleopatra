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
import 'package:cleopatra/features/injections/injectionmachines/presentation/view/addinjectionmachine.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/view/widgets/customtabeinjectionmachineitem.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/view/widgets/editmachine.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/view/widgets/machineitem.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_cubit.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/viewmodel/cubit/injectionmachines_state.dart';



class injectionmachines extends StatefulWidget {
  @override
  State<injectionmachines> createState() => _injectionmachinesState();
}

class _injectionmachinesState extends State<injectionmachines> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final injectionmachinesheader = [
    "اسم الماكينه",
    "رقم الماكينه",
    "عدد سنوات الاهلاك",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    if (BlocProvider.of<InjectionmachinesCubit>(context).injectionmachines.isEmpty)
      await BlocProvider.of<InjectionmachinesCubit>(context).getinjectionmachines();
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
                
                    navigateto(context: context, page: Addinjectionmachine());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<InjectionmachinesCubit>(context).getinjectionmachines();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
             
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "ماكينات الحقن",
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
                    children: injectionmachinesheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<InjectionmachinesCubit, InjectionmachinesState>(
                    listener: (context, state) {
                  if (state is getInjectionmachinefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getInjectionmachineloading) return loadingshimmer();
                  if (state is getInjectionmachinefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<InjectionmachinesCubit>(context).injectionmachines.isEmpty)
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
                                          content: injectionmachineitem(
                                            injectionmachinemodel: BlocProvider.of<InjectionmachinesCubit>(
                                                    context)
                                                .injectionmachines[i],
                                          ),
                                        );
                                      });
                                },
                                child: customtableinjectionmachineitem(
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
                                                  content: editmachinedialog(
                                                    machinename:TextEditingController(text:  BlocProvider.of<
                                                                InjectionmachinesCubit>(
                                                            context)
                                                        .injectionmachines[i].machinename),
                                                  machinedeprecation:TextEditingController(text:  BlocProvider.of<
                                                                InjectionmachinesCubit>(
                                                            context)
                                                        .injectionmachines[i].machinedeprecation.toString()),
                                                    machinenumber:
                                                       BlocProvider.of<
                                                                InjectionmachinesCubit>(
                                                            context)
                                                        .injectionmachines[i].machinenumber,
                                                    cost:
                                                        TextEditingController(
                                                            text: BlocProvider.of<
                                                                InjectionmachinesCubit>(
                                                            context)
                                                        .injectionmachines[i].machinecost.toString()),
                                                    costelectrichour:
                                                        TextEditingController(
                                                            text: BlocProvider.of<
                                                                InjectionmachinesCubit>(
                                                            context)
                                                        .injectionmachines[i].machinehourelectriccost
                                                                .toString()),
                                                  
                                                  ));
                                            });
                                      
                                    },
                                    icon: Icon(editeicon)),
                                    injectionmachinenumber: BlocProvider.of<InjectionmachinesCubit>(context)
                                        .injectionmachines[i]
                                        .machinenumber.toString(),
                                    injectionmachinename:
                                        BlocProvider.of<InjectionmachinesCubit>(context)
                                            .injectionmachines[i]
                                            .machinename,
                                  
                                    delet: IconButton(
                                        onPressed: () {
                                        
                                            awsomdialogerror(
                                                context: context,
                                                mywidget: BlocConsumer<
                                                    InjectionmachinesCubit, InjectionmachinesState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is deleteInjectionmachinesuccess) {
                                                      Navigator.pop(context);

                                                      showtoast(
                                                          context: context,   message: state
                                                              .success_message,
                                                          toaststate: Toaststate
                                                              .succes);
                                                    }
                                                    if (state
                                                        is deleteInjectionmachinefailure) {
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
                                                        is deleteInjectionmachineloading)
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
                                                                    .of<InjectionmachinesCubit>(
                                                                        context)
                                                                .deleteinjectionmachines(
                                                                    injectionmachine:
                                                                       BlocProvider.of<InjectionmachinesCubit>(context).injectionmachines[i]);
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
                                                    "هل تريد حذف ماكينه رقم ${BlocProvider.of<InjectionmachinesCubit>(context).injectionmachines[i].machinenumber}");
                                        },
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        ))),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<InjectionmachinesCubit>(context)
                              .injectionmachines
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
