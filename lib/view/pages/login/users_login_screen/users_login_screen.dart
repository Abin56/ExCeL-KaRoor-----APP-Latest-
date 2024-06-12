// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/sign_in_controller/teacher_login_controller.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/parent_login/parent_login.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/teacher_login/teacher_login.dart';
import 'package:excel_karoor/view/pages/login/users_login_screen/widgets/user_login_design.dart';
import 'package:excel_karoor/view/widgets/container_image.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/Text_hiden_Controller/password_field.dart';

class UsersLoginScreen extends StatelessWidget {
  PasswordField hideGetxController = Get.put(PasswordField());
  TeacherLoginController teacherLoginController =
      Get.put(TeacherLoginController());
  UsersLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    double w = MediaQuery.of(context).size.width;
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
          child: Column(
        children: [
          const UserLoginDesgin(),
          AnimationLimiter(
            child: Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  4,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () async {
                              if (index == 0) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return StudentLoginScreen(
                                pageIndex: 0,
                              );
                          },));
                                // Get.off(() => StudentLoginScreen(
                                //       pageIndex: 0,
                                //     ));
                              } else if (index == 1) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ParentLoginScreen(
                                pageIndex: 1,
                              );
                          },));
                                // Get.off(() => ParentLoginScreen(
                                //       pageIndex: 1,
                                //     ));
                              } else if (index == 2) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TeacherLoginScreen(
                                pageIndex: 2,
                              );
                          },));
                                // Get.off(() => TeacherLoginScreen(
                                //       pageIndex: 2,
                                //     ));
                              } else if (index == 3) {
                              //  const String url = 'https://vidyaveechi.com/';
                                // _launchWhatsapp();
                                final Uri url =
                                    Uri.parse('https://vidyaveechi.com/');
                                await _launchUrl(url);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: w / 10,
                                  left: w / 20,
                                  right: w / 20,
                                  top: w / 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 27, 75, 235),
                                    width: 0.3),
                                color: const Color.fromARGB(251, 194, 213, 246)
                                    .withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ContainerImage(
                                      height: 60.h,
                                      width: 60,
                                      imagePath: icons[index]),
                                  GoogleMonstserratWidgets(
                                    text: userList[index],
                                    letterSpacing: 1,
                                    fontsize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  List<String> userList = [
    'Student'.tr,
    'Parent'.tr,
    'Teacher'.tr,
    'Admin'.tr,
  ];
}

var icons = [
  'assets/images/reading.png',
  'assets/images/family.png',
  'assets/images/teacher.png',
  'assets/images/guard.png',
];

List<String> userList = ['Student'.tr, 'Parent'.tr, 'Teacher'.tr];

var iconss = [
  'assets/images/reading.png',
  'assets/images/family.png',
  'assets/images/teacher.png',
  'assets/images/guard.png',
];
_launchWhatsapp() async {
  const url = "https://wa.me/?text=Hey buddy, try this super cool new app!";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
