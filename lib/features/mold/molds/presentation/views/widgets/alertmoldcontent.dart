import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';

class Alertmoldcontent extends StatelessWidget {
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
                                      BlocProvider.of<DateCubit>(context).date2,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate2(context);
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
                                child: BlocBuilder<MoldsCubit, MoldsState>(
                                  builder: (context, state) {
                                    return DropdownSearch<String>(
                                      dropdownButtonProps: DropdownButtonProps(
                                          color: Colors.white),
                                      popupProps: PopupProps.menu(
                                          showSelectedItems: true,
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps()),
                                      selectedItem:
                                          BlocProvider.of<MoldsCubit>(context)
                                              .moldname,
                                      items:
                                          cashhelper.getdata(key: "mymolds")==null ?
                                              []:List<String>.from( cashhelper.getdata(key: "mymolds")),
                                      onChanged: (value) {
                                        BlocProvider.of<MoldsCubit>(context)
                                            .moldchange(value!);
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
                                BlocProvider.of<MoldsCubit>(context).searchmold(
                                    moldname: BlocProvider.of<MoldsCubit>(
                                                    context)
                                                .moldname ==
                                            "اختر الاسطمبه"
                                        ? null
                                        : BlocProvider.of<MoldsCubit>(context)
                                            .moldname,
                                    date: BlocProvider.of<DateCubit>(context)
                                                .date2 ==
                                            "اختر التاريخ"
                                        ? null
                                        : BlocProvider.of<DateCubit>(context)
                                            .date2);
                                BlocProvider.of<DateCubit>(context).date2 =
                                    "اختر التاريخ";
                                BlocProvider.of<MoldsCubit>(context).moldname =
                                    "اختر الاسطمبه";
                                Navigator.pop(context);
                              },
                            )
                          ]))))
            ])));
  }
}
