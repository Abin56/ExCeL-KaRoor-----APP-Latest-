// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/push_notification_controller/push_notification_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/local_database/parent_login_database.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
import 'package:excel_karoor/view/home/all_class_test_show/all_class_list_show.dart';
import 'package:excel_karoor/view/home/events/event_list.dart';
import 'package:excel_karoor/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:excel_karoor/view/home/parent_home/container%20widget/container_widget.dart';
import 'package:excel_karoor/view/home/parent_home/leave_application/apply_leave_application.dart';
import 'package:excel_karoor/view/home/parent_home/parent%20home%20widget/parent_carosel_widget.dart';
import 'package:excel_karoor/view/home/parent_home/parent%20home%20widget/parent_name_widget.dart';
import 'package:excel_karoor/view/home/parent_home/parent%20home%20widget/parent_view_all_categories.dart';
import 'package:excel_karoor/view/home/parent_home/parent%20home%20widget/qucik_action.dart';
import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
import 'package:excel_karoor/view/pages/Homework/parent/view_home_work.dart';
import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
import 'package:excel_karoor/view/pages/Subject/subject_display.dart';
import 'package:excel_karoor/view/pages/attendence_book/attendence_book_status_month.dart';
import 'package:excel_karoor/view/pages/chat/parent_section/parent_chat_screeen.dart';
import 'package:excel_karoor/view/pages/exam_results/for_users/select_examlevel_uses.dart';
import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';

import '../../../controllers/multipile_students/multipile_students_controller.dart';

class ParentHomeScreen extends StatelessWidget {
  ParentHomeScreen({super.key, required this.studentName});
  @override
  // ignore: override_on_non_overriding_member
  final String studentName;

  final PushNotificationController pushNotCntrl =
      Get.put(PushNotificationController());

final MultipileStudentsController multipileStudentsController =
      Get.put(MultipileStudentsController());

  Widget build(BuildContext context) {
    
    log("Parent DOCID :::::::::::::::::::  ${UserCredentialsController.parentModel?.docid}");
    log("Firebase Auth DOCID :::::::::::::::::::  ${FirebaseAuth.instance.currentUser?.uid}");
       pushNotCntrl.getUserDeviceID().then((value) async {
      await pushNotCntrl
          .allUSerDeviceID(UserCredentialsController.parentModel!.userRole,UserCredentialsController.parentModel?.docid??"");
      await pushNotCntrl.allParentDeviceID(UserCredentialsController.parentModel?.docid??"");
    });
    final parentAuth = DBParentLogin(
        parentPassword: ParentPasswordSaver.parentPassword,
        parentEmail: ParentPasswordSaver.parentemailID,
        schoolID: UserCredentialsController.schoolId!,
        batchID: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        studentID: UserCredentialsController.parentModel!.studentID!,
        parentID: FirebaseAuth.instance.currentUser!.uid,
        emailID: FirebaseAuth.instance.currentUser!.email ?? "",
        parentDocID: FirebaseAuth.instance.currentUser!.uid);
    multipileStudentsController.checkalreadyexist(
        FirebaseAuth.instance.currentUser!.uid, parentAuth);

    List<Widget> screenNav = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController
              .classId!), ///////////////////Attendance 0

      const ViewHomeWorksParent(), // Home Works...............1
      const UserExmNotifications(), // Exams...........2
      const ParentChatScreen(), /////......3
    ];
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            ParentViewAllCategories(
              onTap: () {
                viewallMenus();
              },
            ),
            const ParentCaroselWidget(),
            const ParentNameWidget(),
            Padding(
                padding: const EdgeInsets.only(top: 400, left: 40),
                child: Row(
                  children: [
                    QuickActionsWidget(
                        text: quicktext[0],
                        image: image[0],
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return screenNav[0];
                            },
                          ));

                          // Get.off
                          // (screenNav[0]);
                        }),
                    QuickActionsWidget(
                      text: quicktext[1],
                      image: image[1],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return screenNav[1];
                          },
                        ));
                        //Get.off(screenNav[1]);
                      },
                    ),
                    QuickActionsWidget(
                      text: quicktext[2],
                      image: image[2],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return screenNav[2];
                          },
                        ));
                        // Get.off(screenNav[2]);
                      },
                    ),
                    QuickActionsWidget(
                      text: quicktext[3],
                      image: image[3],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return screenNav[3];
                          },
                        ));
                        // Get.off(screenNav[3]);
                      },
                    ),
                  ],
                )),
          ],
        ),
      )),
    );

  }


  viewallMenus() {
    final screenNavigationOfParent = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence...0

      const ViewHomeWorksParent(), // Home Works...............1
      const TimeTable(), // Time Table...........2
      const TeacherSubjectWiseList(
          navValue: 'parent'), //Teachers.................3
      const StudentSubjectScreen(), //Subjects...............4

      LeaveApplicationScreen(
          studentName: studentName,
          guardianName: UserCredentialsController.parentModel!.parentName!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!,
          studentID: UserCredentialsController.parentModel!.studentID!,
          batchId: UserCredentialsController.batchId!), //Leave Letter////...5

      const UserExmNotifications(), // Exams...........6
      UsersSelectExamLevelScreen(
          classID: UserCredentialsController.classId!,
          studentId: UserCredentialsController
              .parentModel!.studentID!), ////// exam result............7
      NoticePage(), //Notice.........8
      const EventList(), //Events.................9
        SchoolLevelMeetingPage(), ////////////////////////////10

      const ParentChatScreen(), /////......11
      AllClassTestPage(
        pageNameFrom: "parent",
      ), //class test page////////////////////////////12
      AllClassTestMonthlyPage(
        pageNameFrom: "parent",
      ), //////////////13
    ];

    Get.bottomSheet(
        SingleChildScrollView(
          child: SizedBox(
            height: 420,
            width: double.infinity,
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      14,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: cWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 60,

                        // ignore: sort_child_properties_last
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
                          // child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ParentContainerWidget(
                                  icon: img[index],
                                  //icon: Icons.view_list,
                                  text: text[index],
                                  onTap: () {
                               Get.to(() => screenNavigationOfParent[index]);

                                    // Get.off(
                                    //     screenNavigationOfParent[index]);
                                  },
                                ),
                              ]),
                          // ),//
                        ),

                        // GooglePoppinsWidgets(text: "Subject", fontsize: 16),
                        // kHeight10,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }
}

List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];
List<String> image = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/icons8-chat-100.png'
];

List<String> img = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-67.png',
  'assets/flaticons/study-time.png',
  'assets/flaticons/icons8-teacher-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/leave_letter.png',
  'assets/flaticons/exam.png',
  'assets/flaticons/icons8-grades-100.png',
  'assets/flaticons/icons8-notice-100.png',
  'assets/flaticons/schedule.png',
  'assets/flaticons/meeting.png',
  'assets/flaticons/icons8-chat-100.png',
  'assets/flaticons/exam (1).png',
  'assets/flaticons/test.png',
];
List<String> text = [
  'Attendance'.tr,
  'Homework'.tr,
  'Time Table'.tr,
  'Teachers'.tr,
  'Subjects'.tr,
  'Leave Letters'.tr,
  'Exams'.tr,
  'Exam Results'.tr,
  'Notices'.tr,
  'Events'.tr,
  'Meetings'.tr,
  'Chats'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
];
