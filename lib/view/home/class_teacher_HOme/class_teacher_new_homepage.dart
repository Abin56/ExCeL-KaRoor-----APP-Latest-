// import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:excel_karoor/controllers/log_out/user_logout_controller.dart';
// import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
// import 'package:excel_karoor/view/colors/colors.dart';
// import 'package:excel_karoor/view/home/bus_route_page/all_bus_list.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/allgraph.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/assignmentGraph.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/attendenceGraph.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/exam.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/projectGraph.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/leave_letters/leave_lettersList.dart';
// import 'package:excel_karoor/view/home/class_teacher_HOme/my_students/my_students.dart';
// import 'package:excel_karoor/view/home/events/event_list.dart';
// import 'package:excel_karoor/view/home/exam_Notification/teacher_adding/add_subject.dart';
// import 'package:excel_karoor/view/home/student_home/subjects/subject_display.dart';
// import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
// import 'package:excel_karoor/view/pages/studentAttendence/select_period.dart';
// import 'package:excel_karoor/view/pages/Attentence/take_attentence/attendence_book_status_month.dart';
// import 'package:excel_karoor/view/pages/Homework/homework.dart';
// import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
// import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
// import 'package:excel_karoor/view/pages/chat/teacher_section/teacher_chat-screen.dart';
// import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
// import 'package:excel_karoor/view/widgets/icon/icon_widget.dart';

// import '../../pages/splash_screen/splash_screen.dart';

// class ClassTeacherNewHomePage extends StatefulWidget {
//   const ClassTeacherNewHomePage({super.key});

//   @override
//   State<ClassTeacherNewHomePage> createState() =>
//       _ClassTeacherNewHomePageState();
// }

// class _ClassTeacherNewHomePageState extends State<ClassTeacherNewHomePage> {
//   UserLogOutController userLogOutController = Get.put(UserLogOutController());
//   // int _page = 0;

