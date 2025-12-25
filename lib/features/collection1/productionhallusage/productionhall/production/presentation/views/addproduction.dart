import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/choosedate.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhall/production/data/repos/prodrepoimp.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/data/models/productionmodel.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodcuibt.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/viewmodel/prodstates.dart';
import 'package:cleopatra/features/collection1/productionhallusage/productionhall/production/presentation/views/widgets/radiosreport.dart';

class addusagereport extends StatefulWidget {
  final productionhallmodel production;
  final int reset;
  const addusagereport(
      {super.key, required this.production, required this.reset});
  @override
  State<addusagereport> createState() => _addreportState();
}

class _addreportState extends State<addusagereport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();

  String? x;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اضافة تقرير",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Form(
                key: formkey,
                child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 9),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "نهاية الاوردر",
                            style: TextStyle(
                                fontFamily: "cairo",
                                color: appcolors.maincolor),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          BlocBuilder<productionusagecuibt,
                              productionusagetates>(
                            builder: (context, state) {
                              return radiosreport(
                                  firstradio: "نعم",
                                  secondradio: "لا",
                                  firstradiotitle: "نعم",
                                  secondradiotitle: "لا");
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<DateCubit, DateState>(
                            builder: (context, state) {
                              return choosedate(
                                date: BlocProvider.of<DateCubit>(context)
                                    .producthalldate,
                                onPressed: () {
                                  BlocProvider.of<DateCubit>(context)
                                      .changedatehall(context);
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          custommytextform(
                            controller: quantity,
                            hintText: "كمية الانتاج",
                            val: "برجاء ادخال كمية الانتاج",
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<productionusagecuibt,
                              productionusagetates>(
                            listener: (context, state) async {
                              if (state is productionusagetatesuccess) {
                                if (int.parse(quantity.text) == widget.reset ||
                                    BlocProvider.of<productionusagecuibt>(
                                                context)
                                            .type ==
                                        "نعم") {
                                  await productionhallrepoimplementation()
                                      .editstatus(
                                          productionmodel: widget.production);
                                }

                                BlocProvider.of<productionusagecuibt>(context)
                                    .resest();
                                quantity.clear();

                                BlocProvider.of<DateCubit>(context)
                                    .cleardates();
                                await BlocProvider.of<productionusagecuibt>(
                                        context)
                                    .getproduction(
                                        docid: widget.production.ordernumber);

                                showtoast(
                                                                                                                    context: context,

                                    message: state.success_message,
                                    toaststate: Toaststate.succes);
                              }
                              if (state is productionusagetatefailure)
                                showtoast(
                                                                                                                    context: context,

                                    message: state.error_message,
                                    toaststate: Toaststate.error);
                            },
                            builder: (context, state) {
                              if (state is productionusagetateloading)
                                return loading();
                              return custommaterialbutton(
                                  button_name: "تسجيل تقرير",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      if (int.parse(quantity.text) >
                                          widget.reset)
                                        showdialogerror(
                                            error:
                                                "الكميه المدخله اكبر من الكميه المتبقيه من الاوردر",
                                            context: context);
                                      else
                                        BlocProvider.of<productionusagecuibt>(
                                                context)
                                            .addproduction(
                                                docid: widget
                                                    .production.ordernumber,
                                                productionmodel: productionusagemodel(
                                                    status: int
                                                                .parse(
                                                                    quantity
                                                                        .text) ==
                                                            widget.reset
                                                        ? "نعم"
                                                        : BlocProvider.of<
                                                                    productionusagecuibt>(
                                                                context)
                                                            .type,
                                                    ordernumber:
                                                        "${DateTime.now()}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}",
                                                    date: BlocProvider.of<
                                                            DateCubit>(context)
                                                        .producthalldate,
                                                    quantity: quantity.text));
                                    }
                                  });
                            },
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ])))))))));
  }
}
