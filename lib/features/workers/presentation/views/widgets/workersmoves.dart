/*import 'package:flutter/services.dart';
import 'package:mkr/core/colors/colors.dart';
import 'package:mkr/core/common/constants.dart';
import 'package:mkr/core/common/navigation.dart';
import 'package:mkr/core/common/sharedpref/cashhelper.dart';
import 'package:mkr/core/common/styles/styles.dart';
import 'package:mkr/core/common/toast/toast.dart';
import 'package:mkr/core/common/widgets/dialogerror.dart';
import 'package:mkr/core/common/widgets/error.dart';
import 'package:mkr/core/common/widgets/headerwidget.dart';
import 'package:mkr/core/common/widgets/nodata.dart';
import 'package:mkr/core/common/widgets/shimmerloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkr/features/attendance/presentation/view/widgets/editattendancedialog.dart';
import 'package:mkr/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:mkr/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:mkr/features/workers/presentation/views/addworker.dart';
import 'package:mkr/features/workers/presentation/views/widgets/customworkertimeritemmove.dart';
import 'package:mkr/features/workers/presentation/views/widgets/workeritem.dart';

class Workersmoves extends StatefulWidget {
  final String workername;
  final int workerid;
  final String month;
  final String year;

  const Workersmoves(
      {super.key,
      required this.workername,
      required this.workerid,
      required this.year,
      required this.month});
  @override
  State<Workersmoves> createState() => _WorkersmovesState();
}

class _WorkersmovesState extends State<Workersmoves> {
  final workerheader = [
    "التاريخ",
    "الحاله",
    "تعديل",
  ];

  getdata() async {
    await BlocProvider.of<WorkersCubit>(context).getworkersmoves(
        workerid: widget.workerid, month: widget.month, year: widget.year);
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
                    onPressed: () async {
                      await BlocProvider.of<WorkersCubit>(context)
                          .getworkersmoves(
                              workerid: widget.workerid,
                              month: widget.month,
                              year: widget.year);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "حركات الموظف ${widget.workername} خلال شهر ${widget.month} - ${widget.year}",
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
                    children: workerheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<WorkersCubit, WorkersState>(
                      listener: (context, state) {
                if (state is getworkermovesfailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
              }, builder: (context, state) {
                if (state is getworkermovesloading) return loadingshimmer();
                if (state is getworkermovesfailure)
                  return errorfailure(
                    errormessage: state.errormessage,
                  );
                else {
                  if (BlocProvider.of<WorkersCubit>(context)
                      .workersmoves
                      .isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                            onDoubleTap: () {},
                            onTap: () {
                              /*  showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Container(
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
                                        content: Workeritem(
                                            componentitem:
                                                BlocProvider.of<WorkersCubit>(
                                                        context)
                                                    .workers[i]));
                                  });*/
                            },
                            child: Customworkermovesitem(
                              date: BlocProvider.of<WorkersCubit>(context)
                                      .workersmoves[i]
                                      .date ??
                                  "",
                              type: BlocProvider.of<WorkersCubit>(context)
                                              .workersmoves[i]
                                              .status ==
                                          1 &&
                                      BlocProvider.of<WorkersCubit>(context)
                                              .workersmoves[i]
                                              .type ==
                                          "move"
                                  ? "حضور"
                                  : BlocProvider.of<WorkersCubit>(context)
                                                  .workersmoves[i]
                                                  .status ==
                                              2 &&
                                          BlocProvider.of<WorkersCubit>(context)
                                                  .workersmoves[i]
                                                  .type ==
                                              "move"
                                      ? "غياب"
                                      : BlocProvider.of<WorkersCubit>(context)
                                                      .workersmoves[i]
                                                      .status ==
                                                  0 &&
                                              BlocProvider.of<WorkersCubit>(
                                                          context)
                                                      .workersmoves[i]
                                                      .type ==
                                                  "move"
                                          ? "اجازه"
                                          : "اذن",
                              textStyle:
                                  Styles.gettabletextstyle(context: context),
                              edit: IconButton(
                                  color: const Color.fromARGB(255, 9, 62, 88),
                                  onPressed: () {
                                    BlocProvider.of<Attendancecuibt>(context)
                                        .attendancestatus = BlocProvider.of<WorkersCubit>(context)
                                                    .workersmoves[i]
                                                    .status ==
                                                1 &&
                                            BlocProvider.of<WorkersCubit>(context).workersmoves[i].type ==
                                                "move"
                                        ? "حضور"
                                        : BlocProvider.of<WorkersCubit>(context)
                                                        .workersmoves[i]
                                                        .status ==
                                                    2 &&
                                                BlocProvider.of<WorkersCubit>(context)
                                                        .workersmoves[i]
                                                        .type ==
                                                    "move"
                                            ? "غياب"
                                            : BlocProvider.of<WorkersCubit>(context)
                                                            .workersmoves[i]
                                                            .status ==
                                                        0 &&
                                                    BlocProvider.of<WorkersCubit>(context)
                                                            .workersmoves[i]
                                                            .type ==
                                                        "move"
                                                ? "اجازه"
                                                : "اذن";

                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              title: Container(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          appcolors.maincolor,
                                                    )),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.all(35),
                                              content: Editattendancedialog(
                                                moveid: BlocProvider.of<
                                                        WorkersCubit>(context)
                                                    .workersmoves[i]
                                                    .id!,
                                                employeid: widget.workerid,
                                                type: BlocProvider.of<
                                                        WorkersCubit>(context)
                                                    .workersmoves[i]
                                                    .type!,
                                                permessionhours: BlocProvider
                                                                .of<WorkersCubit>(
                                                                    context)
                                                            .workersmoves[i]
                                                            .type ==
                                                        "move"
                                                    ? null
                                                    : TextEditingController(
                                                        text: BlocProvider.of<
                                                                    WorkersCubit>(
                                                                context)
                                                            .workersmoves[i]
                                                            .numberOfHours
                                                            .toString()),
                                                notes: BlocProvider.of<
                                                                    WorkersCubit>(
                                                                context)
                                                            .workersmoves[i]
                                                            .type ==
                                                        "move"
                                                    ? null
                                                    : TextEditingController(
                                                        text: BlocProvider.of<
                                                                    WorkersCubit>(
                                                                context)
                                                            .workersmoves[i]
                                                            .notes
                                                            .toString()),
                                                date: BlocProvider.of<
                                                        WorkersCubit>(context)
                                                    .workersmoves[i]
                                                    .date!,
                                                month: widget.month,
                                                year: widget.year,
                                              ));
                                        });
                                  },
                                  icon: Icon(editeicon)),
                            )),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<WorkersCubit>(context)
                            .workersmoves
                            .length);
                  }
                }
              })),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: appcolors.primarycolor,
                        borderRadius: BorderRadius.circular(7)),
                    child: IconButton(
                        onPressed: () async {
                          if (!cashhelper
                              .getdata(key: "permessions")
                              .contains('addworker')) {
                            showdialogerror(
                                error: "ليس لديك الصلاحيه", context: context);
                          } else
                            navigateto(context: context, page: Addworker());
                        },
                        icon: Icon(
                          color: Colors.white,
                          Icons.add,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ])));
  }
}
*/