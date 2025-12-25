import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_state.dart';

class Alertmoldusagecontent extends StatelessWidget {
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
                            Container(
                              color: Color(0xff535C91),
                              child: Center(
                                child: BlocBuilder<moldusagesCubit,
                                    moldusagesState>(
                                  builder: (context, state) {
                                    return DropdownSearch<String>(
                                      dropdownButtonProps: DropdownButtonProps(
                                          color: Colors.white),
                                      popupProps: PopupProps.menu(
                                          showSelectedItems: true,
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps()),
                                      selectedItem:
                                          BlocProvider.of<moldusagesCubit>(
                                                  context)
                                              .moldusagename,
                                      items: cashhelper.getdata(key: "mymolds"),
                                      onChanged: (value) {
                                        BlocProvider.of<moldusagesCubit>(
                                                context)
                                            .moldusagechange(value!);
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
                                BlocProvider.of<moldusagesCubit>(context)
                                    .searchmold(
                                  moldname:
                                      BlocProvider.of<moldusagesCubit>(context)
                                          .moldusagename,
                                );
                                BlocProvider.of<moldusagesCubit>(context)
                                    .moldusagechange("اختر الاسطمبه");
                                Navigator.pop(context);
                              },
                            )
                          ]))))
            ])));
  }
}
