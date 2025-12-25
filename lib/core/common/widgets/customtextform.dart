
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cleopatra/core/colors/colors.dart';

class custommytextform extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  Widget? suffixIcon;
  String? val;
  TextInputType keyboardType;
  int? maxlines;
  bool? readonly;
  String? suffixtext;
    void Function(String)? onChanged;

  List<TextInputFormatter>? inputFormatters;
  custommytextform(
      {super.key,
      this.readonly = false,
      this.onChanged,
      this.inputFormatters,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.maxlines = 1,
      this.val,
      this.suffixtext,
      this.keyboardType = TextInputType.text,
      this.suffixIcon});

  @override
  State<custommytextform> createState() => _custommytextformState();
}

class _custommytextformState extends State<custommytextform> {
  @override
  Widget build(BuildContext context) {
   return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hintText,
                style: TextStyle(fontSize: 12.5, color:appcolors.maincolor,fontFamily: "cairo"),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
               TextFormField(
                onChanged:widget.onChanged ,
                inputFormatters: widget.inputFormatters,
                style: const TextStyle(fontSize: 13,fontFamily: "cairo"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return widget.val;
                  }
                },
                obscureText: widget.obscureText,
                readOnly: widget.readonly!,
                keyboardType: widget.keyboardType,
              
                maxLines: widget.maxlines,
                controller: widget.controller,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.3),
                  filled: true,
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color:Colors.grey.withOpacity(0.3), width: 0.5)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                    isCollapsed: true,
                    enabledBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),

                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5)),
                    suffixText: widget.suffixtext,
                    border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),

                        borderSide:  BorderSide(
                            color: appcolors.maincolor, width: 0.5)),
                    suffixIcon: widget.suffixIcon,
                    ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          );
  }
}
