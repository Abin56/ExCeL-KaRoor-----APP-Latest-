import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/geminiscreen.dart';
import 'package:excel_karoor/view/home/teachers_home/notification_part_tcr.dart';
import 'package:excel_karoor/view/home/teachers_home/teacher_home.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/widgets/animation/notification_animation.dart';
import 'package:line_icons/line_icons.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../main.dart';
import '../../pages/live_classes/teacher_live_section/create_room.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../drawer/teacher_drawer.dart';

class TeacherMainHomeScreen extends StatefulWidget {
  const TeacherMainHomeScreen({super.key});

  @override
  State<TeacherMainHomeScreen> createState() => _TeacherMainHomeScreenState();
}

class _TeacherMainHomeScreenState extends State<TeacherMainHomeScreen> {
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
  //   if (UserCredentialsController.teacherModel?.imageUrl?.trim() == "" ||
  //       UserCredentialsController.teacherModel?.teacherName?.trim() == "" ||
  //       UserCredentialsController.teacherModel?.teacherPhNo?.trim() == "" ||
  //       UserCredentialsController.teacherModel?.houseName?.trim() == "") {
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
  //                     builder: (context) => TeacherEditProfileScreen(),
  //                   ),
  //                 ).then((value) {
  //                   Navigator.pop(context);
  //                   _isDialogShowing = false;
  //                   checkProfile(); // Recheck profile after editing
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
      TeacherHomeScreen(),
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      CreateRoomScreen(),
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
          backgroundColor: adminePrimayColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationPartTcr(),
                              ));
                        },
                        icon: const Icon(
                          Icons.notifications_active,
                          size: 25,
                          color: Color.fromARGB(255, 244, 225, 58),
                        )),
                    StreamBuilder(
                        stream: server
                            .collection('AllUsersDeviceID')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data?.data()?['message'] == true
                                ? const Positioned(
                                    top: 25,
                                    left: 20,
                                    right: 7,
                                    bottom: 19,
                                    child: NotifierAnimator(),
                                  )
                                : const SizedBox();
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
        body: pages[_page],
        bottomNavigationBar: Container(
          height: 81,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: Colors.white.withOpacity(0.13)),
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Color.fromARGB(255, 6, 71, 157),
            //     Color.fromARGB(255, 5, 85, 222)
            //   ],
            // ),
            color: const Color.fromARGB(255, 27, 92, 176),
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
                iconSize: 20,
                textSize: 20,
                icon: Icons.tv,
                text: 'Recorded\nClasses'.tr,
              ),
              GButton(
                iconSize: 20,
                // iconSize: 10,
                textSize: 20,
                icon: Icons.laptop,
                text: 'Live\nClasses'.tr,
              ),
              GButton(
                iconSize: 20,
                icon: Icons.chat,
                textSize: 20,
                text: 'Ask\nDoubt'.tr,
              )
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
                TeacherHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
