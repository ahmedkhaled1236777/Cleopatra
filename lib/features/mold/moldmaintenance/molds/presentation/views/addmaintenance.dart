import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/data/models/maintenancemodel.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/maintenancestate.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/widgets/radios.dart';

class Addmaintenance extends StatelessWidget {
  TextEditingController location = TextEditingController();
  TextEditingController cause = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لايوجد");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "اضافة صيانة اسطمبه",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<maintenancesCubit, maintenancesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child:Center(
                    child: Container(
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
                          : double.infinity,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12, right: 9),
                          child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    BlocBuilder<maintenancesCubit, maintenancesState>(
                      builder: (context, state) {
                        return radios(
                            firstradio: "داخليه",
                            secondradio: "خارجيه",
                            firstradiotitle: "داخليه",
                            secondradiotitle: "خارجيه");
                      },
                    ),
                    BlocBuilder<DateCubit, DateState>(
                      builder: (context, state) {
                        return choosedate(
                          date: BlocProvider.of<DateCubit>(context).date5,
                          onPressed: () {
                            BlocProvider.of<DateCubit>(context)
                                .changedate5(context);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Color(0xff535C91),
                      child: Center(
                        child:
                            BlocBuilder<maintenancesCubit, maintenancesState>(
                          builder: (context, state) {
                            return DropdownSearch<String>(
                              dropdownButtonProps:
                                  DropdownButtonProps(color: Colors.white),
                              popupProps: PopupProps.menu(
                                  showSelectedItems: true,
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps()),
                              selectedItem:
                                  BlocProvider.of<maintenancesCubit>(context)
                                      .maintenancename,
                              items: cashhelper.getdata(key: "mymolds")==null ? []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                              onChanged: (value) {
                                BlocProvider.of<maintenancesCubit>(context)
                                    .maintenancechange(value!);
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  baseStyle: TextStyle(
                                      color: Colors.white, fontFamily: "cairo"),
                                  textAlign: TextAlign.center,
                                  dropdownSearchDecoration: InputDecoration(
                                    enabled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff535C91)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff535C91)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (BlocProvider.of<maintenancesCubit>(context).type ==
                        "خارجيه")
                      custommytextform(
                        val: "برجاء ادخال جهة الصيانه",
                        controller: location,
                        hintText: "جهة الصيانه",
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    custommytextform(
                      val: "برجاء ادخال سبب الصيانه",
                      controller: cause,
                      hintText: "سبب الصيانه",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    custommytextform(
                      val: "برجاء كتابة اي ملاحظات اذا وجدت",
                      controller: notes,
                      hintText: "الملاحظات",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<maintenancesCubit, maintenancesState>(
                      listener: (context, state) async {
                        if (state is addmaintenancesuccess) {
                          BlocProvider.of<DateCubit>(context).cleardates();
                          location.clear();
                          notes.clear();
                          cause.clear();
                          BlocProvider.of<maintenancesCubit>(context)
                              .maintenancename = "اختر الاسطمبه";
                          location.clear();
                          showtoast(
                                                                                                              context: context,

                              message: state.success_message,
                              toaststate: Toaststate.succes);

                          await BlocProvider.of<maintenancesCubit>(context)
                              .getmaintenances();
                        }
                        if (state is addmaintenancefailure)
                          showtoast(
                                                                                                              context: context,

                              message: state.error_message,
                              toaststate: Toaststate.error);
                      },
                      builder: (context, state) {
                        if (state is addmaintenanceloading) return loading();
                        return custommaterialbutton(
                          button_name: "اضافه",
                          onPressed: () {
                            if (BlocProvider.of<maintenancesCubit>(context)
                                    .maintenancename ==
                                "اختر الاسطمبه")
                              showdialogerror(
                                  error: "برجاء اختيار اسم الاسطمبه",
                                  context: context);
                            else if (BlocProvider.of<DateCubit>(context)
                                    .date5 ==
                                "تاريخ بدابة الصيانه") {
                              showdialogerror(
                                  error: "برجاء اختيار تاريخ بداية الصيانه",
                                  context: context);
                            } else {
                              if (formkey.currentState!.validate())
                                BlocProvider.of<maintenancesCubit>(context).addmaintenance(
                                    maintenancemodel: maintenancemodel(
                                        godate: BlocProvider.of<DateCubit>(context)
                                            .date5,
                                        notes: notes.text,
                                        cause: cause.text,
                                        retrundate:
                                            BlocProvider.of<DateCubit>(context)
                                                        .date6 ==
                                                    "تاريخ نهاية الصيانه"
                                                ? null
                                                : BlocProvider.of<DateCubit>(context)
                                                    .date6,
                                        type: BlocProvider.of<maintenancesCubit>(
                                                context)
                                            .type,
                                        status: "تحت الصيانه",
                                        moldname:
                                            BlocProvider.of<maintenancesCubit>(
                                                    context)
                                                .maintenancename,
                                        location: location.text));
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
                    )))),
          );
        },
      ),
    );
  }
}
