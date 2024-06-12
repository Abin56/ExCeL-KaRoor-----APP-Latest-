// import 'dart:developer';

// import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gui_shape/geo/geo_common.dart';
// import 'package:gui_shape/gui/gui_shape_border.dart';
// import 'package:gui_shape/shape/gui_shape_polygon.dart';
// import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
// import 'package:excel_karoor/view/colors/colors.dart';
// import 'package:excel_karoor/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
// import 'package:excel_karoor/view/home/all_class_test_show/all_class_list_show.dart';
// import 'package:excel_karoor/view/home/bus_route_page/all_bus_list.dart';
// import 'package:excel_karoor/view/home/events/event_list.dart';
// import 'package:excel_karoor/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
// import 'package:excel_karoor/view/home/student_home/subjects/subject_display.dart';
// import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
// import 'package:excel_karoor/view/pages/Attentence/take_attentence/attendence_book_status_month.dart';
// import 'package:excel_karoor/view/pages/Homework/view_home_work.dart';
// import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
// import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
// import 'package:excel_karoor/view/pages/exam_results/for_users/select_examlevel_uses.dart';
// import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_lemon.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_salsa.dart';
// import 'package:excel_karoor/view/widgets/icon/icon_widget.dart';

// import '../../pages/chat/student_section/student_chat_screen.dart';

// class NewStdHomePage extends StatelessWidget {
//   const NewStdHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     log(
//       UserCredentialsController.studentModel!.docid,
//     );
//     final screenNavigationOfStd = [
//       AttendenceBookScreenSelectMonth(
//           schoolId: UserCredentialsController.schoolId!,
//           batchId: UserCredentialsController.batchId!,
//           classID: UserCredentialsController.classId!), //Attendence

//       const ViewHomeWorks(), // Home Works

//       const SS(), //Time table

//       TeacherSubjectWiseList(navValue: 'student'), //Teachers

//       const StudentChatScreen(), // Chats

//       const StudentSubjectHome(), //Subjects/////////<--

//       const UserExmNotifications(), //Exam

//       UsersSelectExamLevelScreen(
//           classId: UserCredentialsController.classId!,
//           studentID:
//               UserCredentialsController.studentModel!.docid), ////// exam result

//       NoticePage(), //Notice
//       const EventList(), //Events

//       SchoolLevelMeetingPage(), //Meetings
//       BusRouteListPage(),

//       AllClassTestPage(
//         pageNameFrom: "student",
//       ), //class test page
//       AllClassTestMonthlyPage(
//         pageNameFrom: "student",
//       ),
//       // HostelHomePage(),
//     ];
//     var screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 139, 195, 248),
//                         Color.fromARGB(255, 6, 152, 225),
//                         // Color.fromARGB(255, 222, 29, 151),
//                         // Color.fromARGB(255, 39, 48, 211)
//                         Color.fromARGB(255, 15, 73, 208),
//                       ],
//                       end: Alignment.topLeft,
//                       begin: Alignment.bottomRight,
//                     ),
//                     //  color: cgraident.withOpacity(0.5),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(30),
//                         bottomRight: Radius.circular(30)),
//                   ),

