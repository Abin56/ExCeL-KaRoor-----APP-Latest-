import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/sign_in_controller/student_sign_in_controller.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/student%20login/signin/student_sigin.dart';

import '../../../../../model/Text_hiden_Controller/password_field.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/forget_password_page.dart';
import '../../../../../widgets/login_button.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/fonts/google_poppins.dart';
import '../../../../widgets/textformfield_login.dart';

class StudentLoginScreen extends StatelessWidget {
  final int? pageIndex;
  final PasswordField hideGetxController = Get.put(PasswordField());
 // final formKey = GlobalKey<FormState>();

  StudentLoginScreen({this.pageIndex, super.key});

  final StudentSignInController signInController =
      Get.put(StudentSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: SizedBox(
          // color: cred,
          height: 80.h,
          width: 115.w,
          child: Center(
              child: Image.asset(
            appLogo,
            color: Colors.white,
            fit: BoxFit.cover,
          )),
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerImage(
                  height: 340.h,
                  width: double.infinity,
                  imagePath: 'assets/images/Login_screen.png'),
              Form(
                key: signInController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Enter Mail id Session >>>>>>>
                    Padding(
                      padding: EdgeInsets.only(right: 140.w, left: 10.w),
                      child: GoogleMonstserratWidgets(
                        fontsize: 25.w,
                        text: 'Student Login'.tr,
                        color: cblack,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    kHeight10,
                    SigninTextFormfield(
                        obscureText: false,
                        hintText: 'Email ID'.tr,
                        labelText: 'Enter Mail ID',
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mail_outline,
                          ),
                        ),
                        textEditingController:
                            signInController.emailIdController,
                        function: checkFieldEmailIsValid),
                    // Enter Password session >>>>>>>>
                    Obx(
                      () => SigninTextFormfield(
                        hintText: 'Password'.tr,
                        obscureText: hideGetxController.isObscurefirst.value,
                        labelText: 'Password',
                        icon: Icons.lock,
                        textEditingController:
                            signInController.passwordController,
                        function: checkFieldPasswordIsValid,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(hideGetxController.isObscurefirst.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            hideGetxController.toggleObscureFirst();
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 210.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: GooglePoppinsWidgets(
                          fontsize: 16,
                          text: 'Forgot Password?'.tr,
                          fontWeight: FontWeight.w400,
                          color: adminePrimayColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: GestureDetector(
                          onTap: () async {
                            await signInController.signIn(context);
                          },
                          child: Obx(
                            () => signInController.isLoading.value
                                ? circularProgressIndicatotWidget
                                : loginButtonWidget(
                                    height: 60,
                                    width: 180,
                                    text: 'Login'.tr,
                                  ),
                          )),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GooglePoppinsWidgets(
                              text: "Don't Have an account?".tr, fontsize: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return StudentSignInScreen(
                                    pageIndex: pageIndex!,
                                  );
                                },
                              ));
                              // Get.off(() => StudentSignInScreen(
                              //       pageIndex: pageIndex!,
                              //     ));
                            },
                            child: GooglePoppinsWidgets(
                              text: ' Sign Up'.tr,
                              fontsize: 19,
                              color: cblue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
