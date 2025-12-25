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
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/addsubcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/customtablesubcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';

class subcomponents extends StatefulWidget {
  final String componentname;

  const subcomponents({super.key, required this.componentname});
  @override
  State<subcomponents> createState() => _subcomponentsState();
}

class _subcomponentsState extends State<subcomponents> {
  final componentsheader = [
    "اسم المنتج",
    "الكميه",
    "الوزن",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<componentCubit>(context)
        .getcsubomponents(componentname: widget.componentname);
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
                  navigateto(
                      context: context,
                      page: Addsubcomponent(
                        componentnameid: widget.componentname,
                      ));
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "مكونات ${widget.componentname}",
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
                    children: componentsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<componentCubit, componentState>(
                    listener: (context, state) {
                  if (state is getsubcomponentfailure)
                    showtoast(
                                                                          context: context,

                        message: state.errormessage,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getsubcomponentloadding) return loadingshimmer();
                  if (state is getsubcomponentfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<componentCubit>(context)
                        .subcomponents
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) =>
                              customtablesubcomponentitem(
                                name: BlocProvider.of<componentCubit>(context)
                                    .subcomponents[i]
                                    .name,
                                weigt: BlocProvider.of<componentCubit>(context)
                                    .subcomponents[i]
                                    .weight,
                                quantaity:
                                    BlocProvider.of<componentCubit>(context)
                                        .subcomponents[i]
                                        .qty
                                        .toString(),
                                delete: IconButton(
                                    onPressed: () {
                                      awsomdialogerror(
                                          context: context,
                                          mywidget: BlocConsumer<componentCubit,
                                              componentState>(
                                            listener: (context, state) {
                                              if (state
                                                  is deletesubcomponentsuccess) {
                                                Navigator.pop(context);

                                                showtoast(
                                                                                                      context: context,

                                                    message:
                                                        state.successmessage,
                                                    toaststate:
                                                        Toaststate.succes);
                                              }
                                              if (state
                                                  is deletesubcomponentfailure) {
                                                Navigator.pop(context);

                                                showtoast(
                                                                                                      context: context,

                                                    message: state.errormessage,
                                                    toaststate:
                                                        Toaststate.error);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is deletesubcomponentloading)
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
                                                                  componentCubit>(
                                                              context)
                                                          .deletesubcomponent(
                                                              component: BlocProvider.of<
                                                                              componentCubit>(
                                                                          context)
                                                                      .subcomponents[
                                                                  i],
                                                              componentname:
                                                                  "${widget.componentname}");
                                                    },
                                                    child: const Text(
                                                      "تاكيد",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "cairo",
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              );
                                            },
                                          ),
                                          tittle:
                                              "هل تريد حذف تقرير مكون ${BlocProvider.of<componentCubit>(context).subcomponents[i].name}");
                                    },
                                    icon: Icon(
                                      deleteicon,
                                      color: Colors.red,
                                    )),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<componentCubit>(context)
                              .subcomponents
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
