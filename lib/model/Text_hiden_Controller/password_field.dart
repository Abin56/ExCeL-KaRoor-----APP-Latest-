import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isObscurefirst = true.obs;
   var isObscureSecond = true.obs;
  void toggleObscureFirst() {
     isObscurefirst.value = !isObscurefirst.value;
     update();
  }
    void toggleObscureSecond() {
     isObscureSecond.value = !isObscureSecond.value;
     update();
  }
  
}