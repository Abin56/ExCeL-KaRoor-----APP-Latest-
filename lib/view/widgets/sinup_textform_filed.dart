// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class SinUpTextFromFiled extends StatelessWidget {
  String text;
  String hintText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  bool readOnly;

  void Function()? onTapFunction;
  SinUpTextFromFiled({
    required this.text,
    required this.hintText,
    this.validator,
    this.keyboardType,
    required this.textfromController,
    this.onTapFunction,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController textfromController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePoppinsWidgets(
              fontsize: 12,
              fontWeight: FontWeight.w300,
              text: text,
            ),
            Container(
              height: 50.h,
              width: double.infinity,
              color: const Color.fromARGB(255, 211, 225, 236),
              child: Center(
                child: TextFormField(
                  onTap: onTapFunction,
                  keyboardType: keyboardType,
                  validator: validator,
                  controller: textfromController,
                  readOnly: readOnly,
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.all(
                        10.h), //  <- you can it to 0.0 for no space
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
