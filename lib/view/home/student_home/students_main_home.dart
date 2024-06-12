import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:excel_karoor/controllers/application_controller/application_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/geminiscreen.dart';
import 'package:excel_karoor/view/home/drawer/student_drawer.dart';
import 'package:excel_karoor/view/home/student_home/student__homepage.dart';
import 'package:excel_karoor/view/pages/live_classes/students_room/list_room.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:line_icons/line_icons.dart';

import '../../../main.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';

class StudentsMainHomeScreen extends StatefulWidget {
  // var schoolID;
  // var classID;
  // var studentEmailid;
  const StudentsMainHomeScreen(
      {
      //   required this.schoolID,
      // required this.classID,
      // required this.studentEmailid,
      super.key});

  @override
  State<StudentsMainHomeScreen> createState() => _StudentsMainHomeScreenState();
}

class _StudentsMainHomeScreenState extends State<StudentsMainHomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // Timer? _profileCheckTimer;
  // bool _isDialogShowing = false;

  @override
  void initState() {
      Get.find<ApplicationController>().checkStudentProfile(context);
    super.initState();
    // _profileCheckTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
    //   checkProfile();
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   checkProfile();
    // });
  }

  // @override
  // void dispose() {
  //   // Cancel the timer when the widget is disposed
  //   _profileCheckTimer?.cancel();
  //   super.dispose();
  // }

  // checkProfile() {
  //   if (UserCredentialsController.studentModel?.profileImageUrl.trim() == "" ||
  //       UserCredentialsController.studentModel?.studentName.trim() == "" ||
  //       UserCredentialsController.studentModel?.parentPhoneNumber.trim() ==
  //           "" ||
  //       UserCredentialsController.studentModel?.bloodgroup.trim() == "" ||
  //       UserCredentialsController.studentModel?.houseName.trim() == "") {
  //     log("Incomplete profile");
  //     if (!_isDialogShowing) {
  //       _isDialogShowing = true;
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         if (mounted) {
  //           showProfileAlert();
  //         }
  //       });
  //     }
  //   }
  // }

  // void showProfileAlert() {
  //   showDialogeBox(
  //     context: context,
  //     children: [],
  //     headerchild: Text(
  //       "Please complete Your Profile".tr,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  //     ),
  //     actions: [
  //       Container(
  //         color: adminePrimayColor,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               child: Text(
  //                 "OK".tr,
  //                 style: const TextStyle(
  //                     color: cWhite, fontSize: 16, fontWeight: FontWeight.bold),
  //               ),
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const StudentProfileEditPage(),
  //                   ),
  //                 ).then((value) {
  //                   Navigator.pop(context);
  //                   _isDialogShowing = false;
  //                   checkProfile();
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ).then((_) {
  //     _isDialogShowing = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
  
    checkingSchoolActivate(context);
    List<Widget> pages = [
      NewStdHomePage(),
      // const StudentHomeScreen(),
      // const NewStdHomePage(), ///////////////////////////////////////////
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      const StudentsRoomListScreen(),
      const GeminiAIBOT(),
    ];
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
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
          //  backgroundColor: adminePrimayColor
        ),
        body: pages[_page],
        bottomNavigationBar: Container(
          height: 71,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: Colors.white.withOpacity(0.13)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                adminePrimayColor,
                adminePrimayColor.withOpacity(0.7)
                // const Color.fromARGB(255, 88, 167, 123),
                // const Color.fromARGB(255, 88, 167, 123).withOpacity(0.7),
              ],
            ),
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
                // iconSize: 10,
                textSize: 20,
                icon: Icons.laptop,
                text: 'Live\nClasses'.tr,
              ),
              GButton(
                iconSize: 30,
                textSize: 20,
                icon: Icons.chat,
                text: 'Ask\nDoubt'.tr,
              )
            ],
            selectedIndex: _page,
            onTabChange: (value) {
              onPageChanged(value);
            },
          ),
        ),
        drawer:  Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const StudentsHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
