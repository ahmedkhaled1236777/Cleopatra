import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/workers/data/models/workermodelrequest.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_state.dart';

class Addworker extends StatefulWidget {
  @override
  State<Addworker> createState() => _AddworkerState();
}

class _AddworkerState extends State<Addworker> {
  TextEditingController name = TextEditingController();

  TextEditingController jop = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController workhours = TextEditingController();

  TextEditingController salary = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getdeviceip() async {}

  @override
  void initState() {
    getdeviceip();
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
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اضافة عامل",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocBuilder<attendanceworkersCubit, attendanceworkersState>(
              builder: (context, state) {
                if (state is getdeviceiploading) return loading();
                if (state is getdeviceipfailure) return SizedBox();
                return Center(
                    child: Form(
                        key: formkey,
                        child: Container(
                            height: MediaQuery.sizeOf(context).height,
                            margin: EdgeInsets.all(
                                MediaQuery.sizeOf(context).width < 600
                                    ? 0
                                    : 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.sizeOf(context).width < 600
                                        ? 0
                                        : 15)),
                            width: MediaQuery.sizeOf(context).width > 650
                                ? MediaQuery.sizeOf(context).width * 0.4
                                : MediaQuery.sizeOf(context).width,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 9),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "تاريخ التعيين",
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: appcolors.maincolor,
                                            fontFamily: "cairo"),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    BlocBuilder<DateCubit, DateState>(
                                      builder: (context, state) {
                                        return choosedate(
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
                                              .date2,
                                          onPressed: () {
                                            BlocProvider.of<DateCubit>(context)
                                                .changedate2(context);
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: name,
                                      hintText: "اسم الموظف",
                                      val: "برجاء ادخال اسم الموظف",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      keyboardType: TextInputType.number,
                                      controller: phone,
                                      hintText: "رقم الهاتف",
                                      val: "برجاء ادخال رقم الهاتف",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: jop,
                                      hintText: "المسمى الوظيفي",
                                      val: "برجاء ادخال المسمى الوظيفي",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: workhours,
                                      hintText: "عدد ساعات العمل",
                                      val: "برجاء ادخال عدد ساعات العمل",
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9-.]")),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: salary,
                                      hintText: "الراتب",
                                      val: "برجاء ادخال الراتب",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        BlocBuilder<attendanceworkersCubit,
                                            attendanceworkersState>(
                                          builder: (context, state) {
                                            return SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.75,
                                              child: custommytextform(
                                                obscureText: true,
                                                readonly: true,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp("[0-9-.]")),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: TextEditingController(
                                                    text: BlocProvider.of<
                                                                attendanceworkersCubit>(
                                                            context)
                                                        .scanner),
                                                hintText: "معرف الجهاز",
                                                val: "برجاء ادخال معرف الجهاز",
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                             
                                            },
                                            icon: Icon(
                                                Icons.qr_code_scanner_rounded))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BlocConsumer<attendanceworkersCubit,
                                        attendanceworkersState>(
                                      listener: (context, state) {
                                        if (state is addworkerfailure) {
                                          showtoast(
                                                                                                                              context: context,

                                            message: state.errormessage,
                                            toaststate: Toaststate.error,
                                          );
                                        }
                                        if (state
                                            is addattendanceworkersuccess) {
                                          name.clear();
                                          jop.clear();
                                          salary.clear();
                                          workhours.clear();
                                          phone.clear();
                                          BlocProvider.of<
                                                      attendanceworkersCubit>(
                                                  context)
                                              .changescanner(
                                                  "معرف الجهاز", context);
                                          BlocProvider.of<
                                                      attendanceworkersCubit>(
                                                  context)
                                              .getattendanceworkers();
                                          BlocProvider.of<DateCubit>(context)
                                              .cleardates();
                                          showtoast(
                                                                                                                              context: context,

                                            message: state.successmessage,
                                            toaststate: Toaststate.succes,
                                          );
                                        }
                                        // TODO: implement listener
                                      },
                                      builder: (context, state) {
                                        if (state is addworkerloading)
                                          return loading();
                                        return custommaterialbutton(
                                          button_name: "تسجيل",
                                          onPressed: () {
                                            if (BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date2 ==
                                                "اختر التاريخ") {
                                              showdialogerror(
                                                  error: "برجاء اختيار التاريخ",
                                                  context: context);
                                            } else if (BlocProvider.of<
                                                            attendanceworkersCubit>(
                                                        context)
                                                    .scanner ==
                                                "معرف الجهاز") {
                                              showdialogerror(
                                                  error:
                                                      "لا بد من عمل scan للجهاز",
                                                  context: context);
                                            } else {
                                              if (formkey.currentState!.validate())
                                                BlocProvider.of<
                                                            attendanceworkersCubit>(
                                                        context)
                                                    .addworker(
                                                        worker: Workermodelrequest(
                                                            deviceip: BlocProvider
                                                                    .of<attendanceworkersCubit>(
                                                                        context)
                                                                .scanner,
                                                            name: name.text,
                                                            phone: phone.text,
                                                            job_title: jop.text,
                                                            employment_date:
                                                                BlocProvider.of<
                                                                            DateCubit>(
                                                                        context)
                                                                    .date2,
                                                            workhours:
                                                                workhours.text,
                                                            salary:
                                                                salary.text));
                                            }
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ))))));
              },
            )));
  }
}
