import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:cleopatra/features/hr/data/model/absensemodel.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_state.dart';

class addabsense extends StatefulWidget {
  @override
  State<addabsense> createState() => _addabsenseState();
}

class _addabsenseState extends State<addabsense> {
  TextEditingController notes = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getdeviceip() async {}

  @override
  void initState() {}

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
                "اضافة ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
                child: Form(
                    key: formkey,
                    child: Container(
                        height: MediaQuery.sizeOf(context).height,
                        margin: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
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
                            padding: const EdgeInsets.only(left: 12, right: 9),
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                BlocBuilder<DateCubit, DateState>(
                                  builder: (context, state) {
                                    return choosedate(
                                      date: BlocProvider.of<DateCubit>(context)
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
                                Container(
                                  color: Color(0xff535C91),
                                  child: Center(
                                    child: BlocBuilder<attendanceworkersCubit,
                                        attendanceworkersState>(
                                      builder: (context, state) {
                                        return DropdownSearch<String>(
                                          dropdownButtonProps:
                                              DropdownButtonProps(
                                                  color: Colors.white),
                                          popupProps: PopupProps.menu(
                                              showSelectedItems: true,
                                              showSearchBox: true,
                                              searchFieldProps:
                                                  TextFieldProps()),
                                          selectedItem: BlocProvider.of<
                                                      attendanceworkersCubit>(
                                                  context)
                                              .workername,
                                          items: BlocProvider.of<
                                                      attendanceworkersCubit>(
                                                  context)
                                              .workers,
                                          onChanged: (value) {
                                            BlocProvider.of<
                                                        attendanceworkersCubit>(
                                                    context)
                                                .changeemployename(value!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                  baseStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "cairo"),
                                                  textAlign: TextAlign.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    enabled: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff535C91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff535C91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  )),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                custommytextform(
                                  controller: notes,
                                  hintText: "الملاحظات",
                                  val: "برجاء ادخال الملاحظات",
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                BlocConsumer<HrCubit, HrState>(
                                  listener: (context, state) {
                                    if (state is addabsensefailure) {
                                      showtoast(
                                                                                                                          context: context,

                                        message: state.errormessage,
                                        toaststate: Toaststate.error,
                                      );
                                    }
                                    if (state is addabsensesucess) {
                                      notes.clear();
                                      BlocProvider.of<attendanceworkersCubit>(
                                              context)
                                          .changeemployename("اسم الموظف");
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
                                    if (state is addabsenseloading)
                                      return loading();
                                    return custommaterialbutton(
                                      button_name: "تسجيل",
                                      onPressed: () {
                                        if (BlocProvider.of<DateCubit>(context)
                                                .date2 ==
                                            "اختر التاريخ") {
                                          showdialogerror(
                                              error: "برجاء اختيار التاريخ",
                                              context: context);
                                        } else if (BlocProvider.of<
                                                        attendanceworkersCubit>(
                                                    context)
                                                .workername ==
                                            "اسم الموظف") {
                                          showdialogerror(
                                              error: "برجاء اختيار اسم الموظف",
                                              context: context);
                                        } else {
                                          if (formkey.currentState!.validate())
                                            BlocProvider.of<HrCubit>(context)
                                                .addabsense(
                                                    monthyear:
                                                        "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year}",
                                                    workerid: BlocProvider.of<
                                                                attendanceworkersCubit>(
                                                            context)
                                                        .workername,
                                                    absense: Absensemodel(
                                                      name: BlocProvider.of<
                                                                  attendanceworkersCubit>(
                                                              context)
                                                          .workername,
                                                      notes: notes.text,
                                                      date: BlocProvider.of<
                                                                  DateCubit>(
                                                              context)
                                                          .date2,
                                                    ));
                                        }
                                      },
                                    );
                                  },
                                )
                              ],
                            ))))))));
  }
}
