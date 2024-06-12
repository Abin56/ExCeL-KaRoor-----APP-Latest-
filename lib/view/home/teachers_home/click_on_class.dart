import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/leave_letters/leave_lettersList.dart';
import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:excel_karoor/view/pages/Notice/Tabs/school_level_tab.dart';
import 'package:excel_karoor/view/pages/studentAttendence/select_period.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/icon/teachericonWidget/imagecontainer.dart';

import '../../../utils/utils.dart';
import '../../colors/colors.dart';
import '../../constant/responsive.dart';
import '../../pages/Homework/homework.dart';
import '../../pages/Subject/teacher_display_subjects.dart';
import '../../pages/attendence_book/attendence_book_status_month.dart';
import '../../pages/chat/teacher_section/teacher_chat-screen.dart';
import '../../pages/exam_results/select_exam.dart';
import '../../pages/live_classes/teacher_live_section/create_room.dart';
import '../../pages/recorded_class/recorded_class_page.dart';
import '../events/Tabs/school_level_tab.dart';
import '../exam_Notification/users_exam_list_view/user_exam_acc.dart';
import '../student_home/time_table/ss.dart';
import 'class_test/class_test_page.dart';
import 'monthly_class_test/class_test_monthly_page.dart';

class ClickOnClasss extends StatelessWidget {
  final String classID;
  final String className;
  const ClickOnClasss(
      {required this.classID, required this.className, super.key});

  @override
  Widget build(BuildContext context) {
    final noDataNavigation = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: classID), //Attendance Book

      const UserExmNotifications(), //Exam

