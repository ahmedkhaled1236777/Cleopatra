import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/view/addworker.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/view/customtablemolditem.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/viewmodel/worker/worker_cubit.dart';

class Workers extends StatefulWidget {
  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  final moldusagesheader = [
    "اسم العامل",
    "الكود",
    "حذف",
  ];

  getdata() async {
    if (BlocProvider.of<WorkerCubit>(context).workers.isEmpty)
      await BlocProvider.of<WorkerCubit>(context).getworkers();
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
                  if (!permession.contains('اضافة العمال'))
                    showdialogerror(
                        error: "ليس لديك صلاحية اضافة التقارير",
                        context: context);
                  else
                    navigateto(context: context, page: Addworker());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اسماء العمال",
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
                    children: moldusagesheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تحديد" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<WorkerCubit, WorkerState>(
                    listener: (context, state) {
                  if (state is GetWorkersFailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.errormessage,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is GetWorkersLoading) return loadingshimmer();
                  if (state is GetWorkersFailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<WorkerCubit>(context).workers.isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: customtableworkeritem(
                                  code: BlocProvider.of<WorkerCubit>(context)
                                      .workers[i]
                                      .code,
                                  workername:
                                      BlocProvider.of<WorkerCubit>(context)
                                          .workers[i]
                                          .workername,
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<WorkerCubit,
                                                WorkerState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deleteworkersuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                                if (state
                                                    is deleteworkerfailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                                                                                                      context: context,

                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is deleteworkerloading)
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
                                                                    WorkerCubit>(
                                                                context)
                                                            .deleteworker(
                                                                workermodel: BlocProvider.of<
                                                                            WorkerCubit>(
                                                                        context)
                                                                    .workers[i]);
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
                                                "هل تريد حذف ${BlocProvider.of<WorkerCubit>(context).workers[i].workername}");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      )),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<WorkerCubit>(context)
                              .workers
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
