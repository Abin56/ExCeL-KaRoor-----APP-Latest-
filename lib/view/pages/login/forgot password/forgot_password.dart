// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/login/forgot%20password/reset_password.dart';
import 'package:excel_karoor/view/widgets/container_image.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/view/widgets/textformfield_login.dart';
import 'package:excel_karoor/widgets/login_button.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  TextEditingController emailForgotController = TextEditingController();
 // final formKey = GlobalKey<FormState>();
  final PasswordFormController passwordFormController = Get.put(PasswordFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                IconThemeData(color: Colors.black, size: 30, weight: 500)),
        body: SafeArea(
          child: ListView(children: [
            // IconButtonBackWidget(),
            ContainerImage(
                height: 380.h,
                width: double.infinity - 20,
                imagePath: 'assets/images/select_user (1).png'),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                        text: 'Forgot',
                        fontsize: 25,
                        fontWeight: FontWeight.w700),
                    GooglePoppinsWidgets(
                        text: 'Password ?',
                        fontsize: 23,
                        fontWeight: FontWeight.w700),
                    kHeight20,
                    GoogleMonstserratWidgets(
                      text: "Don't  worry! Its happens.....",
                      fontsize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    kHeight10,
                    GoogleMonstserratWidgets(
                        text: "Please Enter Your Email ID", fontsize: 20),
                    kHeight30,
                    Form(
                      key: passwordFormController. formKey,
                      child: SigninTextFormfield(
                          obscureText: false,
                          hintText: 'Email ID',
                          labelText: 'Enter Mail ID',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.mail_outline_sharp,
                            ),
                          ),
                          textEditingController: emailForgotController,
                          function: checkFieldEmailIsValid),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
                onTap: () {
                  if (passwordFormController.formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return  ResetPassword();
                    },));
                   // Get.off(() => ResetPassword());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: loginButtonWidget(
                    height: 60,
                    width: 180,
                    text: 'Submit',
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
