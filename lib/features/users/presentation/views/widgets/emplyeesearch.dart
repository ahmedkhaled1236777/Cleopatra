import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';

class emplyeesearch extends StatelessWidget {
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        phone.clear();
        BlocProvider.of<showemployeescuibt>(context).fileralldata();

        showDialog(
          context: context,

          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              title: Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width > 950
                              ? MediaQuery.sizeOf(context).width * 0.25
                              : MediaQuery.sizeOf(context).width * 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  const Text('بحث بواسطة',
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          color: Color(0xff2ba4c8),
                                          fontWeight: FontWeight.w100),
                                      textAlign: TextAlign.right),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  custommytextform(
                                      controller: phone,
                                      hintText: "رقم هاتف الموظف"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  custommaterialbutton(
                                    onPressed: () {
                                      BlocProvider.of<showemployeescuibt>(
                                              context)
                                          .searchforemployee(phone.text);
                                      phone.clear();
                                      Navigator.pop(context);
                                    },
                                    button_name: "بحث",
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.search,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
