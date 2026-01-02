import 'dart:io';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/navigation.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';
import 'package:cleopatra/features/auth/login/presentation/views/newlogin.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';
import 'package:path/path.dart';

class newsignup extends StatefulWidget {
  @override
  State<newsignup> createState() => _newsignupState();
}

class _newsignupState extends State<newsignup> {
  double elevation = 10;
  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController job = TextEditingController();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  var ic = Icons.visibility;
  bool obsecure = false;
  File? image;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget showcircle = Text(
    "انشاء حساب",
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white, fontFamily: "cairo", fontSize: 20),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.dropcolor,
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == null)
                                  return "برجاء ادخال اسم المستخدم";
                                ;
                              },
                              controller: username,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: appcolors.primarycolor,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(fontFamily: "cairo"),
                                  hintText: "اسم المستخدم",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == null)
                                  return "برجاء ادخال رقم الهاتف";
                              },
                              controller: phone,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: appcolors.primarycolor,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(fontFamily: "cairo"),
                                  hintText: "رقم الهاتف",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "برجاء ادخال البريد الالكترونى";
                              },
                              controller: email,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: appcolors.primarycolor,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(fontFamily: "cairo"),
                                  hintText: "البريد الالكتروني",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "برجاء ادخال الوظيفه";
                              },
                              controller: job,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  prefixIcon: Icon(
                                    Icons.biotech_rounded,
                                    color: appcolors.primarycolor,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(fontFamily: "cairo"),
                                  hintText: "الوظيفه",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: obsecure,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "برجاء ادخال كلمة المرور";
                              },
                              controller: password,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(30)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        obsecure == false
                                            ? obsecure = true
                                            : obsecure = false;
                                        ic == Icons.visibility
                                            ? ic = Icons.visibility_off
                                            : ic = Icons.visibility;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        ic,
                                        color: appcolors.primarycolor,
                                      )),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "كلمة المرور",
                                  hintStyle: TextStyle(fontFamily: "cairo"),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: appcolors.primarycolor),
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is signupfailure) {
                                  showtoast(
                                    context: context,
                                      message: state.errormessage,
                                      toaststate: Toaststate.error);
                                }
                                if (state is signupsuccess) {
                                  email.clear();
                                  username.clear();
                                  password.clear();
                                  phone.clear();
                                  image = null;
                                  navigateandfinish(
                                      context: context, page: newlogin());
                                }
                              },
                              builder: (context, state) {
                                if (state is signuploading) return loading();
                                return MaterialButton(
                                  onPressed: (() async {
                                    if (formkey.currentState!.validate()) {
                                      try {
                                        final plainText = password.text;

                                        final key = en.Key.fromBase64(
                                            'yE9tgqNxWcYDTSPNM+EGQw==');
                                        ;
                                        final iv = en.IV.fromBase64(
                                            '8PzGKSMLuqSm0MVbviaWHA==');
                                        final encrypter =
                                            en.Encrypter(en.AES(key));

                                        final encrypted = encrypter
                                            .encrypt(plainText, iv: iv);
                                        /*    var imagename = basename(image!.path);
                                        var ref = FirebaseStorage.instance
                                            .ref("images/${imagename}");
                                        await ref.putFile(image!);
                                        String url = await ref.getDownloadURL();*/

                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .signup(
                                                signup: Signmodelrequest(
                                                    admin: false,
                                                    job: job.text,
                                                    email: email.text,
                                                    phone: phone.text,
                                                    name: username.text,
                                                    img:
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFLYtxj-tne8GF3mErRrfyPwjRAr2VIkV5Ou0GWd8&s",
                                                    block: true,
                                                    password: encrypted.base64,
                                                    permessions: ["لا يوجد"]));
                                        /* print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                                                final decrypted = encrypter.decrypt(
                                                                    en.Encrypted.fromBase64(
                                                                        "C6VgVEh+/ZDfYL4PJrbDe0xbvZKCWb/lQ=="),
                                                                    iv: iv);*/
                                      } catch (e) {}
                                    }
                                  }),
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: appcolors.primarycolor),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      child: showcircle),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تمتلك حساب ؟",
                                  style: TextStyle(
                                      fontFamily: "cairo", color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: (() {
                                    navigateandfinish(
                                        context: context, page: newlogin());
                                  }),
                                  child: Text("تسجيل الدخول",
                                      style: TextStyle(
                                          fontFamily: "cairo",
                                          color: appcolors.primarycolor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
