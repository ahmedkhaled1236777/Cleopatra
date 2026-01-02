import 'package:cleopatra/core/common/widgets/error.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
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
import 'package:cleopatra/features/injections/injectionorders/data/models/productionmodel.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/widgets/orderradio.dart';
import 'package:cleopatra/features/mold/molds/presentation/viewmodel/molds/molds_cubit.dart';

class addinreport extends StatefulWidget {
  final String ordernumber;

  const addinreport({super.key, required this.ordernumber});
  @override
  State<addinreport> createState() => _addinjectreportState();
}

class _addinjectreportState extends State<addinreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();
  TextEditingController purepercentaege = TextEditingController();
  TextEditingController breakpercentage = TextEditingController();
  TextEditingController masterpersentage = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController machine = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

  getdata() async {
    if (BlocProvider.of<productioncuibt>(context).timers.isEmpty) {
      await BlocProvider.of<productioncuibt>(context).gettimers();
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
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "اضافة اوردر",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<productioncuibt, productiontates>(
          builder: (context, state) {
            if(state is GetTimerLoading)return loading();
            if(state is GetTimerFailure)return errorfailure(errormessage: state.errormessage);

            return 
            Center(
              child: Container(
                margin: EdgeInsets.all(
                  MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
                  ),
                ),
                width:
                    MediaQuery.sizeOf(context).width > 650
                        ? MediaQuery.sizeOf(context).width * 0.4
                        : double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 9),
                  child: Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 9),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            BlocBuilder<injectionhallcuibt, injectionhalltates>(
                              builder: (context, state) {
                                return Orderradio(
                                  firstradio: "بمصب",
                                  secondradio: "بدون",
                                  firstradiotitle: "بمصب",
                                  secondradiotitle: "بدون",
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(
                                        context,
                                      ).producthalldate,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(
                                      context,
                                    ).changedatehall(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Container(
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
                                      selectedItem:
                                          BlocProvider.of<MoldsCubit>(
                                            context,
                                          ).moldname,
                                      items:
                                          cashhelper.getdata(key: "mymolds") ==
                                                  null
                                              ? []
                                              : List<String>.from(
                                                cashhelper.getdata(
                                                  key: "mymolds",
                                                ),
                                              ),
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
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
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
                                      selectedItem:
                                          BlocProvider.of<MoldsCubit>(
                                            context,
                                          ).materialtype,
                                      items:
                                          BlocProvider.of<MoldsCubit>(
                                            context,
                                          ).materiales,
                                      onChanged: (value) {
                                        BlocProvider.of<MoldsCubit>(
                                          context,
                                        ).materialchange(value!);
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
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                      keyboardType: TextInputType.number,
                                      controller: purepercentaege,
                                      hintText: "نسبة البيور",
                                      val: "برجاء ادخال نسبة البيور",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                      keyboardType: TextInputType.number,
                                      controller: breakpercentage,
                                      hintText: "نسبة الكسر",
                                      val: "برجاء ادخال نسبة الكسر",
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                      keyboardType: TextInputType.number,
                                      controller: masterpersentage,
                                      hintText: "نسبة الماستر",
                                      val: "برجاء ادخال نسبة الماستر",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            custommytextform(
                              controller: color,
                              hintText: "اللون",
                              val: "برجاء ادخال رقم اللون",
                            ),
                            SizedBox(height: 10),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: machine,
                              hintText: "رقم الماكينه",
                              val: "برجاء ادخال رقم الماكينه",
                            ),
                            const SizedBox(height: 10),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                text: widget.ordernumber,
                              ),
                              hintText: "رقم الاوردر",
                              val: "برجاء ادخال رقم الاوردر",
                            ),
                            const SizedBox(height: 10),
                            custommytextform(
                              controller: quantity,
                              hintText: "الكميه المطلوبه",
                              val: "برجاء ادخال الكمية المطلوبه",
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(height: 10),
                            custommytextform(
                              controller: notes,
                              hintText: "الملاحظات",
                              val: "برجاء ادخال الملاحظات",
                            ),
                            const SizedBox(height: 20),
                            BlocConsumer<
                              injectionhallcuibt,
                              injectionhalltates
                            >(
                              listener: (context, state) async {
                                if (state is injectionhalltatesuccess) {
                                  quantity.clear();
                                  purepercentaege.clear();
                                  breakpercentage.clear();
                                  color.clear();
                                  machine.clear();
                                  masterpersentage.clear();
                                  BlocProvider.of<DateCubit>(
                                    context,
                                  ).cleardates();

                                  await BlocProvider.of<injectionhallcuibt>(
                                    context,
                                  ).getinjection(status: false);
                                  await BlocProvider.of<MoldsCubit>(
                                    context,
                                  ).resetmold();

                                  showtoast(
                                    context: context,

                                    message: state.success_message,
                                    toaststate: Toaststate.succes,
                                  );
                                }
                                if (state is injectionhalltatefailure)
                                  showtoast(
                                    context: context,

                                    message: state.error_message,
                                    toaststate: Toaststate.error,
                                  );
                              },
                              builder: (context, state) {
                                if (state is injectionhalltateloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل الاوردر",
                                  onPressed: () async {
                                    if (BlocProvider.of<MoldsCubit>(
                                          context,
                                        ).moldname ==
                                        "اختر الاسطمبه") {
                                      showdialogerror(
                                        error: "يجب اختيار الاسطمبه",
                                        context: context,
                                      );
                                    } else {
                                      if (formkey.currentState!.validate()) {
                                        // ignore: curly_braces_in_flow_control_structures
                                        await BlocProvider.of<
                                          injectionhallcuibt
                                        >(context).addinjection(
                                          injectionmodel: injectionhallmodel(
                                            sprue:
                                                BlocProvider.of<
                                                          injectionhallcuibt
                                                        >(context).type ==
                                                        "بمصب"
                                                    ? true
                                                    : false,
                                            pureper: purepercentaege.text,
                                            breakper: breakpercentage.text,
                                            masterper: masterpersentage.text,
                                            materialtype:
                                                BlocProvider.of<MoldsCubit>(
                                                  context,
                                                ).materialtype,

                                            notes: notes.text,
                                            status: false,
                                            color: color.text,
                                            machine: machine.text,
                                            date:
                                                BlocProvider.of<DateCubit>(
                                                  context,
                                                ).producthalldate,
                                            ordernumber: widget.ordernumber,
                                            name:
                                                BlocProvider.of<MoldsCubit>(
                                                  context,
                                                ).moldname,
                                            quantity: quantity.text,
                                            producedquantity: '0',
                                          ),
                                        );
                                        /*  for (var i = 0; i < BlocProvider.of<componentCubit>(context).components.length; i++) {
                                             if(BlocProvider.of<componentCubit>(context).prodname==BlocProvider.of<componentCubit>(context).components[i].name){
                                              if(int.parse(quantity.text)>BlocProvider.of<componentCubit>(context).components[i].quantity){
                                                showdialogerror(error: "هذه الكميه ليست متوفره بالمخزن", context: context);
                                              }
                                              else{
            BlocProvider.of<injectionhallcuibt>(context)
                                                  .addinjection(injectionmodel: injectionhallmodel(date: BlocProvider.of<DateCubit>(context).producthalldate,
                                                   ordernumber: ordernumber.text, name: BlocProvider.of<componentCubit>(context).prodname, quantity: quantity.text, line: BlocProvider.of<injectionhallcuibt>(context).linename)
                                                    );
                                              }
                                             }
                                           }*/
                                      }

                                      ;
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
