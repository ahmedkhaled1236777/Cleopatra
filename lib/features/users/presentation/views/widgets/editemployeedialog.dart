import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/core/common/toast/toast.dart';
import 'package:cleopatra/core/common/widgets/custommaterialbutton.dart';
import 'package:cleopatra/core/common/widgets/customtextform.dart';
import 'package:cleopatra/core/common/widgets/dialogerror.dart';
import 'package:cleopatra/core/common/widgets/errorwidget.dart';
import 'package:cleopatra/features/auth/login/model/signmodelrequest.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:cleopatra/features/users/presentation/views/widgets/employees_powers.dart';

class editemployeedialog extends StatefulWidget {
  final double width;

  final double height;

  final TextEditingController employeename;
  final TextEditingController email;
  final TextEditingController jobtittle;
  final TextEditingController phone;
  const editemployeedialog({
    super.key,
    required this.width,
    required this.height,
    required this.email,
    required this.employeename,
    required this.jobtittle,
    required this.phone,
  });
  @override
  State<editemployeedialog> createState() => _editemployeedialogState(
      employeename: employeename,
      jobtittle: jobtittle,
      phone: phone,
      email: email);
}

class _editemployeedialogState extends State<editemployeedialog> {
  static final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController employeename;
  final TextEditingController jobtittle;

  final TextEditingController phone;
  final TextEditingController email;

  _editemployeedialogState({
    required this.employeename,
    required this.jobtittle,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddemployeeCubit, AddemployeeState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: SingleChildScrollView(
              child: Column(children: [
                Text('تعديل بيانات المستخدم',
                    style:
                        TextStyle(fontSize: 12.5, color: appcolors.maincolor),
                    textAlign: TextAlign.right),
                const SizedBox(
                  height: 15,
                ),
                custommytextform(
                    controller: email, hintText: "البريد الالكتروني"),
                const SizedBox(
                  height: 10,
                ),
                custommytextform(
                    controller: employeename, hintText: "اسم الموظف"),
                const SizedBox(
                  height: 10,
                ),
                custommytextform(
                    controller: jobtittle, hintText: "المسمي الوظيفي"),
                const SizedBox(
                  height: 10,
                ),
                custommytextform(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9-.]")),
                    ],
                    keyboardType: TextInputType.number,
                    controller: phone,
                    hintText: "رقم الهاتف"),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xff2BA4C8), width: 0.5)),
                  child: const EmployessPowers(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xff2BA4C8), width: 0.5)),
                  child: Row(
                    children: [
                      Radio(
                          value: "1",
                          groupValue: BlocProvider.of<AddemployeeCubit>(context)
                              .is_active,
                          onChanged: (val) {
                            BlocProvider.of<AddemployeeCubit>(context)
                                .changestatus(val!);
                          }),
                      Text("مفعل"),
                      Spacer(),
                      Radio(
                          value: "0",
                          groupValue: BlocProvider.of<AddemployeeCubit>(context)
                              .is_active,
                          onChanged: (val) {
                            BlocProvider.of<AddemployeeCubit>(context)
                                .changestatus(val!);
                          }),
                      Text("غير مفعل"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<AddemployeeCubit, AddemployeeState>(
                  listener: (context, state) async {
                    if (state is updateemployeefailure) {
                      showdialogerror(
                          error: state.errormessage, context: context);
                    }
                    if (state is updateemployeesuccess) {
                      BlocProvider.of<AddemployeeCubit>(context).image = null;
                      BlocProvider.of<showemployeescuibt>(context)
                          .employeesdata
                          .clear();
                      await BlocProvider.of<showemployeescuibt>(context)
                          .getallemployees();
                      BlocProvider.of<AddemployeeCubit>(context).resetdata();
                      Navigator.pop(context);
                      showtoast(
                                                                                                          context: context,

                        toaststate: Toaststate.succes,
                        message: state.succes_message,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is updateemployeeloading) return loading();
                    return custommaterialbutton(
                      button_name: "تعديل البيانات",
                      onPressed: () async {
                        BlocProvider.of<AddemployeeCubit>(context).editemployee(
                            employee: Signmodelrequest(
                                admin: false,
                                password: null,
                                img: null,
                                block:
                                    BlocProvider.of<AddemployeeCubit>(context)
                                                .is_active ==
                                            "1"
                                        ? false
                                        : true,
                                email: email.text,
                                name: employeename.text,
                                job: jobtittle.text,
                                phone: phone.text,
                                permessions: List<String>.from(
                                    BlocProvider.of<AddemployeeCubit>(context)
                                        .selecteditems)));
                      },
                    );
                  },
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
