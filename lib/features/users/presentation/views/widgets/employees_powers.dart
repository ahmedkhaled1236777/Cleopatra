import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleopatra/core/colors/colors.dart';
import 'package:cleopatra/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';

class EmployessPowers extends StatefulWidget {
  const EmployessPowers({super.key});

  @override
  State<EmployessPowers> createState() => EmployessPowersState();
}

class EmployessPowersState extends State<EmployessPowers> {
  final List<String> items = [
    'الحقن',
    'الجوده',
    'اوردرات الحقن',
    'حذف اوردر حقن',
    'اضافة اوردر حقن',
    'صالة التجميع',
    '1 عرض العمال',
    '1 حذف معدلات العمال',
    '1 اضافة معدلات العمال',
    'تعديل اوردر حقن',
    'اضافة تقرير حقن',
    '1 اضافة منتج',
    'حذف تقرير حقن',
    "عمال الاضاءه",
    '1 اوردرات التجميع',
    '1 معدلات العمال',
    'اضافة زمن حقن',
    'حذف زمن حقن',
    'تعديل زمن حقن',
    'عرض زمن حقن',
    'الاسطمبات',
    'عرض الاسطمبات',
    'اضافة اسطمبات',
    'حذف اسطمبات',
    'استهلاك الاسطمبات',
    'تعديل استهلاك الاسطمبات',
    'صيانة الاسطمبات',
    'اضافة صيانه الاسطمبات',
    'عرض تقرير شهري تجميع',
    "صالة التجميع 2",
    'تعديل صيانه الاسطمبات',
    'متابعة اوردرات التجميع',
    'اوردرات التجميع',
    'حذف تقرير تجميع',
    '1 اضافة العمال',
    'حذف توريد تقرير تجميع',
    'اوردرات الرش',
    'قسم الرش',
    'اضافة عطل',
    'ازمنه الرش',
    'اضافة ازمنة الرش',
    'اضافة تقرير رش',
    'حذف ازمنة الرش',
    'تعديل ازمنة الرش',
    'اضافة اوردرات التجميع',
    'اضافة تقرير تجميع',
    'حذف اوردرات التجميع',
    'اضافة اوردرت الرش',
    'حذف اوردرت الرش',
    'اضافة منتج',
    'عرض العمال',
    'اضافة العمال',
    'حذف العمال',
    'المستخدمين',
    'الحضور والانصراف',
    'الاتش ار',
    'لا يوجد'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddemployeeCubit, AddemployeeState>(
        builder: (context, state) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'الصلاحيات',
                style: TextStyle(
                  fontSize: 12.5,
                  fontFamily: "cairo",
                  color: appcolors.maincolor,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected =
                          BlocProvider.of<AddemployeeCubit>(context)
                              .selecteditems
                              .contains(item);
                      return InkWell(
                        onTap: () {
                          isSelected
                              ? {
                                  BlocProvider.of<AddemployeeCubit>(context)
                                      .selecteditems
                                      .remove(item)
                                }
                              : BlocProvider.of<AddemployeeCubit>(context)
                                  .selecteditems
                                  .add(item);
                          //This rebuilds the StatefulWidget to update the button's text
                          setState(() {});
                          //This rebuilds the dropdownMenu Widget to update the check mark
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_box_outlined)
                              else
                                const Icon(Icons.check_box_outline_blank),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
              value: BlocProvider.of<AddemployeeCubit>(context)
                      .selecteditems
                      .isEmpty
                  ? null
                  : BlocProvider.of<AddemployeeCubit>(context)
                      .selecteditems
                      .last,
              onChanged: (value) {},
              selectedItemBuilder: (context) {
                return items.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          BlocProvider.of<AddemployeeCubit>(context)
                              .selecteditems
                              .join(' - '),
                          style: const TextStyle(
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ).toList();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 0, right: 0),
                height: 35,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      );
    });
  }
}
