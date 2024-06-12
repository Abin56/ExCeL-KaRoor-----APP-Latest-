// ignore_for_file: non_constant_identifier_names, duplicate_ignore, empty_catches, unused_element

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/sign_in_controller/parent_login_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/home/events/event_display_class_level.dart';
import 'package:excel_karoor/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:excel_karoor/view/home/general_instructions/general_instructions.dart';
import 'package:excel_karoor/view/pages/Homework/parent/view_home_work.dart';
import 'package:excel_karoor/view/pages/Homework/view_home_work.dart';

import '../../../controllers/multipile_students/multipile_students_controller.dart';
import '../../../utils/utils.dart';
import '../../language/language_change_drawer.dart';
import '../../pages/attendence_book/attendence_book_status_month.dart';
import '../../pages/privacy_policy/dialogs/privacy_policy.dart';
import '../student_home/time_table/ss.dart';

// ignore: must_be_immutable
class ParentHeaderDrawer extends StatelessWidget {
  MultipileStudentsController multipileStudentsController = Get.put(MultipileStudentsController());
  ParentLoginController parentLoginController = Get.put(ParentLoginController());
  ParentHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kHeight30,
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 90,
            width: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974"),
              ),
            ),
          ),
          Text(
            nameOfInstitution,
            style: GoogleFonts.montserrat(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            "Watch and Guide      \n  Let them Study",
            style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.w600),
          ),
          TextButton(
            onPressed: () async {
              await userLogOut(context);
            },
            child: Text("Logout".tr),
          ),
          GestureDetector(
            onTap: () async {
              await multipileStudentsController.switchStudent(context);
            },
            child: Container(
              height: 30.h,
              width: 150.w,
              decoration: BoxDecoration(
                  color: adminePrimayColor.withOpacity(0.1),
                  border: Border.all(color: adminePrimayColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: GooglePoppinseventClassLevelWidgets(
                  text: 'Switch Student',
                  fontsize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget MenuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );
}

enum DrawerSections {
  dashboard,
  favourites,
  setting,
  share,
  feedback,
  contact,
  about,
}

// ignore: non_constant_identifier_names
Widget MyDrawerList(context) {
  void signOut(context) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signOut().then((value) => {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => const Gsignin()),
            //     (route) => false)
          });
    } catch (e) {}
  }

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          );
        });
  }

  var currentPage = DrawerSections.dashboard;
  return Container(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      // show list  of menu drawer.........................
      children: [
        MenuItem(1, 'assets/images/information.png', 'General Instructions'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          // Get.off(
          //   () => GeneralInstruction(),
          // );
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return GeneralInstruction();
            },
          ));
        }),
        MenuItem(2, 'assets/images/attendance.png', 'Attendance book'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AttendenceBookScreenSelectMonth(
                  schoolId: UserCredentialsController.schoolId!,
                  batchId: UserCredentialsController.batchId!,
                  classID: UserCredentialsController.classId!);
            },
          ));

          // Get.off(
          //   () => AttendenceBookScreenSelectMonth(
          //       schoolId: UserCredentialsController.schoolId!,
          //       batchId: UserCredentialsController.batchId!,
          //       classID: UserCredentialsController.classId!),
          // );
        }),
        MenuItem(3, 'assets/images/exam.png', 'Exams'.tr,
            currentPage == DrawerSections.favourites ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const UserExmNotifications();
            },
          ));

          // Get.off(
          //   () => const UserExmNotifications(),
          // );
        }),
        MenuItem(4, 'assets/images/library.png', 'Time Table'.tr,
            currentPage == DrawerSections.setting ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const TimeTable();
            },
          ));

          // Get.off(
          //   () => const SS(),
          // );
        }),
        // MenuItem(4, "Share", Icons.share,
        //     currentPage == DrawerSections.share ? true : false, () async {
        //   // await  Share.share('https://play.google.com/store/apps/details?id=in.brototype.BrotoPlayer');
        // }),
        MenuItem(5, 'assets/images/homework.png', 'HomeWorks'.tr,
            currentPage == DrawerSections.contact ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const ViewHomeWorksParent();
            },
          ));
          // Get.off(
          //   () => const ViewHomeWorks(),
          // );
        }),

        // MenuItem(8, 'assets/images/splash.png', 'Progress Report'.tr,
        //     currentPage == DrawerSections.dashboard ? true : false, () {
        //  Get.off(
        //     () =>       ProgressReportListViewScreen(
        //   schoolId: UserCredentialsController.schoolId!,
        //   classID: UserCredentialsController.classId!,
        //   studentId: UserCredentialsController.parentModel?.studentID ?? "",
        //   batchId: UserCredentialsController.batchId!),
        //   );
        // }),

        MenuItem(8, 'assets/images/languages.png', 'Change Language'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LanguageChangeDrawerPage();
            },
          ));
          // Get.off(() => LanguageChangeDrawerPage());
        }),
        MenuItem(7, 'assets/images/attendance.png', 'Privacy Policy'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const PrivacyPolicy();
            },
          ));
          // Get.off(() => const PrivacyPolicy());
        }),

        kHeight,
        kHeight,
        Container(
          color: Colors.grey.withOpacity(0.2),
          height: 200,
          width: double.infinity,
          child: const Stack(children: [
            Positioned(
              left: 20,
              top: 15,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Developed by",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 38,
                left: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974'),
                    ),
                    SizedBox(
                      width: 06,
                    ),
                    Text(
                      "Lepton Communications",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 11.5),
                    ),
                  ],
                )),
            Positioned(
              left: 100,
              top: 73,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.adb_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        " Version",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    "    1.0.0",
                    style: TextStyle(color: Colors.black, fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget emptyDisplay(String section) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No $section Found",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
