import 'dart:io';
import 'package:path/path.dart' as pa;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/auth/login/presentation/viwmodel/auth/auth_cubit.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? image;

  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return MediaQuery.sizeOf(context).width>600? Scaffold
    
    
    (
      
       appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "الاعدادات",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:  Center(
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
                          child:Container(
        color: appcolors.dropcolor,
        child: Stack(
          children: [
            Column(
              children: [
              
                SizedBox(
                  height: 250,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"الاسم"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "name"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"رقم الهاتف"} : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "cairo",
                                ),
                              ),
                              Text(
                                cashhelper.getdata(key: "phone"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"البريد الالكتروني"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "email"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"الوظيفه"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "job"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
              top: h * 0.25 - 50,
              left: w * 0.5 - 60,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: image != null
                        ? CircleAvatar(
                            radius: 55, backgroundImage: FileImage(image!))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: SizedBox(
                              height: 110,
                              width: 110,
                              child: CachedNetworkImage(
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
                          )),
                IconButton(
                    onPressed: () async {
                      var imag = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (imag != null) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Center(child: CircularProgressIndicator());
                            });
                        image = File(imag.path);

                        var imagename = pa.basename(image!.path);
                        var ref =
                            FirebaseStorage.instance.ref("images/${imagename}");
                        await ref.putFile(image!);
                        String url = await ref.getDownloadURL();
                        if (cashhelper.getdata(key: "image") !=
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbmB8QjPQMaiVi3yB0IckvPI1yiaYQLaAQ4g&usqp=CAU")
                          await FirebaseStorage.instance
                              .refFromURL(cashhelper.getdata(key: "image"))
                              .delete();
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(cashhelper.getdata(key: "email"))
                            .update({"image": url});
                        cashhelper.setdata(key: "image", value: url);

                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ))
              ]),
            ),
          ],
        )))))):Container(
        color: appcolors.dropcolor,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "الملف الشخصي",
                  style: TextStyle(
                      fontFamily: "cairo",
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 250,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"الاسم"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "name"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"رقم الهاتف"} : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "cairo",
                                ),
                              ),
                              Text(
                                cashhelper.getdata(key: "phone"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"البريد الالكتروني"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "email"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${"الوظيفه"} : ",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                              ),
                              Text(
                                cashhelper.getdata(key: "job"),
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "cairo"),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            Positioned(
              top: h * 0.25 - 50,
              left: w * 0.5 - 60,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: image != null
                        ? CircleAvatar(
                            radius: 55, backgroundImage: FileImage(image!))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: SizedBox(
                              height: 110,
                              width: 110,
                              child: CachedNetworkImage(
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
                          )),
                IconButton(
                    onPressed: () async {
                      var imag = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (imag != null) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Center(child: CircularProgressIndicator());
                            });
                        image = File(imag.path);

                        var imagename = pa.basename(image!.path);
                        var ref =
                            FirebaseStorage.instance.ref("images/${imagename}");
                        await ref.putFile(image!);
                        String url = await ref.getDownloadURL();
                        if (cashhelper.getdata(key: "image") !=
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbmB8QjPQMaiVi3yB0IckvPI1yiaYQLaAQ4g&usqp=CAU")
                          await FirebaseStorage.instance
                              .refFromURL(cashhelper.getdata(key: "image"))
                              .delete();
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(cashhelper.getdata(key: "email"))
                            .update({"image": url});
                        cashhelper.setdata(key: "image", value: url);

                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ))
              ]),
            ),
          ],
        ));
  }
}
