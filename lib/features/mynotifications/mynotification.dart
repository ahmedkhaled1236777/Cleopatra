/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';

class Mynotification extends StatelessWidget {
  final int counter;

  const Mynotification({super.key, required this.counter});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "الاشعارات",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: FirestorePagination(
          limit: 10, // Defaults to 10.
          viewType: ViewType.list,
          bottomLoader: loading(),
          query: FirebaseFirestore.instance
              .collection('notifications')
              .orderBy('timestamp', descending: true),
          itemBuilder: (context, documentSnapshot, index) {
            final data =
                documentSnapshot[index].data() as Map<String, dynamic>?;
            if (data == null) return Container();

            return Column(
              children: [
                Container(
                    color: index < counter
                        ? const Color.fromARGB(255, 66, 66, 66)
                        : Colors.white,
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage("assets/images/mmm.jpg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                data["content"],
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "cairo",
                                    color: index < counter
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    data["date"],
                                    style: TextStyle(
                                        fontFamily: "cairo",
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    data["time"],
                                    style: TextStyle(
                                        fontFamily: "cairo",
                                        color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Divider(
                  color: Colors.grey,
                )
              ],
            );
          },
        ));
  }
}
*/