//                   width: double.infinity,
//                   height: screenSize.width * 0.4,
//                   // padding: EdgeInsets.all(15.h),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20, left: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             GoogleLemonWidgets(
//                               overflow: TextOverflow.ellipsis,
//                               text: UserCredentialsController
//                                   .studentModel!.studentName,
//                               fontsize: 23.sp,
//                               //  fontWeight: FontWeight.bold,
//                               color: cWhite,
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
//                                     return GoogleSalsaWidgets(
//                                       text:
//                                           'Class : ${snaps.data!.data()!['className']}',
//                                       fontsize: 15.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: cWhite,
//                                     );
//                                   } else {
//                                     return const Text('');
//                                   }
//                                 }),
//                             GoogleSalsaWidgets(
//                               text:
//                                   'Ad No : ${UserCredentialsController.studentModel?.admissionNumber}',
//                               fontsize: 15.sp,
//                               fontWeight: FontWeight.w500,
//                               color: cWhite,
//                             ),
//                             GoogleSalsaWidgets(
//                               text:
//                                   'email : ${UserCredentialsController.studentModel?.studentemail}',
//                               fontsize: 14.sp,
//                               fontWeight: FontWeight.w500,
//                               color: cWhite,
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                             onTap: (() {}),
//                             child: Container(
//                               height: 35,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Color.fromARGB(248, 41, 73, 231),
//                                       blurRadius: 20.0,
//                                     ),
//                                   ],
//                                   color: const Color.fromARGB(248, 3, 201, 231)
//                                       .withOpacity(0.5),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(10))),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 22),
//                                 child: Center(
//                                     child: GoogleSalsaWidgets(
//                                   text: "Performance Analysis",
//                                   fontsize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: cWhite,
//                                 )),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 80),
//                         child: Center(
//                           child: SizedBox(
//                             height: 80,
//                             width: 80,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 shape: GuiShapeBorder(
//                                   shape: GuiShapePolygon(
//                                     sides: 6,
//                                     cornerRadius: 8,
//                                     startAngle: GeoAngle(degree: 0),
//                                     clockwise: false,
//                                     boxFit: BoxFit.fill,
//                                   ),
//                                   side: const BorderSide(
//                                       color: Colors.purple, width: 0.0),
//                                 ),
//                               ),
//                               onPressed: () {},
//                               child: const Icon(Icons.person,
//                                   color: Colors.yellow),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Column(
//               children: [
//                 // const Padding(
//                 //     padding: EdgeInsets.only(top: 20),
//                 //     child: CarouselSliderWidget()),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ContainerWidget(image: 'assets/flaticons/icons8-attendance-100.png',
//                       //  icon: Icons.waving_hand,
//                         text: ' Attendance',
//                         onTap: () {
//                           print("object");
//                           Get.to(() => screenNavigationOfStd[0]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/icons8-homework-67.png',
//                       //  icon: Icons.home_work,
//                         text: 'Homework',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[1]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/study-time.png',
//                       //  icon: Icons.assignment_rounded,
//                         text: 'Time Table',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[2]);
//                         }),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     // SizedBox(
//                     //   width: 100.w, //110
//                     //   height: 100.h,
//                     //   child: Column(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [
//                     //       Container(
//                     //         height: 80.h,
//                     //         width: 80.w,
//                     //         decoration: BoxDecoration(
//                     //             shape: BoxShape.circle,
//                     //             border: Border.all(
//                     //                 color: adminePrimayColor.withOpacity(0.5))),
//                     //         child: Center(
//                     //           child: Image.asset(
//                     //             'assets/flaticons/icons8-attendance-100.png',
//                     //             fit: BoxFit.contain,
//                     //             scale: 2,
//                     //           ),
//                     //         ),
//                     //       ),
//                     //       GooglePoppinsWidgets(text: 'Attendence', fontsize: 10)
//                     //     ],
//                     //   ),
//                     // ),
//                     ContainerWidget(image: 'assets/flaticons/icons8-teacher-100.png',
//                       //  icon: Icons.person_2,
//                         text: 'Teachers',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[3]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/icons8-chat-100.png',
//                        // icon: Icons.chat_rounded,
//                         text: 'Chats',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[4]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/icons8-books-48.png',
//                       //  icon: Icons.import_contacts,
//                         text: 'Subjects',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[5]);
//                         }),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ContainerWidget(
//                       image: 'assets/flaticons/exam.png',
//                        // icon: Icons.list_alt,
//                         text: 'Exams',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[6]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/icons8-grades-100.png',
//                      //   icon: Icons.add_chart,
//                         text: 'Exam Results',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[7]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/icons8-notice-100.png',
//                       //  icon: Icons.notification_add,
//                         text: 'Notices',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[8]);
//                         }),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ContainerWidget(
//                       image: 'assets/flaticons/schedule.png',
//                      //   icon: Icons.event,
//                         text: 'Events',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[9]);
//                         }),
//                     ContainerWidget(
//                       image: 'assets/flaticons/meeting.png',
//                       //  icon: Icons.meeting_room,
//                         text: 'Meetings',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[10]);
//                         }),
//                          ContainerWidget(image: 'assets/flaticons/exam (1).png',
//                      //   icon: Icons.class_,
//                         text: 'Class Test',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[12]);
//                         }),
//                     // ContainerWidget(
//                     //   image: '',
//                     //   //  icon: Icons.bus_alert,
//                     //     text: 'Bus Route',
//                     //     onTap: () {
//                     //       Get.to(() => screenNavigationOfStd[11]);
//                     //     }),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
                   
//                     ContainerWidget(
//                       image: 'assets/flaticons/test.png',
//                        // icon: Icons.view_list,
//                         text: 'Monthly Class Test',
//                         onTap: () {
//                           Get.to(() => screenNavigationOfStd[13]);
//                         }),
//                     // ContainerWidget(
//                     //   image: '',
//                     //   //  icon: Icons.library_books,
//                     //     text: 'Library',
//                     //     onTap: () {}),
//                   ],
//                 ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //   children: [
//                 //     ContainerWidget(
//                 //       image: '',
//                 //       //  icon: Icons.food_bank,
//                 //          text: 'Canteen', onTap: () {}),
//                 //   ],
//                 // )
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// class CurvedPentagon extends StatelessWidget {
//   const CurvedPentagon({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100.0,
//       height: 100.0,
//       child: CustomPaint(
//         painter: CurvedPentagonPainter(),
//       ),
//     );
//   }
// }

// class CurvedPentagonPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..color = Colors.blue;

//     final Path path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(size.width, size.height * 0.4);
//     path.lineTo(size.width * 0.8, size.height);
//     path.lineTo(size.width * 0.2, size.height);
//     path.lineTo(0, size.height * 0.4);

//     // Smooth curves to create a curved shape
//     path.quadraticBezierTo(
//         size.width * 0.1, size.height * 0.2, size.width / 2, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// //  return const MaterialApp(
// //       home: MyTotalPointsPage(),
// //     );
