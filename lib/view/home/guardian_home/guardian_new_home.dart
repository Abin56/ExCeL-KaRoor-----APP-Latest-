// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/main.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
import 'package:excel_karoor/view/home/all_class_test_show/all_class_list_show.dart';
import 'package:excel_karoor/view/home/events/event_list.dart';
import 'package:excel_karoor/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:excel_karoor/view/home/parent_home/leave_application/apply_leave_application.dart';
import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
import 'package:excel_karoor/view/pages/Homework/view_home_work.dart';
import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
import 'package:excel_karoor/view/pages/Subject/subject_display.dart';
import 'package:excel_karoor/view/pages/chat/parent_section/parent_chat_screeen.dart';
import 'package:excel_karoor/view/pages/exam_results/for_users/select_examlevel_uses.dart';
import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';
import 'package:excel_karoor/view/widgets/icon/icon_widget.dart';

import '../../pages/attendence_book/attendence_book_status_month.dart';

class GuardianHomeScreen2 extends StatefulWidget {
  final String studentName;

  const GuardianHomeScreen2({super.key, required this.studentName});

  @override
  State<GuardianHomeScreen2> createState() => _GuardianHomeScreen2State();
}

class _GuardianHomeScreen2State extends State<GuardianHomeScreen2> {
  // ignore: unused_field
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  String deviceToken = '';

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token ?? 'Not get the token ';
        log("User Device Token :: $token");
      });
      saveDeviceTokenToFireBase(deviceToken);
    });
  }

  void saveDeviceTokenToFireBase(String deviceToken) async {
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('GuardianCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true))
        .then((value) => log('Device Token Saved To FIREBASE'))
        .then((value) => log('Device Token Saved To FIREBASE'))
        .then((value) => FirebaseFirestore.instance
                .collection('PushNotificationToAll')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'deviceToken': deviceToken,
              'schoolID': UserCredentialsController.schoolId,
              'batchID': UserCredentialsController.batchId,
              'classID': UserCredentialsController.classId,
              'personID': FirebaseAuth.instance.currentUser!.uid,
              'role': 'Guardian'
            }))
        .then((value) => FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('PushNotificationList')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'deviceToken': deviceToken,
              'batchID': UserCredentialsController.batchId,
              'classID': UserCredentialsController.classId,
              'personID': FirebaseAuth.instance.currentUser!.uid,
              'role': 'Guardian'
            }));

    //AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp  apikey
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }

  Widget build(BuildContext context) {
  
   

    // String studentName = '';
  //  var screenSize = MediaQuery.of(context).size;
    checkingSchoolActivate(context);

    return const Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          // GuardianNotificationContaierWidget(
          //   onTap: () {
          //     viewallMenus();
          //   },
          // ),
          // const GuardianCaroselWidget(),
          // const ParentNameWidget(),
          Padding(
            padding: EdgeInsets.only(top: 400, left: 40),
            child: Row(
              children: [
                // QuickActionsWidget(
                //   text: quicktext[0],
                //   image: image[0],
                // ),
                // QuickActionsWidget(
                //   text: quicktext[1],
                //   image: image[1],
                // ),
                // QuickActionsWidget(
                //   text: quicktext[2],
                //   image: image[2],
                // ),
                // QuickActionsWidget(
                //   text: quicktext[3],
                //   image: image[3],
                // ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  viewallMenus() {
    final screenNavigationOfParent = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence...0

          const ViewHomeWorks(), // Home Works...............1
           const TimeTable(), // Time Table...........2
           const TeacherSubjectWiseList(
          navValue: 'guardian'), //Teachers.................3
          const StudentSubjectScreen(), //Subjects...............4
          LeaveApplicationScreen(
          studentName: widget.studentName,
          guardianName: UserCredentialsController.guardianModel!.guardianName!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!,
          studentID: UserCredentialsController.guardianModel!.studentID!,
          batchId: UserCredentialsController.batchId!), //Leave Letter////...5
          const UserExmNotifications(), // Exams...........6
          UsersSelectExamLevelScreen(
          classID: UserCredentialsController.classId!,
          studentId: UserCredentialsController
              .guardianModel!.studentID!), ////// exam result............7
              NoticePage(), //Notice.........8
              const EventList(), //Events.................9
              SchoolLevelMeetingPage(),////////////////////////////10

      

      UsersSelectExamLevelScreen(
          classID: UserCredentialsController.classId!,
          studentId: UserCredentialsController
              .guardianModel!.studentID!), ////// exam result............6

      const ViewHomeWorks(), // Home Works...............7

      NoticePage(), //Notice.........8

      const EventList(), //Events.................9
      SchoolLevelMeetingPage(),////////////////////////10

          const ParentChatScreen(),/////......11
      AllClassTestPage(
        pageNameFrom: "guardian",
      ), //class test page////////////////////////////11
      AllClassTestMonthlyPage(
        pageNameFrom: "guardian",
      ), //////////////12

    ];

    Get.bottomSheet(
        SingleChildScrollView(
          child: SizedBox(
            height: 800,
            width: double.infinity,
            child: Wrap(
              children: <Widget>[
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("All Categoris"),
                    ),
                     SingleChildScrollView(
                       child: SizedBox(
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
                                 padding:
                                     const EdgeInsets.only(left: 20, top: 10, right: 20),
                                // child: SingleChildScrollView(
                                   child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         ContainerWidget(
                                           image: img[index],
                                           //icon: Icons.view_list,
                                           text: text[index], onTap: () { Get.to(screenNavigationOfParent[index]); },
                                         ),
                                       ]),
                                // ),//
                               ),
                         
                               // GooglePoppinsWidgets(text: "Subject", fontsize: 16),
                               // kHeight10,
                             ),
                           ),
                         ),
                       ),
                     ),
                    // const SizedBox(height: 20,)
                  ],
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white);
  }
}

// class CategoryRowWidget extends StatelessWidget {
//   const CategoryRowWidget({
//     super.key,
//     required this.screenNavigationOfParent,
//   });

//   final List<Widget> screenNavigationOfParent;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child:
//     )
//   }
// }

List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];
List<String> image = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/icons8-chat-100.png'
];

// Widget MenuItem(int id, String image, String title, bool selected, onTap) {
//   return Material(
//     color: Colors.white,
//     child: InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 30,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(image))),
//               ),
//             ),
//             Expanded(
//                 flex: 3,
//                 child: Text(
//                   title,
//                   style: const TextStyle(color: Colors.black, fontSize: 16),
//                 ))
//           ],
//         ),
//       ),
//     ),
//   );
// }

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
List <String> text=[
  'Attendance',
  'Homework',
   'Time Table',
   'Teachers',
   'Subjects',
    'Leave Letters',
     'Exams',
     'Exam Results',
     'Notices',
     'Events',
     'Meetings',
     'Chats',
     'Class Test',
     'Monthly Class Test',
];
