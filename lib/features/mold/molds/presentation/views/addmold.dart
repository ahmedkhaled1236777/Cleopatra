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
import 'package:cleopatra/core/common/widgets/dropdown.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/time.dart';
import 'package:cleopatra/features/mold/molds/data/models/moldmodel.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/widgets/radios.dart';

class Addmold extends StatelessWidget {
  TextEditingController notes = TextEditingController();
  TextEditingController machinenumber = TextEditingController();
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
          "حركة اسطمبه",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
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
                          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<MoldsCubit, MoldsState>(
                builder: (context, state) {
                  return radios(
                      firstradio: "تركيب",
                      secondradio: "تنزيل",
                      firstradiotitle: "تركيب",
                      secondradiotitle: "تنزيل");
                },
              ),
              SizedBox(height: 10,),
              BlocBuilder<DateCubit, DateState>(
                builder: (context, state) {
                  return choosedate(
                    date: BlocProvider.of<DateCubit>(context).date1,
                    onPressed: () {
                      BlocProvider.of<DateCubit>(context).changedate(context);
                    },
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "الوقت",
                    style: TextStyle(
                        color: appcolors.maincolor, fontFamily: "cairo"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Time(
                    inittime: DateTime.now(),
                    onChange: (date) {
                      BlocProvider.of<DateCubit>(context).changetimefrom(date);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color(0xff535C91),
                child: Center(
                  child: BlocBuilder<MoldsCubit, MoldsState>(
                    builder: (context, state) {
                      return DropdownSearch<String>(
                        dropdownButtonProps:
                            DropdownButtonProps(color: Colors.white),
                        popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps()),
                        selectedItem:
                            BlocProvider.of<MoldsCubit>(context).moldname,
                        items: cashhelper.getdata(key: "mymolds")==null ? []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                        onChanged: (value) {
                          BlocProvider.of<MoldsCubit>(context)
                              .moldchange(value!);
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
              custommytextform(
                controller: machinenumber,
                hintText: "رقم الماكينه",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                controller: notes,
                hintText: "ملاحظات",
                maxlines: 3,
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<MoldsCubit, MoldsState>(
                listener: (context, state) async {
                  if (state is addmoldsuccess) {
                    showtoast(
                                                                                                        context: context,

                        message: state.success_message,
                        toaststate: Toaststate.succes);

                    await BlocProvider.of<MoldsCubit>(context).getmolds();
                  }
                  if (state is addmoldfailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                },
                builder: (context, state) {
                  if (state is addmoldloading) return loading();
                  return custommaterialbutton(
                    button_name: "تسجيل",
                    onPressed: () {
                      if (BlocProvider.of<MoldsCubit>(context).moldname ==
                          "اختر الاسطمبه")
                        showdialogerror(
                            error: "برجاء اختيار اسم الاسطمبه",
                            context: context);
                      else if (BlocProvider.of<DateCubit>(context).timefrom ==
                          "الوقت من") {
                        showdialogerror(
                            error: "برجاء اختيار بداية الوقت",
                            context: context);
                      } else
                        BlocProvider.of<MoldsCubit>(context).addmold(
                            moldmodel: moldmodel(
                                date: BlocProvider.of<DateCubit>(context).date1,
                                time: BlocProvider.of<DateCubit>(context)
                                    .timefrom,
                                status:
                                    BlocProvider.of<MoldsCubit>(context).type,
                                machinenumber: machinenumber.text,
                                moldname: BlocProvider.of<MoldsCubit>(context)
                                    .moldname,
                                notes: notes.text));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    ))));
  }
}
