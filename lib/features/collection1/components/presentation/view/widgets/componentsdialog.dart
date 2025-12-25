import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/customtablesubcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';

class Componentsdialog extends StatefulWidget {
  final int qty;
  final String prodname;

  Componentsdialog({super.key, required this.prodname, required this.qty});

  @override
  State<Componentsdialog> createState() => _ComponentsdialogState();
}

class _ComponentsdialogState extends State<Componentsdialog> {
  final componentsheader = [
    "اسم المكون",
    "الكميه اللازمه للاوردر",
    "اجمالي الوزن(جرام)"
  ];
  getdata() async {
    await BlocProvider.of<componentCubit>(context)
        .getcsubomponents(componentname: widget.prodname);
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 200,
          child: Row(
              children: componentsheader
                  .map((e) => Expanded(
                        flex: 3,
                        child: Text(
                          e,
                          style: TextStyle(
                              color: appcolors.drofpcolor, fontFamily: "cairo"),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Divider(
            color: appcolors.primarycolor,
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 200,
            child: BlocConsumer<componentCubit, componentState>(
                listener: (context, state) {
              if (state is getsubcomponentfailure)
                showtoast(
                                                                      context: context,

                    message: state.errormessage, toaststate: Toaststate.error);
            }, builder: (context, state) {
              if (state is getsubcomponentloadding) return loadingshimmer();
              if (state is getsubcomponentfailure)
                return SizedBox();
              else {
                if (BlocProvider.of<componentCubit>(context)
                    .subcomponents
                    .isEmpty)
                  return nodata();
                else {
                  return ListView.separated(
                      itemBuilder: (context, i) => customtablesubcomponentitem(
                            name: BlocProvider.of<componentCubit>(context)
                                .subcomponents[i]
                                .name,
                            weigt: (double.parse(
                                        BlocProvider.of<componentCubit>(context)
                                            .subcomponents[i]
                                            .weight) *
                                    (double.parse(
                                            BlocProvider.of<componentCubit>(
                                                    context)
                                                .subcomponents[i]
                                                .qty) *
                                        widget.qty))
                                .toStringAsFixed(2),
                            quantaity: (double.parse(
                                        BlocProvider.of<componentCubit>(context)
                                            .subcomponents[i]
                                            .qty) *
                                    widget.qty)
                                .toString(),
                          ),
                      separatorBuilder: (context, i) => Divider(
                            color: appcolors.maincolor,
                          ),
                      itemCount: BlocProvider.of<componentCubit>(context)
                          .subcomponents
                          .length);
                }
              }
            }),
          ),
        ),
      ],
    );
  }
}
