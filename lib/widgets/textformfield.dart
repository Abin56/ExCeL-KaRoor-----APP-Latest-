// ignore_for_file: prefer_const_constructors

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.textEditingController,
    this.function,
    this.keyboardType,
  });
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String? fieldContent)? function;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: function,
      controller: textEditingController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.h)),
          labelStyle: TextStyle(color: cblack, fontWeight: FontWeight.w600),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2),
          ),
          fillColor: cWhite,
          filled: true,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: cblack)),
    );
  }
}
