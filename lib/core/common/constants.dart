import 'package:flutter/material.dart';
import 'package:cleopatra/core/common/sharedpref/cashhelper.dart';

var deleteicon = Icons.delete_outlined;
var editeicon = Icons.edit_note_outlined;
List<String> permession = cashhelper.getdata(key: "permissions") ==null? []:List<String>.from(cashhelper.getdata(key: "permissions"));
final deepseekapikey = "sk-7ada96f357fb4af5b6e3473bf24f44d3";
//555555
//6666
