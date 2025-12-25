import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/time.dart';
import 'package:cleopatra/features/injections/injection/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/diagnoses.dart';
import 'package:cleopatra/features/qc/data/models/qcmodel.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_cubit.dart';
import 'package:cleopatra/features/qc/presentation/viewmodel/viewmodel/cubit/qc_state.dart';



class editqcdialog extends StatelessWidget {
   final TextEditingController notes ;
final  qcmodel qc ;
final DateTime starttime;
final DateTime endtime;

 GlobalKey<FormState>formkey=GlobalKey<FormState>();
  editqcdialog(
      {super.key,
      required this.endtime,required this.starttime,
      required this.qc,required this.notes});

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
             Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xff2BA4C8), width: 0.5)),
                                child: Diagnoses(),
                              ),
                      const SizedBox(
                        height: 10,
                      ),
                   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "وقت نهاية العيب",
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Time(
                                inittime: endtime,
                                onChange: (date) {
                                  BlocProvider.of<DateCubit>(context)
                                      .changetimefrom(date);
                                },
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "وقت بداية العيب",
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Time(
                                inittime: starttime,
                                onChange: (date) {
                                  BlocProvider.of<DateCubit>(context)
                                      .changetimeto(date);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      custommytextform(
                        controller: notes,
                        hintText: "الملاحظات",
                        val: "برجاء ادخال الملاحظات",
                      ),
                SizedBox(
                  height: 20,
                ),
          BlocConsumer<qcsCubit, qcsState>(
                        listener: (context, state) async {
                          if (state is updateqcsuccess) {
                            notes.clear();
Navigator.pop(context);
                               

                            showtoast(
                                                                                                                context: context,

                                message: state.success_message,
                                toaststate: Toaststate.succes);
                          }
                          if (state is updateqcfailure)
                            showdialogerror(
                                error: state.error_message,
                                context: context);
                        },
                        builder: (context, state) {
                          if (state is updateqcloading)
                            return loading();
                          return custommaterialbutton(
                              button_name: "تسجيل تقرير",
                              onPressed: () async {
                                  if (formkey.currentState!.validate()) {
if(BlocProvider.of<productioncuibt>(context)
                                                        .selecteditems.isEmpty){
                                                          showdialogerror(error: "برجاء اختيار العيب", context: context);
                                                        }
                                      else if (BlocProvider.of<DateCubit>(context)
                                              .timefrom ==
                                          "الوقت من") {
                                        showdialogerror(
                                            error: "برجاء اختيار بداية الوقت",
                                            context: context);
                                      } else if (BlocProvider.of<DateCubit>(
                                                  context)
                                              .timeto ==
                                          "الوقت الي") {
                                        showdialogerror(
                                            error: "برجاء اختيار نهاية الوقت",
                                            context: context);
                                      } 
                                      
                                      
                                      else
                                        BlocProvider.of<qcsCubit>(
                                                context)
                                            .updatqcs(
                                                qc:
                                                    qcmodel(
                                                      cause:BlocProvider.of<productioncuibt>(context)
                                                        .selecteditems ,
                                               
                                          starttime: BlocProvider.of<DateCubit>(
                                                  context)
                                              .timefrom,
                                          endtime: BlocProvider.of<DateCubit>(
                                                  context)
                                              .timeto,
                                          notes: notes.text,
                                          docid: qc.docid,
                                          productname: qc.productname,
                                          prodctcolor: qc.prodctcolor,
                                          qcengineer: cashhelper.getdata(key: "name"),
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
                                              .producthalldate,
                                          machinenumber: qc.machinenumber,
                                          checktime: qc.checktime,
                                        ));
                                
                                  
                                  
                                  
                                  }});
                        }
                        
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
