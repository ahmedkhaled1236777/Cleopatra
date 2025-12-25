import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/view/addinjectionmaterial.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/view/widgets/customtabeinjectionmaterialitem.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/view/widgets/editmaterial.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_cubit.dart';
import 'package:cleopatra/features/injections/injectionmateriales/presentation/viewmodel/cubit/injectionmateriales_state.dart';




class injectionmaterials extends StatefulWidget {
  @override
  State<injectionmaterials> createState() => _injectionmaterialsState();
}

class _injectionmaterialsState extends State<injectionmaterials> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final injectionmaterialsheader = [
    "اسم الخامه",
    "سعر طن البيور",
    "سعر طن الكسر",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    if (BlocProvider.of<InjectionmaterialsCubit>(context).injectionmaterials.isEmpty)
      await BlocProvider.of<InjectionmaterialsCubit>(context).getinjectionmaterials();
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
                
                    navigateto(context: context, page: Addinjectionmaterial());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<InjectionmaterialsCubit>(context).getinjectionmaterials();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
             
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "خامات الحقن",
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
                    children: injectionmaterialsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<InjectionmaterialsCubit, InjectionmaterialsState>(
                    listener: (context, state) {
                  if (state is getInjectionmaterialfailure)
                    showtoast(

                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getInjectionmaterialloading) return loadingshimmer();
                  if (state is getInjectionmaterialfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<InjectionmaterialsCubit>(context).injectionmaterials.isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => customtableinjectionmaterialitem(
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
                                            content: editmaterialdialog(
                                              materialname:  BlocProvider.of<
                                                          InjectionmaterialsCubit>(
                                                      context)
                                                  .injectionmaterials[i].materialname,
                                             
                                              purematerialcost:
                                                  TextEditingController(
                                                      text: BlocProvider.of<
                                                          InjectionmaterialsCubit>(
                                                      context)
                                                  .injectionmaterials[i].purematerialcost.toString()),
                                              breakmaterialcost:
                                                  TextEditingController(
                                                      text: BlocProvider.of<
                                                          InjectionmaterialsCubit>(
                                                      context)
                                                  .injectionmaterials[i].breakmaterialcost
                                                          .toString()),
                                            
                                            ));
                                      });
                                
                              },
                              icon: Icon(editeicon)),

                              injectionmaterialname:
                                  BlocProvider.of<InjectionmaterialsCubit>(context)
                                      .injectionmaterials[i]
                                      .materialname,
                                        purematerialcost:
                                           BlocProvider.of<
                                                          InjectionmaterialsCubit>(
                                                      context)
                                                  .injectionmaterials[i].purematerialcost.toString(),
                                              breakmaterialcost:
                                                 BlocProvider.of<
                                                          InjectionmaterialsCubit>(
                                                      context)
                                                  .injectionmaterials[i].breakmaterialcost
                                                          .toString(),
                            
                              delet: IconButton(
                                  onPressed: () {
                                  
                                      awsomdialogerror(
                                          context: context,
                                          mywidget: BlocConsumer<
                                              InjectionmaterialsCubit, InjectionmaterialsState>(
                                            listener: (context, state) {
                                              if (state
                                                  is deleteInjectionmaterialsuccess) {
                                                Navigator.pop(context);
                          
                                                showtoast(
                                                                                                                                    context: context,

                                                    message: state
                                                        .success_message,
                                                    toaststate: Toaststate
                                                        .succes);
                                              }
                                              if (state
                                                  is deleteInjectionmaterialfailure) {
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
                                                  is deleteInjectionmaterialloading)
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
                                                              .of<InjectionmaterialsCubit>(
                                                                  context)
                                                          .deleteinjectionmaterials(
                                                              injectionmaterial:
                                                                 BlocProvider.of<InjectionmaterialsCubit>(context).injectionmaterials[i]);
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
                                              "هل تريد حذف خامة ${BlocProvider.of<InjectionmaterialsCubit>(context).injectionmaterials[i].materialname}");
                                  },
                                  icon: Icon(
                                    deleteicon,
                                    color: Colors.red,
                                  ))),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<InjectionmaterialsCubit>(context)
                              .injectionmaterials
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
