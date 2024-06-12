import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:excel_karoor/controllers/application_controller/application_controller.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/parent_home/parent_home_screen.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/parent_edit_profile_full.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:line_icons/line_icons.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../main.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../drawer/parent_drawer.dart';

class ParentMainHomeScreen extends StatefulWidget {
  const ParentMainHomeScreen({super.key});

  @override
  State<ParentMainHomeScreen> createState() => _ParentMainHomeScreenState();
}

class _ParentMainHomeScreenState extends State<ParentMainHomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }


  @override
  void initState() {
        Get.find<ApplicationController>().checkParentProfile(context);
    super.initState();
  
  }




  @override
  Widget build(BuildContext context) {


    checkingSchoolActivate(context);
    List<Widget> pages = [
      ParentHomeScreen(
        studentName: UserCredentialsController.parentModel!.studentID!,
      ),
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      ParentEditProfileScreenFull()
    ];
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
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
          flexibleSpace: const AppBarColorWidget(),
        ),
        body: pages[_page],
        bottomNavigationBar: Container(
          height: 71,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            border: Border.all(color: Colors.white.withOpacity(0.13)),
            color: const Color.fromARGB(255, 6, 71, 157),
          ),
          child: GNav(
            gap: 8,
            rippleColor: Colors.grey,
            activeColor: Colors.white,
            color: Colors.white,
            tabs: [
              GButton(
                  iconSize: 20,
                  icon: LineIcons.home,
                  text: 'Home'.tr,
                  style: GnavStyle.google),
              GButton(
                iconSize: 30,
                textSize: 20,
                icon: Icons.tv,
                text: 'Recorded\nClasses'.tr,
              ),
              GButton(
                iconSize: 30,
                icon: Icons.assignment_ind_outlined,
                textSize: 20,
                text: 'Profile'.tr,
              ),
              //    GButton(
              //   iconSize: 30,
              //   textSize: 20,
              //   icon: Icons.chat,
              //   text: 'Ask\nDoubt'.tr,
              // )
            ],
            selectedIndex: _page,
            onTabChange: (value) {
              onPageChanged(value);
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ParentHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
