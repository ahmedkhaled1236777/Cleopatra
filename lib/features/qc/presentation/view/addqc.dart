import 'package:animated_analog_clock/animated_analog_clock.dart';
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
import 'package:cleopatra/core/common/widgets/time.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/diagnoses.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/qc/data/models/qcmodel.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_cubit.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_state.dart';

class Addqc extends StatefulWidget {

  final String machinenumber;

  const Addqc({
    super.key,
    required this.machinenumber,
  });
  @override
  State<Addqc> createState() => _addinjectreportState();
}

class _addinjectreportState extends State<Addqc> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController();
  getdata() async {
   
  
    if (BlocProvider.of<productioncuibt>(context).diagnoses.isEmpty)
      await BlocProvider.of<productioncuibt>(context).getdiagnoses();
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
            "اضافة تقرير",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<injectionhallcuibt, injectionhalltates>(
          builder: (context, state) {
            if(state is getinjectionhalltateloading)return loading();
            if(state is getinjectionhalltatefailure)return Center(child: Text(state.error_message),);
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 9),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      SizedBox(height: 10),
                   AnimatedAnalogClock(
                            hourDashColor: Colors.white,
                          centerDotColor: Colors.white  ,
                          hourHandColor: Colors.white,
                          minuteHandColor: Colors.white,
                            size: 130,
                            dialType: DialType.numbers,
                            backgroundImage: AssetImage(
                              'assets/images/mmm.jpg',
                            ),
                          ),
                      SizedBox(height: 10),
                      custommytextform(
                                                readonly: true,

                        controller: TextEditingController(
                          text: BlocProvider.of<injectionhallcuibt>(
                            context,
                          ).qcmap[widget.machinenumber]["prodname"],
                        ),
                        hintText: "اسم المنتج",
                        val: "برجاء ادخال اسم المنتج",
                      ),
                      SizedBox(height: 10),
                      custommytextform(
                                                readonly: true,

                        controller: TextEditingController(
                          text: BlocProvider.of<injectionhallcuibt>(
                            context,
                          ).qcmap[widget.machinenumber]["prodcolor"],
                        ),
                        hintText: "اللون",
                        val: "برجاء ادخال رقم اللون",
                      ),
                      SizedBox(height: 10),

                      BlocBuilder<productioncuibt, productiontates>(
                        builder: (context, state) {
                          if (state is getdiagnoseloading) return loading();
                          if (state is getdiagnosefailure)
                            return Text(state.errormessage);
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xff2BA4C8),
                                width: 0.5,
                              ),
                            ),
                            child: Diagnoses(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          Column(
                            children: [
                              Text(
                                "وقت بداية العيب",
                                style: TextStyle(
                                  color: appcolors.maincolor,
                                  fontFamily: "cairo",
                                ),
                              ),
                              SizedBox(height: 5),
                              Time(
                                inittime: DateTime.now(),
                                onChange: (date) {
                                  BlocProvider.of<DateCubit>(
                                    context,
                                  ).changetimefrom(date);
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "وقت نهاية العيب",
                                style: TextStyle(
                                  color: appcolors.maincolor,
                                  fontFamily: "cairo",
                                ),
                              ),
                              SizedBox(height: 5),
                              Time(
                                inittime: DateTime.now(),
                                onChange: (date) {
                                  BlocProvider.of<DateCubit>(
                                    context,
                                  ).changetimeto(date);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      custommytextform(
                        controller: notes,
                        hintText: "الملاحظات",
                        val: "برجاء ادخال الملاحظات",
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<qcsCubit, qcsState>(
                        listener: (context, state) async {
                          if (state is addqcsuccess) {
                            notes.clear();
                               BlocProvider.of<productioncuibt>(context)
                                        .resetselecteditems();
                                        BlocProvider.of<DateCubit>(context).cleardates();
                            
Navigator.of(context).pop();
                            showtoast(
                                                                                                                context: context,

                              message: state.success_message,
                              toaststate: Toaststate.succes,
                            );
                          }
                          if (state is addqcfailure)
                            showtoast(
                                                                                                                context: context,

                              message: state.error_message,
                              toaststate: Toaststate.error,
                            );
                        },
                        builder: (context, state) {
                          if (state is addqcloading) return loading();
                          return custommaterialbutton(
                            button_name: "تسجيل تقرير",
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                if (BlocProvider.of<productioncuibt>(
                                  context,
                                ).selecteditems.isEmpty) {
                                  showdialogerror(
                                    error: "برجاء اختيار العيب",
                                    context: context,
                                  );
                                } else if (BlocProvider.of<DateCubit>(
                                      context,
                                    ).timefrom ==
                                    "الوقت من") {
                                  showdialogerror(
                                    error: "برجاء اختيار بداية وقت العيب",
                                    context: context,
                                  );
                                } else if (BlocProvider.of<DateCubit>(
                                      context,
                                    ).timeto ==
                                    "الوقت الي") {
                                  showdialogerror(
                                    error: "برجاء اختيار نهاية وقت العيب",
                                    context: context,
                                  );
                                } else
                                  BlocProvider.of<qcsCubit>(context).addqc(
                                    qc: qcmodel(
                                      cause: BlocProvider.of<productioncuibt>(
                                        context,
                                      ).selecteditems,

                                      starttime: BlocProvider.of<DateCubit>(
                                        context,
                                      ).timefrom,
                                      endtime: BlocProvider.of<DateCubit>(
                                        context,
                                      ).timeto,
                                      notes: notes.text,
                                      productname: BlocProvider.of<injectionhallcuibt>(
                            context,
                          ).qcmap[widget.machinenumber]["prodname"],
                                      prodctcolor: BlocProvider.of<injectionhallcuibt>(
                            context,
                          ).qcmap[widget.machinenumber]["prodcolor"],
                                      qcengineer: cashhelper.getdata(
                                        key: "name",
                                      ),
                                      date: BlocProvider.of<DateCubit>(
                                        context,
                                      ).producthalldate,
                                      machinenumber: widget.machinenumber,
                                      docid:'${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${widget.machinenumber}' ,
                                      checktime:
                                          "${DateTime.now().hour}-${DateTime.now().minute}",
                                    ),
                                  );
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
            );
          },
        ),
      ),
    );
  }
}
