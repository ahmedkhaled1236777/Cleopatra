import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/maintenancestate.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/molds_cubit.dart';

class Alertmaintenancecontent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
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
                          vertical: 20, horizontal: 0),
                      child: Column(children: [
                        Text('بحث بواسطة',
                            style: TextStyle(
                                color: appcolors.maincolor,
                                fontFamily: "cairo",
                                fontSize: 12.5),
                            textAlign: TextAlign.right),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Color(0xff535C91),
                          child: Center(
                            child: BlocBuilder<maintenancesCubit,
                                maintenancesState>(
                              builder: (context, state) {
                                return DropdownSearch<String>(
                                  dropdownButtonProps: DropdownButtonProps(
                                      color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<maintenancesCubit>(
                                              context)
                                          .maintenancename,
                                  items:
                                      cashhelper.getdata(key: "mymolds")==null ?
                                          []:List<String>.from(cashhelper.getdata(key: "mymolds")),
                                  onChanged: (value) {
                                    BlocProvider.of<maintenancesCubit>(
                                            context)
                                        .maintenancechange(value!);
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
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الحاله",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: appcolors.maincolor),
                              textAlign: TextAlign.right,
                            )),
                        Container(
                          color: Color(0xff535C91),
                          child: Center(
                            child: BlocBuilder<maintenancesCubit,
                                maintenancesState>(
                              builder: (context, state) {
                                return DropdownSearch<String>(
                                  dropdownButtonProps: DropdownButtonProps(
                                      color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<maintenancesCubit>(
                                              context)
                                          .maintenancestatus,
                                  items: [
                                    "تحت الصيانه",
                                    "تمت الصيانه",
                                  ],
                                  onChanged: (value) {
                                    BlocProvider.of<maintenancesCubit>(
                                            context)
                                        .maintenancechangestatus(value!);
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
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        custommaterialbutton(
                          button_name: "بحث",
                          onPressed: () async {
                            BlocProvider.of<maintenancesCubit>(context)
                                .searchmaintenance(
                              mold: BlocProvider.of<maintenancesCubit>(
                                              context)
                                          .maintenancename ==
                                      "اختر الاسطمبه"
                                  ? null
                                  : BlocProvider.of<maintenancesCubit>(
                                          context)
                                      .maintenancename,
                              status: BlocProvider.of<maintenancesCubit>(
                                      context)
                                  .maintenancestatus,
                            );
                            BlocProvider.of<DateCubit>(context).date2 =
                                "اختر التاريخ";
                            BlocProvider.of<maintenancesCubit>(context)
                                .maintenancename = "اختر الاسطمبه";
                            Navigator.pop(context);
                          },
                        )
                      ])))
            ])));
  }
}
