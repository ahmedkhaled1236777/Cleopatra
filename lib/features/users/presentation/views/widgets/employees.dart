import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cleopatra/features/users/presentation/views/widgets/dektopemployees.dart';

class Employees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeesState();
  }
}

class EmployeesState extends State<Employees> {
  GlobalKey<ScaffoldState> scafoldstate = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate1 = DateTime.now();
  var date1 = 'التاريخ';
  var date2 = 'اضغط لاختيار تاريخ محدد';

  @override
  Widget build(BuildContext context) {
    return desktopemployees();
  }
}
