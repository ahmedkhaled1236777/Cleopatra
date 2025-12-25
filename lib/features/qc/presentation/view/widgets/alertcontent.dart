import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_cubit.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_state.dart';

class Alertqccontent extends StatefulWidget {
  @override
  State<Alertqccontent> createState() => _AlertqccontentState();
}

class _AlertqccontentState extends State<Alertqccontent> {
  TextEditingController machinenumber = TextEditingController();
  getdata() async {
    if (cashhelper.getdata(key: "mymolds") == null) {
      await BlocProvider.of<MoldsCubit>(context).getmolds();
    }
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width > 950
                  ? MediaQuery.sizeOf(context).width * 0.25
                  : MediaQuery.sizeOf(context).width * 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Text(
                        'بحث بواسطة',
                        style: TextStyle(
                          color: appcolors.maincolor,
                          fontFamily: "cairo",
                          fontSize: 12.5,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 15),
                      BlocBuilder<DateCubit, DateState>(
                        builder: (context, state) {
                          return choosedate(
                            date: BlocProvider.of<DateCubit>(context).date7,
                            onPressed: () {
                              BlocProvider.of<DateCubit>(
                                context,
                              ).changedate7(context);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      BlocBuilder<MoldsCubit, MoldsState>(
                        builder: (context, state) {
                          if (state is getmoldfailure)
                            return Text(state.error_message);
                          if (state is getmoldloading) return loading();
                          return Container(
                            color: Color(0xff535C91),
                            child: Center(
                              child: BlocBuilder<MoldsCubit, MoldsState>(
                                builder: (context, state) {
                                  return DropdownSearch<String>(
                                    dropdownButtonProps: DropdownButtonProps(
                                      color: Colors.white,
                                    ),
                                    popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(),
                                    ),
                                    selectedItem: BlocProvider.of<MoldsCubit>(
                                      context,
                                    ).moldname,
                                    items:
                                        cashhelper.getdata(key: "mymolds")==null?
                                        []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                                    onChanged: (value) {
                                      BlocProvider.of<MoldsCubit>(
                                        context,
                                      ).moldchange(value!);
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                          baseStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "cairo",
                                          ),
                                          textAlign: TextAlign.center,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                enabled: true,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xff535C91,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xff535C91),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                        ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      custommytextform(
                        controller: machinenumber,
                        hintText: "رقم الماكينه",
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 20),
                      BlocConsumer<qcsCubit, qcsState>(
                        listener: (context, state) {
                          if(state is getqcfailure){
                            showdialogerror(error: state.error_message, context: context);
                          }
                          if(state is getqcsuccess){
                            BlocProvider.of<MoldsCubit>(
                                      context,
                                    ).resetmold();
                                              BlocProvider.of<DateCubit>(context).cleardates();

                            showtoast(
                                                                                                                context: context,

                              message: state.success_message, toaststate: Toaststate.succes);
                            Navigator.pop(context);
                            
                          }
                        },
                        builder: (context, state) {
                          if(state is getqcloading)return loading();
                          return custommaterialbutton(
                            button_name: "بحث",
                            onPressed: () async {
                         print("lllllllllllllllllllllllllllllllllll");
                         print( BlocProvider.of<DateCubit>(context).date7);
                              await BlocProvider.of<qcsCubit>(context).getqcs(
                                date:
                                    BlocProvider.of<DateCubit>(context).date7 ==
                                        "اختر التاريخ"
                                    ? null
                                    : BlocProvider.of<DateCubit>(context).date7,
                                prodname:
                                    BlocProvider.of<MoldsCubit>(
                                          context,
                                        ).moldname ==
                                        "اختر الاسطمبه"
                                    ? null
                                    : BlocProvider.of<MoldsCubit>(
                                        context,
                                      ).moldname,
                                machinenumber: machinenumber.text.isEmpty
                                    ? null
                                    : machinenumber.text,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
