import 'package:flutter/material.dart';

Widget updateTextFormField({
  required BuildContext context,
  required String hintText,
  required TextEditingController textEditingController,
  required VoidCallback voidCallback,
  required TextInputType textInputType,
  String? Function(String?)? validator,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    title: TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: voidCallback,
        child: const Text("Submit"),
      ),
    ],
  );
}
