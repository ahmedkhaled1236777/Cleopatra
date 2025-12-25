import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/auth/login/presentation/views/widgets/mypath.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';

class newresetpassword extends StatefulWidget {
  @override
  State<newresetpassword> createState() => _newresetpasswordState();
}

class _newresetpasswordState extends State<newresetpassword> {
  double elevation = 10;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController confirmemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              ClipPath(
                clipper: mypath(),
                child: Container(
                    color: appcolors.maincolor,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Padding(
                        padding: EdgeInsets.only(
                            bottom: (MediaQuery.of(context).size.height * 0.1)),
                        child: const Image(
                          image: AssetImage(
                            "assets/images/cleopatrahome.png",
                          ),
                          fit: BoxFit.fill,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: elevation,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null)
                            return "برجاء ادخال البريد الالكتروني";
                        },
                        controller: email,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: appcolors.primarycolor,
                            ),
                            filled: true,
                            hintText: "البريد الالكتروني",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: elevation,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null)
                            return "برجاء تاكيد البريد الالكتروني";
                        },
                        controller: confirmemail,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: appcolors.primarycolor,
                            ),
                            filled: true,
                            hintText: "تاكيد البريد الالكتروني",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appcolors.primarycolor),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is resetpassfailure)
                          showdialogerror(
                              error: state.error_message, context: context);
                        if (state is resetpasssuccess) {
                          showtoast(
                                                           context: context,

                              message: state.success_message,
                              toaststate: Toaststate.succes);
                          navigateandfinish(context: context, page: newlogin());
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is resetpassloading) return loading();
                        return custommaterialbutton(
                          button_name: "اعادة تعيين كلمة المرور",
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (email.text == confirmemail.text) {
                                await BlocProvider.of<AuthCubit>(context)
                                    .resetpass(email: email.text);
                              } else {
                                showdialogerror(
                                    error: "يوجد اختلاف في البريد الالكتروني",
                                    context: context);
                              }
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 400,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
