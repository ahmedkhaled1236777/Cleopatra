import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';

import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

class Alertworkersearch extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              custommytextform(
                controller: name,
                hintText: "اسم الموظف",
              ),
              SizedBox(
                height: 10,
              ),
              custommytextform(
                keyboardType: TextInputType.number,
                controller: phone,
                hintText: "رقم الهاتف",
              ),
              SizedBox(
                height: 35,
              ),
              custommaterialbutton(
                  button_name: "بحث",
                  onPressed: () async {
                    // ignore: await_only_futures

                  
                  }),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
