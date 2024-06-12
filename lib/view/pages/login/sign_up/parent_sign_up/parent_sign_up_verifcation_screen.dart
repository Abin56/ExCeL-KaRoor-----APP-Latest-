import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/model/Text_hiden_Controller/password_field.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/drop_down/temp_users/sign_up_parent.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/parent_login/parent_login.dart';
import 'package:excel_karoor/view/widgets/container_image.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/view/widgets/textformfield_login.dart';
import 'package:excel_karoor/widgets/TextformField/textformFiledBlueContainer.dart';
import 'package:excel_karoor/widgets/custom_showDilog/notice_showdialogebox.dart';
import 'package:excel_karoor/widgets/login_button.dart';
import 'package:excel_karoor/widgets/progess_button/progress_button.dart';

import '../../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../controllers/sign_up_controller/parent_sign_up_controller.dart';

class ParentSignUpFirstScreen extends StatelessWidget {
  final int pageIndex;
  final PasswordField hideGetxController = Get.find<PasswordField>();
  ParentSignUpFirstScreen({required this.pageIndex, super.key});

  //final formKey = GlobalKey<FormState>();
  final ParentSignUpController parentSignUpController =
      Get.put(ParentSignUpController());

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
            kHeight20,
            ContainerImage(
              height: 250.h,
              width: double.infinity,
              imagePath: 'assets/images/splash.png',
            ),
            kHeight30,
            Obx(() => parentSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: parentSignUpController.isLoading.value
                        ? circularProgressIndicatotWidget
                        : SelectTempParentDropDown(),
                  )),
            kHeight30,
            Form(
              key: parentSignUpController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                          parentSignUpController.emailController,
                      function: checkFieldEmailIsValid),
                  kHeight10,
                  Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GooglePoppinsWidgets(
                            text: "* Use a valid email".tr,
                            fontsize: 13.w,
                            fontWeight: FontWeight.w400,
                            color: adminePrimayColor),
                      ],
                    ),
                  ),
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Password'.tr,
                      obscureText: hideGetxController.isObscurefirst.value,
                      labelText: 'Password',
                      icon: Icons.lock,
                      textEditingController:
                          parentSignUpController.passwordController,
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
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Confirm Password'.tr,
                      obscureText: hideGetxController.isObscureSecond.value,
                      labelText: 'Confirm Password',
                      icon: Icons.lock,
                      textEditingController:
                          parentSignUpController.confirmPasswordController,
                      function: checkFieldPasswordIsValid,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(hideGetxController.isObscureSecond.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          hideGetxController.toggleObscureSecond();
                        },
                      ),
                    ),
                  ),
                  kHeight10,
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                        onTap: () async {
                          if (parentSignUpController.formKey.currentState!
                              .validate()) {
                            if (UserCredentialsController
                                        .parentModel?.password ==
                                    null ||
                                UserCredentialsController.parentModel == null) {
                              showToast(msg: "Please select Parent");
                            } else {
                              if (parentSignUpController
                                      .confirmPasswordController.text
                                      .trim() ==
                                  parentSignUpController.passwordController.text
                                      .trim()) {
                                noticeCustomShowDilogBox(
                                    context: context,
                                    children: [
                                      TextFormFiledBlueContainerWidget(
                                        keyboardType: TextInputType.number,
                                        controller: parentSignUpController
                                            .parentPassController,
                                        hintText:
                                            ' Enter your 6 digit password',
                                        title: 'Password',
                                      )
                                    ],
                                    okButton: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Obx(() => ProgressButtonWidget(
                                            buttonstate: parentSignUpController
                                                .buttonstate.value,
                                            text: "OK",
                                            function: () async {
                                              await parentSignUpController
                                                  .checkParentProfilePAss();
                                            })),
                                      ),
                                    ),
                                    doyouwantActionButton: true,
                                    title: 'ss');
                              } else {
                                showToast(msg: "Password Missmatch");
                              }
                            }
                          } else {}

                          // if (parentSignUpController.passwordController.text
                          //         .trim() !=
                          //     parentSignUpController
                          //         .confirmPasswordController.text
                          //         .trim()) {
                          //   showToast(msg: "Password Missmatch".tr);
                          //   return;
                          // }

                          // if (parentSignUpController.formKey.currentState!
                          //     .validate()) {
                          //   if (UserCredentialsController
                          //           .parentModel?.parentPhoneNumber !=
                          //       null) {
                          //     Navigator.push(context, MaterialPageRoute(
                          //       builder: (context) {
                          //         return UserSentOTPScreen(
                          //           userpageIndex: pageIndex,
                          //           phoneNumber:
                          //               "+91${UserCredentialsController.parentModel?.parentPhoneNumber}",
                          //           userEmail: parentSignUpController
                          //               .emailController.text
                          //               .trim(),
                          //           userPassword: parentSignUpController
                          //               .passwordController.text
                          //               .trim(),
                          //         );
                          //       },
                          //     ));
                          //     // Get.off(() => UserSentOTPScreen(
                          //     //       userpageIndex: pageIndex,
                          //     //       phoneNumber:
                          //     //           "+91${UserCredentialsController.parentModel?.parentPhoneNumber}",
                          //     //       userEmail: parentSignUpController
                          //     //           .emailController.text
                          //     //           .trim(),
                          //     //       userPassword: parentSignUpController
                          //     //           .passwordController.text
                          //     //           .trim(),
                          //     //     ));
                          //   } else {
                          //     showToast(msg: "Please select parent detail.");
                          //   }
                          // }
                        },
                        child: Obx(
                          () => parentSignUpController.isLoading.value
                              ? circularProgressIndicatotWidget
                              : loginButtonWidget(
                                  height: 60,
                                  width: 180,
                                  text: 'Submit'.tr,
                                ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ParentLoginScreen(
                                pageIndex: 3,
                              );
                            },
                          ));
                          // Get.off(() => ParentLoginScreen(
                          //       pageIndex: 3,
                          //     ));
                        },
                        child: Text(
                          "Login".tr,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
