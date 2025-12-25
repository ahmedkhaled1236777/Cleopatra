import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

awsomdialogerror({
  required BuildContext context,
  required Widget mywidget,
  required String tittle,
}) {
  showGeneralDialog(
    context: context,
    pageBuilder: ((context, animation, secondaryAnimation) {
      return SizedBox();
    }),
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AlertDialog(
                insetPadding: EdgeInsets.only(left: 13,right: 12),
                contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  width:  MediaQuery.sizeOf(context).width>600?MediaQuery.sizeOf(context).width*0.25:MediaQuery.sizeOf(context).width,
                  height: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "! تنبيــــه",
                        style: const TextStyle(
                                                                                        fontFamily: "cairo",

                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        tittle,
                        style: const TextStyle(fontSize: 12           ,                                                   fontFamily: "cairo",
),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                
                                  style:  ButtonStyle(
                                    
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xffc21a15)),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "الغاء",
                                    style: TextStyle(
                                                                                                    fontFamily: "cairo",
                              
                                        fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            mywidget
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.sizeOf(context).height - 125) / 2 - 70,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child:
                      Lottie.asset(width: 78, height: 78, "assets/images/sasa.json"),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
  /* showDialog(
      context: context,
      builder: ((context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width > 950
                    ? MediaQuery.sizeOf(context).width * 0.25
                    : MediaQuery.sizeOf(context).width > 650
                        ? MediaQuery.sizeOf(context).width * 0.55
                        : MediaQuery.sizeOf(context).width,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tittle,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "الغاء",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 37, 163, 42)),
                              ),
                              onPressed: btnOkOnPress,
                              child: const Text(
                                "تاكيد",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "!",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              top: (MediaQuery.sizeOf(context).height - 100) / 2 - 70,
            )
          ],
        );
      }));*/

  /* AwesomeDialog(
                                    width: MediaQuery.sizeOf(context).width>950?MediaQuery.sizeOf(context).width*0.35:
                                     MediaQuery.sizeOf(context).width>650? MediaQuery.sizeOf(context).width*0.55:
                                    
                                    MediaQuery.sizeOf(context).width,
                                  
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: '',
            desc: tittle,
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: btnOkOnPress,
            ).show();*/
}
