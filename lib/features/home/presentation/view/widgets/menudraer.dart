import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';
import 'package:cleopatra/features/collection1/productionhall/production/presentation/views/productiontabbars.dart';
import 'package:cleopatra/features/injections/injectionorders/presentation/views/injectionorders.dart';
import 'package:cleopatra/features/users/presentation/views/widgets/employees.dart';

class menudrawer extends StatelessWidget {
  // final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.newblack2,
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Material(
                        // Replace this child with your own
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: AvatarGlow(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                              imageUrl: cashhelper.getdata(key: "image"),
                              errorWidget: (context, url, Widget) {
                                return const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                );
                              },
                              placeholder: (context, url) {
                                return CircularProgressIndicator();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    cashhelper.getdata(key: "name"),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "cairo",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
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
                      SizedBox(
                        width: 5,
                      ),
                      Text("المستخدمين",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "cairo")),
                      Spacer(),
                      IconButton(
                          onPressed: () async {
                            if (!permession.contains('المستخدمين')) {
                              showdialogerror(
                                  error: "ليس لديك صلاحية الدخول للصفحه",
                                  context: context);
                            } else {
                              navigateto(context: context, page: Employees());
                            }

                            /*   else {
                              auth.isDeviceSupported().then((val) async {
                                if (val) {
                                  bool authonticated = false;
                                  authonticated = await auth.authenticate(
                                    localizedReason:
                                        'Let OS determine authentication method',
                                    options: const AuthenticationOptions(
                                        biometricOnly: true),
                                  );
                                  if (authonticated)
                                    navigateto(
                                        context: context, page: Employees());
                                } else {
                                  navigateto(
                                      context: context, page: Employees());
                                }
                              });
                            }*/
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: appcolors.primarycolor,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                 
                  Row(
                    children: [
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
                      SizedBox(
                        width: 5,
                      ),
                      Text("اوردرات الحقن",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "cairo")),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            if (!permession.contains('اوردرات الحقن')) {
                              showdialogerror(
                                  error: "ليس لديك صلاحية الدخول للصفحه",
                                  context: context);
                            } else
                              navigateto(
                                  context: context, page: Injectionorders());
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: appcolors.primarycolor,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      SizedBox(
                        width: 5,
                      ),
                      Text("اوردرات تجميع اللقمه",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "cairo")),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            if (!permession.contains('اوردرات التجميع')) {
                              showdialogerror(
                                  error: "ليس لديك صلاحية الدخول للصفحه",
                                  context: context);
                            } else
                              navigateto(
                                  context: context, page: Productiontabbars());
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: appcolors.primarycolor,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                
                  Row(
                    children: [
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
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: (() async {}),
                          child: Text("تسجيل الخروج",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "cairo",
                              ))),
                      Spacer(),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) async {
                          if (state is signoutfailure)
                            showdialogerror(
                                error: state.error_message, context: context);
                          if (state is signoutsuccess) {
                           

                            showtoast(
                                                                                                                context: context,

                                message: state.success_message,
                                toaststate: Toaststate.succes);
                            navigateandfinish(
                                context: context, page: newlogin());
                          }
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () async {
                                await BlocProvider.of<AuthCubit>(context)
                                    .signout();
                              },
                              icon: Icon(
                                Icons.logout,
                                color: appcolors.primarycolor,
                              ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ]),
          Positioned(
            child: CircleAvatar(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: () {
                          ZoomDrawer.of(context)!.close();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: appcolors.primarycolor,
                          size: 30,
                        )),
                  )),
              radius: 50,
              backgroundColor: Colors.white,
            ),
            right: -50,
            top: 50,
          )
        ],
      ),
    );
  }
}
