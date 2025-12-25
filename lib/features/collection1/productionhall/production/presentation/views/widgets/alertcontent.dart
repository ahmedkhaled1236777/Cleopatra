import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/viewmodel/prodstates.dart';

class Alerthallcontent extends StatelessWidget {
  TextEditingController ordernumber = TextEditingController();

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
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date3,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate3(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date4,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate4(context);
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
                                child: BlocBuilder<productionhallcuibt,
                                    productionhalltates>(
                                  builder: (context, state) {
                                    return DropdownSearch<String>(
                                      dropdownButtonProps: DropdownButtonProps(
                                          color: Colors.white),
                                      popupProps: PopupProps.menu(
                                          showSelectedItems: true,
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps()),
                                      selectedItem:
                                          BlocProvider.of<productionhallcuibt>(
                                                  context)
                                              .linename,
                                      items:
                                          BlocProvider.of<productionhallcuibt>(
                                                  context)
                                              .lines,
                                      onChanged: (value) {
                                        BlocProvider.of<productionhallcuibt>(
                                                context)
                                            .linechange(value!);
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
                            custommytextform(
                              controller: ordernumber,
                              hintText: "رقم الاوردر",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<productionhallcuibt,
                                productionhalltates>(
                              listener: (context, state) {
                                if (state is getproductionhalltatesuccess) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                if (state is productionsearchloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "بحث",
                                  onPressed: () async {
                                    if (BlocProvider.of<DateCubit>(context)
                                                .date3 ==
                                            "التاريخ من" &&
                                        BlocProvider.of<DateCubit>(context)
                                                .date4 !=
                                            "التاريخ الي") {
                                      showdialogerror(
                                          error: "لابد اختيار التاريخ من",
                                          context: context);
                                    } else if (BlocProvider.of<DateCubit>(
                                                    context)
                                                .date3 !=
                                            "التاريخ من" &&
                                        BlocProvider.of<DateCubit>(context)
                                                .date4 ==
                                            "التاريخ الي") {
                                      showdialogerror(
                                          error: "لابد اختيار التاريخ الي",
                                          context: context);
                                    } else
                                      BlocProvider.of<productionhallcuibt>(
                                              context)
                                          .shearchforproduction(
                                        ordernumber: ordernumber.text.isEmpty
                                            ? null
                                            : ordernumber.text,
                                        datefrom:
                                            BlocProvider.of<DateCubit>(context)
                                                        .date3 ==
                                                    "التاريخ من"
                                                ? null
                                                : BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date3,
                                        dateto:
                                            BlocProvider.of<DateCubit>(context)
                                                        .date4 ==
                                                    "التاريخ الي"
                                                ? null
                                                : BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date4,
                                        line: BlocProvider.of<
                                                            productionhallcuibt>(
                                                        context)
                                                    .linename ==
                                                "اختر الخط"
                                            ? null
                                            : BlocProvider.of<
                                                        productionhallcuibt>(
                                                    context)
                                                .linename,
                                      );
                                  },
                                );
                              },
                            )
                          ]))))
            ])));
  }
}
