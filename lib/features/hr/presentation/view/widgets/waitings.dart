import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/error.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/hr/presentation/view/widgets/radios.dart';
import 'package:cleopatra/features/hr/presentation/viewmodel/hr/hr_cubit.dart';

class waitings extends StatefulWidget {
  @override
  State<waitings> createState() => _waitingsState();
}

class _waitingsState extends State<waitings> {
  getdata() async {
    await BlocProvider.of<HrCubit>(context).getwaintings(
        monthyear:
            "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year}");
  }

  @override
  void initState() {
    getdata();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "الانتظار",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: BlocBuilder<HrCubit, HrState>(
          builder: (context, state) {
            if (state is getallwaitingsloading) return loadingshimmer();
            if (state is getallattendancefailure)
              return errorfailure(errormessage: state.errormessage);
            return BlocProvider.of<HrCubit>(context).waitings.isEmpty
                ? nodata()
                : Container(
                    margin: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 9, top: 15),
                      child: ListView.separated(
                        itemBuilder: (context, i) {
                          return Slidable(
                            closeOnScroll: true,
                            startActionPane: ActionPane(
                                extentRatio: 0.9,
                                motion: ScrollMotion(),
                                children: [
                                  Expanded(
                                    child: waitingradioradios(
                                      firstradio: "مقبوله",
                                      secondradio: "مرفوضه",
                                      firstradiotitle: "مقبوله",
                                      secondradiotitle: "مرفوضه",
                                      groupvalue:
                                          BlocProvider.of<HrCubit>(context)
                                              .waitingstatus[i],
                                      index: i,
                                    ),
                                  ),
                                  BlocConsumer<HrCubit, HrState>(
                                    listener: (context, state) {
                                      if (state is deletewaitingsfailure &&
                                          i == index) {
                                        showtoast(
                                                                                                                            context: context,

                                            message: state.errormessage,
                                            toaststate: Toaststate.error);
                                      }
                                      if (state is deletewaitingssuccess &&
                                          i == index) {
                                        showtoast(
                                                                                                                            context: context,

                                            message: state.successmessage,
                                            toaststate: Toaststate.succes);
                                      }
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      if (state is deletewaitingsloading &&
                                          i == index) return loading();
                                      return custommaterialbutton(
                                        color: appcolors.maincolor,
                                        button_name: "تاكيد",
                                        onPressed: () async {
                                          index = i;
                                          BlocProvider.of<HrCubit>(context)
                                              .editwaintings(
                                                  monthyear:
                                                      "${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year}",
                                                  waiting:
                                                      BlocProvider.of<HrCubit>(
                                                              context)
                                                          .waitings[i],
                                                  status:
                                                      BlocProvider.of<HrCubit>(
                                                              context)
                                                          .waitingstatus[i]);
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ]),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: appcolors.primarycolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: appcolors.drofpcolor,
                                      radius: 20,
                                      child: Text(
                                          style: textStyle,
                                          BlocProvider.of<HrCubit>(context)
                                              .waitings[i]
                                              .type),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .name,
                                            style: textStyle),
                                        Text(
                                            BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .date,
                                            style: textStyle),
                                        if (BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .money !=
                                            0)
                                          Text(
                                              "المبلغ : ${BlocProvider.of<HrCubit>(context).waitings[i].money}",
                                              style: textStyle),
                                        if (BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .starthour !=
                                            "لا يوجد")
                                          Text(
                                              "الوقت من : ${BlocProvider.of<HrCubit>(context).waitings[i].starthour}",
                                              style: textStyle),
                                        if (BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .timeto !=
                                            "لا يوجد")
                                          Text(
                                              "الوقت الى : ${BlocProvider.of<HrCubit>(context).waitings[i].timeto}",
                                              style: textStyle),
                                      ],
                                    ))
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, i) => Divider(
                          color: Colors.grey,
                        ),
                        itemCount:
                            BlocProvider.of<HrCubit>(context).waitings.length,
                      ),
                    ));
          },
        ),
      ),
    );
  }
}

/* Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: appcolors.primarycolor)),
                                  child: Row(
                                    children: [
                                      const Text("التاريخ",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      const Text(" : ",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      Expanded(
                                        child: Text(
                                            BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .date,
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: appcolors.primarycolor)),
                                  child: Row(
                                    children: [
                                      const Text("الاسم",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      const Text(" : ",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      Expanded(
                                        child: Text(
                                            BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .name,
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: appcolors.primarycolor)),
                                  child: Row(
                                    children: [
                                      const Text("الطلب",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      const Text(" : ",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              fontSize: 12.5,
                                              color: appcolors.maincolor)),
                                      Expanded(
                                        child: Text(
                                            BlocProvider.of<HrCubit>(context)
                                                .waitings[i]
                                                .type,
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                      )
                                    ],
                                  ),
                                ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .money !=
                                    0)
                                  SizedBox(
                                    height: 7,
                                  ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .money !=
                                    0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: appcolors.primarycolor)),
                                    child: Row(
                                      children: [
                                        const Text("المبلغ",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        const Text(" : ",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        Expanded(
                                          child: Text(
                                              BlocProvider.of<HrCubit>(context)
                                                  .waitings[i]
                                                  .money
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "cairo",
                                                  fontSize: 12.5,
                                                  color: appcolors.maincolor)),
                                        )
                                      ],
                                    ),
                                  ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .starthour !=
                                    "لا يوجد")
                                  SizedBox(
                                    height: 7,
                                  ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .starthour !=
                                    "لا يوجد")
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: appcolors.primarycolor)),
                                    child: Row(
                                      children: [
                                        const Text("من",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        const Text(" : ",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        Expanded(
                                          child: Text(
                                              BlocProvider.of<HrCubit>(context)
                                                  .waitings[i]
                                                  .starthour
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "cairo",
                                                  fontSize: 12.5,
                                                  color: appcolors.maincolor)),
                                        )
                                      ],
                                    ),
                                  ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .timeto !=
                                    "لا يوجد")
                                  SizedBox(
                                    height: 7,
                                  ),
                                if (BlocProvider.of<HrCubit>(context)
                                        .waitings[i]
                                        .timeto !=
                                    "لا يوجد")
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: appcolors.primarycolor)),
                                    child: Row(
                                      children: [
                                        const Text("الى",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        const Text(" : ",
                                            style: TextStyle(
                                                fontFamily: "cairo",
                                                fontSize: 12.5,
                                                color: appcolors.maincolor)),
                                        Expanded(
                                          child: Text(
                                              BlocProvider.of<HrCubit>(context)
                                                  .waitings[i]
                                                  .timeto
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: "cairo",
                                                  fontSize: 12.5,
                                                  color: appcolors.maincolor)),
                                        )
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: appcolors.primarycolor)),
                                    child: waitingradioradios(
                                      firstradio: "مقبوله",
                                      secondradio: "مرفوضه",
                                      firstradiotitle: "مقبوله",
                                      secondradiotitle: "مرفوضه",
                                      groupvalue:
                                          BlocProvider.of<HrCubit>(context)
                                              .waitingstatus[i],
                                      index: i,
                                    )),
                                SizedBox(
                                  height: 7,
                                )
                              ],
                            ),*/
TextStyle textStyle =
    TextStyle(fontFamily: "cairo", fontSize: 12.5, color: Colors.white);
