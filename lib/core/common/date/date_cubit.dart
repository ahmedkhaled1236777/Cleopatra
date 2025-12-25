import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateTime selectedDate = DateTime.now();
  String date1 =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  String date2 = "اختر التاريخ";
  String date7 = "اختر التاريخ";
  String date3 = "التاريخ من";
  String date4 = "التاريخ الي";
  String date5 = "تاريخ بداية الصيانه";
  String date6 = "تاريخ نهاية الصيانه";
  String timefrom = "الوقت من";
  String timeto = "الوقت الي";
  String workermonth = " ${DateTime.now().month}";

  String producthalldate =
      '${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day : "0${DateTime.now().day}"}';

  TimeOfDay selectedtime1 = TimeOfDay.now();
  DateCubit() : super(DateInitial());
  changedate(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;
      String month = date.month > 9 ? '${date.month}' : '${date.month}';
      String day = date.day > 9 ? '${date.day}' : '${date.day}';
      workermonth = "${month}-${date.year}";
      date1 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedatehall(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;
      String month = date.month > 9 ? '${date.month}' : '${date.month}';
      String day = date.day > 9 ? '${date.day}' : '${date.day}';

      producthalldate = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate2(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;
      var month = date.month;
      var day = date.day!;

      date2 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  producthalldatechange(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;
      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';

      date2 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate3(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;
      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';
      date3 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate4(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;

      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';
      date4 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate5(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;

      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';
      date5 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate6(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;

      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';
      date6 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  changedate7(BuildContext context) async {
    selectedDate = DateTime.now();
    emit(newchangedatestate());

    DateTime? date = await showDatePicker(
        switchToCalendarEntryModeIcon: Icon(Icons.calendar_month),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000),
        locale: Locale('ar'));

    if (date != null) {
      selectedDate = date;

      String month = date.month > 9 ? '${date.month}' : '0${date.month}';
      String day = date.day > 9 ? '${date.day}' : '0${date.day}';
      date7 = '${date.year}-${month}-${day}';
    }
    ;
    emit(changedatestate());
  }

  cleardates() {
    date1 =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    date2 = "اختر التاريخ";
    date3 = "التاريخ من";
    date4 = "التاريخ الي";
    date5 = "تاريخ بداية الصيانه";
    date6 = "تاريخ نهاية الصيانه";
    date7 = "اختر التاريخ";
    timeto = "الوقت الي";
    timefrom="الوقت من";
    producthalldate =
        '${DateTime.now().year}-${DateTime.now().month > 9 ? DateTime.now().month : "0${DateTime.now().month}"}-${DateTime.now().day > 9 ? DateTime.now().day : "0${DateTime.now().day}"}';

    emit(changedatestate());
  }

  changetimefrom(DateTime date) {
    timefrom =
        "${date.hour == 0 ? 24 : date.hour.toString()}:${date.minute.toString()}";
  }

  changetimeto(DateTime date) {
    timeto =
        "${date.hour == 0 ? 24 : date.hour.toString()}:${date.minute.toString()}";
  }
}
