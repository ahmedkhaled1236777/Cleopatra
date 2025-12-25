import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/collection1/average/presentation/view/average.dart';
import 'package:cleopatra/features/collection1/components/presentation/view/components.dart';
import 'package:cleopatra/features/injections/injectionmachines/presentation/view/injectionmachines.dart';
import 'package:cleopatra/features/mold/moldmaintenance/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/mold/molduse/molds/presentation/views/molds.dart';
import 'package:cleopatra/features/injections/injection/presentation/views/widgets/widgets/adddiagnoseandfix.dart';
import 'package:cleopatra/features/collection1/workers.dart/presentation/view/workers.dart';

class newsettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            color: Colors.black,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "الصفحات",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "cairo"),
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: appcolors.newblack2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "المنتجات ومكونات اللقمه",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('اضافة منتج'))
                                    navigateto(
                                        context: context, page: components());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "صيانه الاسطمبات",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('صيانة الاسطمبات'))
                                    navigateto(
                                        context: context, page: maintenances());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "اضافة عطل",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('اضافة عطل'))
                                    navigateto(
                                        context: context,
                                        page: Adddiagnoseandfix());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "عمال اللقمه",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('عرض العمال'))
                                    navigateto(
                                        context: context, page: Workers());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                     
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "معدلات عمال اللقمه",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('معدلات العمال'))
                                    navigateto(
                                        context: context, page: Average());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                               Container(
                                width: 2,
                                color: appcolors.primarycolor,
                                height: 50,
                              )
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "استهلاك الاسطمبات",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (permession.contains('استهلاك الاسطمبات'))
                                    navigateto(
                                        context: context, page: moldusages());
                                  else
                                    showdialogerror(
                                        error: "ليس لديك صلاحية الدخول للصفحه",
                                        context: context);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: appcolors.primarycolor,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 11,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: appcolors.primarycolor,
                                  ),
                                ),
                              ),
                            
                            ]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "ماكينات الحقن",
                              style: TextStyle(
                                  fontFamily: "cairo",
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                    navigateto(
                                        context: context, page: injectionmachines());
                                 
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: appcolors.primarycolor,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
