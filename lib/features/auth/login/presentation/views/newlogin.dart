import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/constants.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/auth/login/presentation/views/widgets/newsignup.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';
import 'package:cleopatra/features/home/presentation/view/widgets/home.dart';

class newlogin extends StatefulWidget {
  @override
  State<newlogin> createState() => _newloginState();
}

class _newloginState extends State<newlogin> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool x = true;
  double elevation = 10;

  bool isloading = false;

  var ico = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          
            backgroundColor:Colors.black,
            body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
         
        ),
        child: Center(
              child: Container(
                        height: MediaQuery.sizeOf(context).height,
                        margin: EdgeInsets.all(
              MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
                        ),
                        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
              ),
                        ),
                        width:
                MediaQuery.sizeOf(context).width > 650
                    ? MediaQuery.sizeOf(context).width * 0.4
                    : double.infinity,
                        child: Form(
                            key: formkey,
                            child: Column(children: [
                              SizedBox(height: 60,),
                              Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.35,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              (MediaQuery.of(context).size.height * 0.1)),
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/cleopatrahome.png",
                                        ),
                                        fit: BoxFit.fill,
                                      ))),
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 15, right: 15),
                                          child: Column(children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty )
                                                  return "من فضلك ادخال البريد الالكتروني";
                                              },
                                              controller: email,
                                              decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: appcolors.primarycolor),
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: appcolors.primarycolor),
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: appcolors.primarycolor,
                                                ),
                                                filled: true,
                                                hintStyle: TextStyle(
                                                    fontFamily: "cairo",
                                                    color: appcolors.maincolor),
                                                hintText: "البريد الالكتروني",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                    borderSide: BorderSide(
                                                      color: appcolors.primarycolor,
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty ) {
                                                  elevation = 0;
                                                  setState(() {});
                                                  return "من فضلك ادخل كلمة المرور";
                                                }
                                              },
                                              controller: password,
                                              obscureText: x,
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: appcolors.primarycolor),
                                                      borderRadius:
                                                          BorderRadius.circular(30)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: appcolors.primarycolor),
                                                      borderRadius:
                                                          BorderRadius.circular(30)),
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: appcolors.primarycolor,
                                                  ),
                                                  suffixIcon: IconButton(
                                                      onPressed: (() {
                                                        ico = ico == Icons.visibility
                                                            ? Icons.visibility_off
                                                            : Icons.visibility;
                                                        x == true ? x = false : x = true;
                        
                                                        setState(() {});
                                                      }),
                                                      icon: Icon(ico,
                                                          color: appcolors.primarycolor)),
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      fontFamily: "cairo",
                                                      color: appcolors.maincolor),
                                                  hintText: "كلمة المرور",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: appcolors.primarycolor),
                                                      borderRadius:
                                                          BorderRadius.circular(30))),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                         
                                            
                                            BlocConsumer<AuthCubit, AuthState>(
                                              listener: (context, state) async {
                                                if (state is loginfailure) {
                                                  showdialogerror(
                                                      error: state.error_message,
                                                      context: context);
                                                }
                                                if (state is loginsuccess) {
                                                  if (state.signmodelrequest.block) {
                                                    showdialogerror(
                                                        error:
                                                            "ليس لديك صلاحية الدخول للتطبيق",
                                                        context: context);
                                                  } else {
                                                    permession = List<String>.from(
                                                        state.signmodelrequest.permessions);
                                                    cashhelper.setdata(
                                                        key: "email",
                                                        value:
                                                            state.signmodelrequest.email);
                                                    cashhelper.setdata(
                                                        key: "permissions",
                                                        value: List<String>.from(state
                                                            .signmodelrequest.permessions));
                                                    cashhelper.setdata(
                                                        key: "isadmin",
                                                        value:
                                                            state.signmodelrequest.admin);
                                                    cashhelper.setdata(
                                                        key: "phone",
                                                        value:
                                                            state.signmodelrequest.phone);
                                                    cashhelper.setdata(
                                                        key: "name",
                                                        value: state.signmodelrequest.name);
                                                    cashhelper.setdata(
                                                        key: "job",
                                                        value: state.signmodelrequest.job);
                                                    cashhelper.setdata(
                                                        key: "image",
                                                        value: state.signmodelrequest.img);
                                                    cashhelper.setdata(
                                                        key: "block",
                                                        value:
                                                            state.signmodelrequest.block);
                                                    cashhelper.setdata(
                                                        key: "save", value: true);
                                                    showtoast(
                                                                      context: context,                     
                        
                                                        message: "تم تسجيل الدخول بنجاح",
                                                        toaststate: Toaststate.succes);
                                                    navigateandfinish(
                                                        context: context, page: home());
                                                  }
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state is loginloading) return loading();
                                                return custommaterialbutton(
                                                  button_name: "تسجيل الدخول",
                                                  onPressed: () async {
                                                    if (formkey.currentState!.validate())
                                                      await BlocProvider.of<AuthCubit>(
                                                              context)
                                                          .sign(
                                                              email: email.text,
                                                              pass: password.text);
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(height: 22,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                "لا امتلك حساب ؟",
                                                  style: TextStyle(
                                                      fontFamily: "cairo",
                                                      color: Colors.white),
                                                ),
                                                TextButton(
                                                  onPressed: (() {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: ((context) {
                                                      return newsignup();
                                                    })));
                                                  }),
                                                  child: Text("انشاء حساب",
                                                      style: TextStyle(
                                                          color: appcolors.primarycolor,
                                                          fontFamily: "cairo")),
                                                ),
                                              ],
                                            ),
                                          ]))))
                            ]))),
            ))));
  }
}