//   // onPageChanged(int page) {
//   //   setState(() {
//   //     _page = page;
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   backtoSwitchClass();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final screenNavigationOfClsTr = [
//       SelectPeriodWiseScreen(
//           batchId: UserCredentialsController.batchId!,
//           classID: UserCredentialsController.classId!,
//           schoolId: UserCredentialsController.schoolId!), //Take Attendance

//       AttendenceBookScreenSelectMonth(
//         batchId: UserCredentialsController.batchId!,
//         classID: UserCredentialsController.classId!,
//         schoolId: UserCredentialsController.schoolId!,
//       ), ////////////  Attendance book

//       const TeacherChatScreen(), // Chats

//       const SS(), //TimeTable

//       LeaveLettersListviewScreen(
//           schooilID: UserCredentialsController.schoolId!,
//           batchID: UserCredentialsController.batchId!,
//           classID: UserCredentialsController.classId!), //Leave letters

//       HomeWorkUpload(
//         batchId: UserCredentialsController.batchId!,
//         classId: UserCredentialsController.classId!,
//         schoolID: UserCredentialsController.schoolId!,
//         teacherID: UserCredentialsController.teacherModel!.docid!,
//       ), //////////Home Work

//       const MyStudents(), //My students

//       const StudentSubjectHome(), //Subject

//       SchoolLevelMeetingPage(), //Meetings

//       const AddTimeTable(), //Exam

//       // SelectExamLevelScreen(classId: classID), //exam result upload

//       NoticePage(), //Notice

//       const EventList(), //Events

//       TeacherSubjectWiseList(navValue: ''), //Teachers

//      // BusRouteListPage(), /////// all bus
//     ];
//     // checkingSchoolActivate(context);
//     // List<Widget> pages = [

//     //   RecSelectSubjectScreen(
//     //     batchId: UserCredentialsController.batchId!,
//     //     classID: UserCredentialsController.classId!,
//     //     schoolId: UserCredentialsController.schoolId!,
//     //   ),
//     //   CreateRoomScreen(),
//     //   const ChatScreen(),
//     // ];
//     return WillPopScope(
//         onWillPop: () => onbackbuttonpressed(context),
//         child: Scaffold(
//             body: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 280,
//                       decoration: const BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             Color.fromARGB(255, 5, 85, 222),
//                             Colors.lightBlueAccent
//                           ]), //fromARGB(255, 234, 234, 234),
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(30),
//                               bottomRight: Radius.circular(30))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                   UserCredentialsController
//                                           .teacherModel?.imageUrl ??
//                                       " "),
//                               maxRadius: 45,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: GoogleMonstserratWidgets(
//                                 overflow: TextOverflow.ellipsis,
//                                 text: UserCredentialsController
//                                         .teacherModel?.teacherName ??
//                                     " ",
//                                 fontsize: 23.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: cWhite,
//                               ),
//                             ),
//                             FutureBuilder(
//                                 future: FirebaseFirestore.instance
//                                     .collection('SchoolListCollection')
//                                     .doc(UserCredentialsController.schoolId)
//                                     .collection(
//                                         UserCredentialsController.batchId!)
//                                     .doc(UserCredentialsController.batchId)
//                                     .collection('classes')
//                                     .doc(UserCredentialsController.classId)
//                                     .get(),
//                                 builder: (context, snaps) {
//                                   if (snaps.hasData) {
//                                     return GoogleMonstserratWidgets(
//                                       text:
//                                           'Class : ${snaps.data!.data()!['className']}',
//                                       fontsize: 15.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: cWhite.withOpacity(0.8),
//                                     );
//                                   } else {
//                                     return const Text('');
//                                   }
//                                 }),
//                             GoogleMonstserratWidgets(
//                               text:
//                                   'ID : ${UserCredentialsController.teacherModel?.employeeID ?? " "}',
//                               fontsize: 14.sp,
//                               fontWeight: FontWeight.w500,
//                               color: cWhite.withOpacity(0.8),
//                             ),
//                             GoogleMonstserratWidgets(
//                               text:
//                                   'email : ${UserCredentialsController.teacherModel?.teacherEmail ?? " "}',
//                               fontsize: 12.sp,
//                               fontWeight: FontWeight.w500,
//                               color: cWhite.withOpacity(0.7),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 220, left: 30, right: 30),
//                       child: Center(
//                         child: Container(
//                           margin: const EdgeInsets.all(0),
//                           height: 260,
//                           width: 345,
//                           decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(18),
//                               ),
//                               color: Color.fromRGBO(255, 255, 255, 1)),
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(14),
//                               child: SizedBox(
//                                 height: 280,
//                                 width: 360,
//                                 child: 
//                                 CarouselSlider(
//                                   items: [
//                                     CaroselWidget(
//                                         sliderImagePath: imagesList[0],
//                                         slidertext: "Exam"),
//                                     CaroselWidget(
//                                         sliderImagePath: imagesList[1],
//                                         slidertext: "Attendence"),
//                                     CaroselWidget(
//                                         sliderImagePath: imagesList[2],
//                                         slidertext: "Project"),
//                                     CaroselWidget(
//                                         sliderImagePath: imagesList[3],
//                                         slidertext: "Assignment")
//                                   ],
//                                   options: CarouselOptions(
//                                     // aspectRatio: 1,
//                                     autoPlay: true,
//                                     enlargeCenterPage: true,
//                                     height: 230,
//                                     aspectRatio: 16 / 9,
//                                     autoPlayCurve: Curves.fastOutSlowIn,
//                                     autoPlayAnimationDuration:
//                                         const Duration(milliseconds: 800),
//                                     viewportFraction: 0.8,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 50,
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           // crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             ContainerWidget(
//                               //icon: Icons.waving_hand,
//                               text: 'Take Attendance',
//                               onTap: () {
//                                 Get.to(() => screenNavigationOfClsTr[0]);
//                               },
//                               icon: 'assets/flaticons/roll-call.png',
//                             ),
//                             ContainerWidget(
//                               //icon: Icons.import_contacts,
//                               text: 'Attendance Book',
//                               onTap: () {
//                                 Get.to(() => screenNavigationOfClsTr[1]);
//                               },
//                               icon: 'assets/flaticons/book.png',
//                             ),
//                             ContainerWidget(
//                               //icon: Icons.chat_rounded,
//                               text: 'Chats',
//                               onTap: () {
//                                 Get.to(() => screenNavigationOfClsTr[2]);
//                               },
//                               icon: 'assets/flaticons/icons8-chat-100.png',
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ContainerWidget(
//                             // icon: Icons.waving_hand,
//                             text: ' Time Table',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/worksheet.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.import_contacts,
//                             text: 'Leave Letters',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/email.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.chat_rounded,
//                             text: 'Home Work',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/homework.png',
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ContainerWidget(
//                             // icon: Icons.waving_hand,
//                             text: 'My Students ',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/students.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.import_contacts,
//                             text: 'Study Materials',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/school-material.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.chat_rounded,
//                             text: 'Meeting',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/teamwork.png',
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ContainerWidget(
//                             // icon: Icons.waving_hand,
//                             text: 'Exams ',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/icons8-grades-100.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.import_contacts,
//                             text: 'Notices',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/icons8-notice-100.png',
//                           ),
//                           ContainerWidget(
//                             //icon: Icons.chat_rounded,
//                             text: 'Events',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/calendar.png',
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           ContainerWidget(
//                             // icon: Icons.waving_hand,
//                             text: 'Teacher ',
//                             onTap: () {
//                               Get.to(() => screenNavigationOfClsTr[0]);
//                             },
//                             icon: 'assets/flaticons/female.png',
//                           ),
//                           // ContainerWidget(
//                           //   //icon: Icons.import_contacts,
//                           //   text: 'Bus Route',
//                           //   onTap: () {
//                           //        Get.to(() =>screenNavigationOfClsTr[0]);
//                           //   }, image: 'images/route.png',
//                           // ),
//                           // ContainerWidget(
//                           //   //icon: Icons.chat_rounded,
//                           //   text: 'Library',
//                           //   onTap: () {}, image: 'images/book.png',
//                           // ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ]),
//         )));
//   }
// }

// class CaroselWidget extends StatelessWidget {
//   Widget sliderImagePath;
//   String slidertext;
//   CaroselWidget({
//     required this.sliderImagePath,
//     required this.slidertext,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(child: sliderImagePath),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 0),
//           child: GooglePoppinsWidgets(
//             text: slidertext,
//             fontsize: 15,
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         )
//       ],
//     );
//   }
// }

// final List<Widget> imagesList = [
//   ExamGraphClassTeacher(),
//   const AttendenceGraphClassTeachers(),
//   const ProjectGraphClassTeacher(),
//  const Assignmentgraphcontainer(),
// ];
