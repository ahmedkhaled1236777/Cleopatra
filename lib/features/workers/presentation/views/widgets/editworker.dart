import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/workers/data/models/workermodelrequest.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_state.dart';

import '../../../../../core/common/date/date_cubit.dart';

class editworkerdialog extends StatelessWidget {
  TextEditingController jop = TextEditingController();
  TextEditingController workhours = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController salary = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final String id;
  final String date;

  editworkerdialog(
      {super.key,
      required this.jop,
      required this.date,
      required this.workhours,
      required this.salary,
      required this.phone,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width > 950
                    ? MediaQuery.sizeOf(context).width * 0.25
                    : MediaQuery.sizeOf(context).width * 1,
                child: BlocBuilder<DateCubit, DateState>(
                  builder: (context, state) {
                    return choosedate(
                      date: BlocProvider.of<DateCubit>(context).date2,
                      onPressed: () {
                        BlocProvider.of<DateCubit>(context)
                            .changedate2(context);
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              custommytextform(
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
                  FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
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
                  FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
                ],
                keyboardType: TextInputType.number,
                controller: salary,
                hintText: "الراتب",
                val: "برجاء ادخال الراتب",
              ),
              SizedBox(
                height: 7,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<attendanceworkersCubit, attendanceworkersState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: custommytextform(
                            readonly: true,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9-.]")),
                            ],
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(
                                text: BlocProvider.of<attendanceworkersCubit>(
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
                     /*     navigateto(
                              context: context, page: QrToStringScreen());*/
                        },
                        icon: Icon(Icons.qr_code_scanner_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<attendanceworkersCubit, attendanceworkersState>(
                listener: (context, state) async {
                  if (state is editattendanceworkersuccess) {
                    BlocProvider.of<attendanceworkersCubit>(context)
                        .changescanner("معرف الجهاز", context);
                    await BlocProvider.of<attendanceworkersCubit>(context)
                        .getattendanceworkers();
                    Navigator.pop(context);
                  }
                  if (state is editworkerfailure) {
                    showdialogerror(
                        error: state.errormessage, context: context);
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is editworkerloading) return loading();
                  return custommaterialbutton(
                    button_name: "تعديل البيانات",
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<attendanceworkersCubit>(context)
                            .updateworker(
                                worker: Workermodelrequest(
                                    name: id,
                                    job_title: jop.text,
                                    employment_date: date,
                                    phone: phone.text,
                                    deviceip:
                                        BlocProvider.of<attendanceworkersCubit>(
                                                context)
                                            .scanner,
                                    workhours: workhours.text,
                                    salary: salary.text),
                                id: id);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
