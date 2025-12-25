import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showdialogerror({required String error, required BuildContext context}) {
  showGeneralDialog(
    context: context,
    pageBuilder: ((context, animation, secondaryAnimation) {
      return SizedBox();
    }),
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: Container(
            child: Stack(
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "cairo"),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          error,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontFamily: "cairo"),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "موافق",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
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
                    child: Lottie.asset(
                        width: 78, height: 78, "assets/images/sasa.json"),
                  ),
                  top: (MediaQuery.sizeOf(context).height - 125) / 2 - 70,
                )
              ],
            ),
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
                      error,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "موافق",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
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
}
