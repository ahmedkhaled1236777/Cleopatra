import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/date/date_cubit.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/headerwidget.dart';
import 'package:cleopatra/core/common/widgets/nodata.dart';
import 'package:cleopatra/core/common/widgets/shimmerloading.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/addcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/alertcontent.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/editdialog.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/customtableedit.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/getsubcomponent.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/widgets/videoplay.dart';
import 'package:cleopatra/features/collection1/components/presentation/viewmodel/components/components_cubit.dart';
import 'package:share_plus/share_plus.dart';

class components extends StatefulWidget {
  @override
  State<components> createState() => _componentsState();
}

class _componentsState extends State<components> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final componentsheader = [
    "اسم المنتج",
    "تعديل",
  ];

  getdata() async {
    await BlocProvider.of<componentCubit>(context).getcomponents();
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
                  navigateto(context: context, page: Addcomponent());
                }),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<componentCubit>(context)
                          .resetcomponents();
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
                                      BlocProvider.of<DateCubit>(context)
                                          .cleardates();

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
                              content: Alertcomponenycontent(),
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
                "المكونات",
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
                    children: componentsheader
                        .map((e) => customheadertable(
                              title: e,
                              flex: e == "تعديل" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<componentCubit, componentState>(
                    listener: (context, state) {
                  if (state is componentfailure)
                    showtoast(
                                                                          context: context,

                        message: state.error_message,
                        toaststate: Toaststate.error);
                }, builder: (context, state) {
                  if (state is componentloading) return loadingshimmer();
                  if (state is componentfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<componentCubit>(context)
                        .components
                        .isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  navigateto(
                                      context: context,
                                      page: subcomponents(
                                          componentname:
                                              BlocProvider.of<componentCubit>(
                                                      context)
                                                  .components[i]
                                                  .name));
                                },
                                child: customtablecomponentitem(
                                 
                                  name: BlocProvider.of<componentCubit>(context)
                                      .components[i]
                                      .name,
                              
                                  edit: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Container(
                                                  height: 20,
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color:
                                                            appcolors.maincolor,
                                                      )),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                content: editdialog(
                                                    componentsmode: BlocProvider
                                                            .of<componentCubit>(
                                                                context)
                                                        .components[i]),
                                              );
                                            });
                                      },
                                      icon: Icon(editeicon)),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<componentCubit>(context)
                              .components
                              .length);
                    }
                  }
                }),
              )),
            ])));
  }
}
  Future<void> _launchUrl(String url,String prodname) async {
    final shareText = 'تجميع ${prodname} : $url';
       Share.share(shareText,);

  }