      const TimeTable(), //Time Table

      Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          //backgroundColor: adminePrimayColor,
          title: Text("Notices".tr),
        ),
        body: SchoolLevelNoticePage(),
      ),

      // Notice
      TeacherSubjectHome(),

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: Text("Events".tr),
        ),
        body: SchoolLevelPage(),
      ),
      // Events
      SchoolLevelMeetingPage(), // Meetings

      ClassTestPage(),

      ClassMonthlyTestPage(),
    ];
    final hasDataNavigation = [
      SelectPeriodWiseScreen(
          batchId: UserCredentialsController.batchId!,
          classID: classID,
          schoolId: UserCredentialsController.schoolId!), //Take Attendance

      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: classID), //Attendance Book

      const TeacherChatScreen(), // Chats

      LeaveLettersListviewScreen(
          schooilID: UserCredentialsController.schoolId!,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!),

      const UserExmNotifications(), //Exam

      SelectExamLevelScreen(classId: classID), //exam result upload

      const TimeTable(), //TimeTable

      HomeWorkUpload(
        batchId: UserCredentialsController.batchId!,
        classId: UserCredentialsController.classId!,
        schoolID: UserCredentialsController.schoolId!,
        teacherID: UserCredentialsController.teacherModel!.docid!,
      ), //////////Home Work, //Home Works

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Notices"),
        ),
        body: SchoolLevelNoticePage(),
      ),
      // Notice

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Events"),
        ),
        body: SchoolLevelPage(),
      ),
      // Events
      // ViewExamsForProgressreport(
      //     batchId: UserCredentialsController.batchId!,
      //     classID: classID,
      //     schooilID:
      //         UserCredentialsController.schoolId!), //Progress Report view
      TeacherSubjectHome(), // Subjects
      SchoolLevelMeetingPage(),
      // Meetings
      RecordedClassMainPage(), // recorded class

     // BusRouteListPage(),
      ClassTestPage(),
      ClassMonthlyTestPage(), //class test monthly

      CreateRoomScreen(), //Live Class
    ];
    int columnCount = 3;
    double w = ResponsiveApp.mq.size.width;
    double h = ResponsiveApp.mq.size.height;
    log('Teacher class iddddddd$classID');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 229, 229),
      appBar: AppBar(
        flexibleSpace: const AppBarColorWidget(),
        title: Text(className, style: const TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(UserCredentialsController.schoolId!)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection("classes")
                  .doc(classID)
                  .collection("teachers")
                  .doc(UserCredentialsController.teacherModel!.docid)
                  .collection("teacherSubject")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'You have no access in this class'.tr,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: AnimationLimiter(
                            child: GridView.count(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: EdgeInsets.all(w / 20),
                              crossAxisCount: columnCount,
                              children: List.generate(
                                _acc_text.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    columnCount: columnCount,
                                    child: ScaleAnimation(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: cWhite,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return noDataNavigation[
                                                        index];
                                                  },
                                                ));

                                                // Get.to(() =>
                                                //     noDataNavigation[index]);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  _acc_images[index],
                                                  Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      _acc_text[index],
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 11.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  )
                                                ],
                                              ),
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
                        )
                      ],
                    );
                  } else {
                    return AnimationLimiter(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.all(w / 60),
                        crossAxisCount: columnCount,
                        children: List.generate(
                          hasDataText.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              columnCount: columnCount,
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: cWhite,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return hasDataNavigation[index];
                                            },
                                          ));

                                          // Get.to(() => hasDataNavigation[index]);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            // color: Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Colors.black.withOpacity(0.1),
                                            //     blurRadius: 40,
                                            //     spreadRadius: 10,
                                            //  
                                            // ],
                                          ),
                                          height: h / 100,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              top: w / 35,
                                              left: w / 35,
                                              right: w / 35),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              hasDataImages[index],
                                              // Container(
                                              //   height: 75,
                                              //   width: double.infinity,
                                              //   decoration: BoxDecoration(
                                              //     image: DecorationImage(
                                              //       image: AssetImage(
                                              //           hasDataImages[index]),
                                              //     ),
                                              //   ),
                                              // ),
                                              Center(
                                                child: Text(
                                                  translateString(
                                                      hasDataText[index]),
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 11.5,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}

List<String> _acc_text = [
  'Attendance Book'.tr,
  'Exams'.tr,
  'Time Table'.tr,
  'Notices'.tr,
  'Subjects'.tr,
  'Events'.tr,
  'Meetings'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
];
List<Widget> _acc_images = [
  const ImageContainer(image: "assets/flaticons/book.png"),
  const ImageContainer(image: "assets/flaticons/icons8-grades-100.png"),
  const ImageContainer(image: "assets/flaticons/worksheet.png"),
  const ImageContainer(image: "assets/flaticons/icons8-notice-100.png"),
  const ImageContainer(image: "assets/flaticons/icons8-books-48.png"),
  const ImageContainer(image: "assets/flaticons/calendar.png"),
  const ImageContainer(image: "assets/flaticons/meeting.png"),
  const ImageContainer(image: "assets/flaticons/exam.png"),
  const ImageContainer(image: "assets/flaticons/test.png"),
];
List<Widget> hasDataImages = [
  const ImageContainer(image: "assets/flaticons/roll-call.png"),
  const ImageContainer(image: "assets/flaticons/book.png"),
  const ImageContainer(image: "assets/flaticons/icons8-chat-100.png"),
  const ImageContainer(image: 'assets/flaticons/leave_letter.png'),
  const ImageContainer(image: "assets/flaticons/icons8-grades-100.png"),
  const ImageContainer(image: "assets/flaticons/exam (1).png"),
  const ImageContainer(image: "assets/flaticons/worksheet.png"),
  const ImageContainer(image: "assets/flaticons/icons8-homework-67.png"),
  const ImageContainer(image: "assets/flaticons/icons8-notice-100.png"),
  const ImageContainer(image: "assets/flaticons/calendar.png"),
  const ImageContainer(image: "assets/flaticons/school-material.png"),
  const ImageContainer(image: "assets/flaticons/meeting.png"),
  const ImageContainer(image: "assets/flaticons/recording.png"),
 // const ImageContainer(image: "assets/flaticons/route (1).png"),
  const ImageContainer(image: "assets/flaticons/exam.png"),
  const ImageContainer(image: "assets/flaticons/test.png"),
  const ImageContainer(image: "assets/flaticons/icons8-teacher-100.png"),
];
List<String> hasDataText = [
  'Take Attendance'.tr,
  'Attendance Book'.tr,
  'Chats'.tr,
  'Leave Letter'.tr,
  'Exams'.tr,
  'Exam Results'.tr,
  'Time Table'.tr,
  'HomeWorks'.tr,
  'Notices'.tr,
  'Events'.tr,
  'Study Materials'.tr,
  'Meetings'.tr,
  'Recorded Classes'.tr,
  //'Bus Route'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
  'Live Class'.tr,
];
