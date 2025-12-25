import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/hr/data/model/holidays.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';

class Addholiday extends StatefulWidget {
  @override
  State<Addholiday> createState() => _AddholidayState();
}

class _AddholidayState extends State<Addholiday> {
  TextEditingController notes = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "اجازه رسميه",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "cairo",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            margin: EdgeInsets.all(
              MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
              ),
            ),
            width: MediaQuery.sizeOf(context).width > 650
                ? MediaQuery.sizeOf(context).width * 0.4
                : double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 9),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "التاريخ",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: appcolors.maincolor,
                          fontFamily: "cairo",
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<DateCubit, DateState>(
                      builder: (context, state) {
                        return choosedate(
                          date: BlocProvider.of<DateCubit>(context).date2,
                          onPressed: () {
                            BlocProvider.of<DateCubit>(
                              context,
                            ).changedate2(context);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    custommytextform(
                      controller: notes,
                      hintText: "الملاحظات",
                      val: "برجاء ادخال اسم الملاجظات",
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<HrCubit, HrState>(
                      listener: (context, state) {
                        if (state is addfullholidaysuccess) {
                          BlocProvider.of<DateCubit>(context).cleardates();
                          notes.clear();
                          showtoast(
                                                                                                              context: context,

                            message: state.successmessage,
                            toaststate: Toaststate.succes,
                          );
                        }
                        if (state is addfullholidayfailure) {
                          showtoast(
                                                                                                              context: context,

                            message: state.errormessage,
                            toaststate: Toaststate.error,
                          );
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is addfullholidayloading) return loading();
                        return custommaterialbutton(
                          button_name: "تسجيل",
                          onPressed: () {
                            if (BlocProvider.of<DateCubit>(context).date2 ==
                                "اختر التاريخ") {
                              showdialogerror(
                                error: "برجاء اختيار التاريخ",
                                context: context,
                              );
                            } else {
                              if (formkey.currentState!.validate())
                                BlocProvider.of<HrCubit>(
                                  context,
                                ).addfullholiday(
                                  holiday: holiday(
                                    notes: notes.text,
                                    date: BlocProvider.of<DateCubit>(
                                      context,
                                    ).date2,
                                  ),
                                  monthyear:
                                      "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year}",
                                );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
