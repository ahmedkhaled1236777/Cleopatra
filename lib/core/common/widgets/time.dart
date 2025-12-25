import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class Time extends StatelessWidget {
  void Function(DateTime)? onChange;
  DateTime inittime;
  Time({super.key, required this.onChange, required this.inittime});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TimePickerSpinnerPopUp(
        mode: CupertinoDatePickerMode.time,
        initTime: inittime,
        minuteInterval: 1,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        cancelText: 'الغاء',
        confirmText: 'تاكيد',
        enable: true,
        radius: 10,
        pressType: PressType.singlePress,
        // Customize your time widget
        // timeWidgetBuilder: (dateTime) {},
        locale: const Locale('ar'),
        onChange: onChange,
      ),
    );
  }
}
