import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/maintenancestate.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/viewmodel/molds/molds_cubit.dart';

class editmaintenancedialog extends StatelessWidget {
  final String name;
  final String location;
  final String type;
  final TextEditingController notes;
  final String docid;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  editmaintenancedialog(
      {super.key,
      required this.location,
      required this.name,
      required this.type,
      required this.notes,
      required this.docid});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<DateCubit, DateState>(
              builder: (context, state) {
                return choosedate(
                  date: BlocProvider.of<DateCubit>(context).date6,
                  onPressed: () {
                    BlocProvider.of<DateCubit>(context).changedate6(context);
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
                child: BlocBuilder<maintenancesCubit, maintenancesState>(
                  builder: (context, state) {
                    return DropdownSearch<String>(
                      dropdownButtonProps:
                          DropdownButtonProps(color: Colors.white),
                      popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps()),
                      selectedItem: BlocProvider.of<maintenancesCubit>(context)
                          .maintenancestatus,
                      items: [
                        "تحت الصيانه",
                        "تمت الصيانه",
                      ],
                      onChanged: (value) {
                        BlocProvider.of<maintenancesCubit>(context)
                            .maintenancechangestatus(value!);
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(
                              color: Colors.white, fontFamily: "cairo"),
                          textAlign: TextAlign.center,
                          dropdownSearchDecoration: InputDecoration(
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff535C91)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff535C91)),
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
              val: "برجاء كتابة اي ملاحظات اذا وجدت",
              controller: notes,
              hintText: "الملاحظات",
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<maintenancesCubit, maintenancesState>(
              listener: (context, state) {
                if (state is editmaintenancesfailure)
                  showdialogerror(error: state.error_message, context: context);
                if (state is editmaintenancessuccess) {
                  notes.clear();
                  BlocProvider.of<DateCubit>(context).cleardates();
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is editmaintenanceskoading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    BlocProvider.of<maintenancesCubit>(context).editstatus(
                        docid: docid,
                        status: BlocProvider.of<maintenancesCubit>(context)
                            .maintenancestatus,
                        notes: notes.text,
                        name: name,
                        location: location,
                        type: type,
                        retrundate: BlocProvider.of<DateCubit>(context).date6 ==
                                "تاريخ نهاية الصيانه"
                            ? null
                            : BlocProvider.of<DateCubit>(context).date6);
                  },
                );
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
