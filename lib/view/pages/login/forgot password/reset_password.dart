// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/login/forgot%20password/forgot_password.dart';
import 'package:excel_karoor/view/widgets/container_image.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/view/widgets/textformfield_login.dart';
import 'package:excel_karoor/widgets/login_button.dart';

import '../../../../../../model/Text_hiden_Controller/password_field.dart';

class ResetPassword extends StatelessWidget {
  PasswordField hideGetxController = Get.find<PasswordField>();
  ResetPassword({super.key});
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  //final formKey = GlobalKey<FormState>();
  final PasswordField passwordField = Get.put(PasswordField());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme:
              const IconThemeData(color: Colors.black, size: 30, weight: 500)),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ContainerImage(
                height: 400.h,
                width: double.infinity,
                imagePath: 'assets/images/lock reset.png'),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                        text: 'Reset',
                        fontsize: 25,
                        fontWeight: FontWeight.w700),
                    GooglePoppinsWidgets(
                        text: 'Password',
                        fontsize: 23,
                        fontWeight: FontWeight.w700),
                    kHeight20,
                    Form(
                      key:passwordField. formKey,
                      child: Column(
                        children: [
                          Obx(
                            () => SigninTextFormfield(
                              hintText: 'Password',
                              obscureText:
                                  hideGetxController.isObscurefirst.value,
                              labelText: 'Password',
                              icon: Icons.lock,
                              textEditingController: newpasswordController,
                              function: checkFieldPasswordIsValid,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.lock),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    hideGetxController.isObscurefirst.value
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                onPressed: () {
                                  hideGetxController.toggleObscureFirst();
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => SigninTextFormfield(
                              hintText: 'Confirm Password',
                              obscureText:
                                  hideGetxController.isObscureSecond.value,
                              labelText: 'Confirm Password',
                              icon: Icons.lock,
                              textEditingController: confirmpasswordController,
                              function: checkFieldPasswordIsValid,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.lock),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    hideGetxController.isObscureSecond.value
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                onPressed: () {
                                  hideGetxController.toggleObscureSecond();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  if (passwordField. formKey.currentState!.validate()) {
                     Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  ForgotPassword();
                    },));
                   // Get.off(() => ForgotPassword());
                  }
                },
                child:
                    loginButtonWidget(height: 60, width: 180, text: 'Submit'))
          ],
        ),
      )),
    );
  }
}
