import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/loading.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/core/common/widgets/showdialogerror.dart';
import 'package:cleopatra/features/mold/molds/presentation/views/widgets/alertmoldcontent.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_cubit.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/viewmodel/moldsusage/moldsusage_state.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/addmold.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/widgets/alert.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/widgets/customtablemolditem.dart';

import 'package:provider/provider.dart';

class moldusages extends StatefulWidget {
  @override
  State<moldusages> createState() => _moldusagesState();
}

class _moldusagesState extends State<moldusages> {
  final moldusagesheader = [
    "اسم الاسطمبه",
    "عدد الكبسات",
  ];

  getdata() async {
    await BlocProvider.of<moldusagesCubit>(context).getmoldusages();
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (cashhelper.getdata(key: "email") !=
                      "ahmedaaallam123@gmail.com")
                    showdialogerror(
                        error: "ليس لديك صلاحية اضافة التقارير",
                        context: context);
                  else
                    navigateto(context: context, page: Addmoldusage());
                }),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<moldusagesCubit>(context).resetsearch();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Container(
                                height: 20,
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: appcolors.maincolor,
                                    )),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.all(35),
                              content: Alertmoldusagecontent(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "استهلاك الاسطمبات",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: moldusagesheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تحديد" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<moldusagesCubit, moldusagesState>(
                    listener: (context, state) {
                  if (state is getmoldusagefailure)
                    showtoast(
                                                                                                        context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is getmoldusageloading) return loadingshimmer();
                  if (state is getmoldusagefailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<moldusagesCubit>(context)
                        .mymoldusages
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: customtablemoldusageitem(
                                  moldname:
                                      BlocProvider.of<moldusagesCubit>(context)
                                          .mymoldusages[i]
                                          .moldname,
                                  numberofuses:
                                      BlocProvider.of<moldusagesCubit>(context)
                                          .mymoldusages[i]
                                          .numberofuses
                                          .toString(),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<moldusagesCubit>(context)
                              .mymoldusages
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
