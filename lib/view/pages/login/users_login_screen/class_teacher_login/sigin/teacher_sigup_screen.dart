// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/sign_up_controller/teacher_signup_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/model/Text_hiden_Controller/password_field.dart';
import 'package:excel_karoor/model/teacher_model/teacher_model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/teacher_login/teacher_login.dart';
import 'package:excel_karoor/view/widgets/container_image.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/view/widgets/textformfield_login.dart';
import 'package:excel_karoor/widgets/TextformField/textformFiledBlueContainer.dart';
import 'package:excel_karoor/widgets/custom_showDilog/notice_showdialogebox.dart';
import 'package:excel_karoor/widgets/login_button.dart';
import 'package:excel_karoor/widgets/progess_button/progress_button.dart';

class TeachersSignUpScreen extends StatelessWidget {
  int pageIndex;
  TeachersSignUpScreen({required this.pageIndex, super.key});
  PasswordField hideGetxController = Get.find<PasswordField>();
  // final formKey = GlobalKey<FormState>();
  TeacherSignUpController teacherSignUpController =
      Get.put(TeacherSignUpController());

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
            Obx(() => teacherSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: DropdownSearch<TeacherModel>(
                        selectedItem: TeacherModel(
                          teacherName: 'Select Teacher'.tr,
                          teacherEmail: '',
                          houseName: '',
                          houseNumber: '',
                          place: '',
                          gender: '',
                          district: '',
                          altPhoneNo: '',
                          employeeID: '',
                          createdAt: '',
                          teacherPhNo: "",
                          docid: '',
                          userRole: '',
                          imageId: '',
                          imageUrl: '',
                        ),
                        validator: (v) => v == null ? "required field" : null,
                        items: teacherSignUpController.teachersList,
                        itemAsString: (TeacherModel u) => u.teacherName ?? "",
                        onChanged: (value) {
                          UserCredentialsController.teacherModel = value;
                          log(value?.teacherPhNo ?? "");
                        }),
                  )),
            kHeight30,
            Form(
              key: teacherSignUpController.formKey,
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
                          teacherSignUpController.emailController,
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
                          teacherSignUpController.passwordController,
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
                          teacherSignUpController.confirmPasswordController,
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
                      onTap: () {
                        if (teacherSignUpController.formKey.currentState!
                            .validate()) {
                          if (UserCredentialsController
                                      .teacherModel?.password ==
                                  null ||
                              UserCredentialsController.teacherModel == null) {
                            showToast(msg: "Please select Teacher");
                          } else {
                            if (teacherSignUpController
                                    .confirmPasswordController.text
                                    .trim() ==
                                teacherSignUpController.passwordController.text
                                    .trim()) {
                              noticeCustomShowDilogBox(
                                  context: context,
                                  children: [
                                    TextFormFiledBlueContainerWidget(
                                      keyboardType: TextInputType.number,
                                      controller: teacherSignUpController
                                          .teacherPAssController,
                                      hintText: ' Enter your 6 digit password',
                                      title: 'Password',
                                    )
                                  ],
                                  okButton: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Obx(() => ProgressButtonWidget(
                                          buttonstate: teacherSignUpController
                                              .buttonstate.value,
                                          text: "OK",
                                          function: () async {
                                            await teacherSignUpController
                                                .checkTeacherProfilePAss();
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

                        //   if(teacherSignUpController. formKey.currentState!.validate()){
                        // if (UserCredentialsController
                        //                 .teacherModel?.password !=
                        //             '' ||
                        //         UserCredentialsController
                        //                 .teacherModel?.password !=
                        //             null) {
                        //               noticeCustomShowDilogBox(context: context, children: [

                        //               ]);

                        //     //             Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //     //   return UserSentOTPScreen(
                        //     //         userpageIndex: pageIndex,
                        //     //         phoneNumber:
                        //     //             "+91${UserCredentialsController.teacherModel?.teacherPhNo}",
                        //     //         userEmail: teacherSignUpController
                        //     //             .emailController.text,
                        //     //         userPassword: teacherSignUpController
                        //     //             .passwordController.text,
                        //     //       );
                        //     // },));

                        //     } else {
                        //       showToast(msg: "Please select Teacher detail.");
                        //     }
                        //   }
                      },
                      child: loginButtonWidget(
                        height: 60,
                        width: 180,
                        text: 'Submit'.tr,
                      ),
                    ),
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
                              return TeacherLoginScreen(
                                pageIndex: 3,
                              );
                            },
                          ));
                          // Get.off(() => TeacherLoginScreen(
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
