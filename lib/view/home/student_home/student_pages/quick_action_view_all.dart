import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/all_class_test_monthly_show/all_class_list_monthly_show.dart';
import 'package:excel_karoor/view/home/all_class_test_show/all_class_list_show.dart';
import 'package:excel_karoor/view/home/bus_route_page/all_bus_list.dart';
import 'package:excel_karoor/view/home/events/event_list.dart';
import 'package:excel_karoor/view/home/exam_Notification/users_exam_list_view/user_exam_acc.dart';
import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
import 'package:excel_karoor/view/pages/Homework/view_home_work.dart';
import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
import 'package:excel_karoor/view/pages/Subject/subject_display.dart';
import 'package:excel_karoor/view/pages/attendence_book/attendence_book_status_month.dart';
import 'package:excel_karoor/view/pages/chat/student_section/student_chat_screen.dart';
import 'package:excel_karoor/view/pages/exam_results/for_users/select_examlevel_uses.dart';
import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class QuickActionPart extends StatelessWidget {
  const QuickActionPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
          border: Border.all(color: cblack.withOpacity(0.1)),
          color: adminePrimayColor.withOpacity(0.2),
          // const Color.fromARGB(255, 80, 200, 120).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.sp)),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUICK ACTIONS',
              style: TextStyle(
                  color: const Color.fromARGB(255, 11, 2, 74),
                  // const Color.fromARGB(255, 48, 88, 86),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                viewallMenus(context);
              },
              child: Text(
                "View all",
                style: TextStyle(color: cblack.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

viewallMenus(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  int columnCount = 3;
  final screenNavigationOfStd = [
    AttendenceBookScreenSelectMonth(
        schoolId: UserCredentialsController.schoolId!,
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!), //Attendence

    const ViewHomeWorks(), // Home Works

    const TimeTable(), //Time table

    const TeacherSubjectWiseList(navValue: 'student'), //Teachers

    const StudentChatScreen(), // Chats

    const StudentSubjectScreen(), //Subjects/////////<--

    const UserExmNotifications(), //Exam

    UsersSelectExamLevelScreen(
        classID: UserCredentialsController.classId!,
        studentId:
            UserCredentialsController.studentModel!.docid), ////// exam result

    NoticePage(), //Notice
    const EventList(), //Events

    SchoolLevelMeetingPage(), //Meetings

    AllClassTestPage(
      pageNameFrom: "student",
    ), //class test page
    AllClassTestMonthlyPage(
      pageNameFrom: "student",
    ),
    BusRouteListPage(),
    // HostelHomePage(),
  ];
  Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: cWhite,
          height: 420,
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         "assets/flaticons/menu.png",
              //         height: 30,
              //       ),
              //       GooglePoppinsWidgets(
              //         text: "All Categories",
              //         fontsize: 15,
              //         fontWeight: FontWeight.w500,
              //       )
              //     ],
              //   ),
              // ),
              Container(
                color: cWhite,
                height: 400,
                child: AnimationLimiter(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(w / 40),
                    crossAxisCount: columnCount,
                    children: List.generate(
                      13,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 750),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            scale: 1.5,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return  screenNavigationOfStd[index];
                                     },)),
                                  //  Get.off(() => screenNavigationOfStd[index]),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: w / 25,
                                      left: w / 30,
                                      right: w / 30,
                                      top: w / 25),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,border: Border.all(color: cblack.withOpacity(0.1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          boxShadow: const [BoxShadow(
                                            color:
                                             cWhite,
                                            //adminePrimayColor,
                                            spreadRadius: 1, offset: Offset(2, 2,)),],
                                            color: 
                                            adminePrimayColor,
                                           // cWhite,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: adminePrimayColor
                                                    .withOpacity(0.5))),
                                        child: Center(
                                          child: Image.asset(
                                            imageStd[index],
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.contain,
                                            scale: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: GooglePoppinsWidgets(
                                          text: stdtext[index],
                                          fontsize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
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
          ),
        ),
      ),
      backgroundColor: Colors.white);
}

List<String> imageStd = [
  'assets/flaticons/icons8-attendance-100.png',
  'assets/flaticons/icons8-homework-67.png',
  'assets/flaticons/study-time.png',
  'assets/flaticons/icons8-teacher-100.png',
  'assets/flaticons/icons8-chat-100.png',
  'assets/flaticons/icons8-books-48.png',
  'assets/flaticons/exam.png',
  'assets/flaticons/icons8-grades-100.png',
  'assets/flaticons/icons8-notice-100.png',
  'assets/flaticons/schedule.png',
  'assets/flaticons/meeting.png',
  'assets/flaticons/exam (1).png',
  'assets/flaticons/test.png',
];
List<String> stdtext = [
  'Attendance',
  'Homework',
  'Timetable',
  'Teachers',
  'Chats',
  'Subject',
  'Exams',
  'Exam Results',
  'Notices',
  'Events',
  'Meetings',
  'Class Test',
  'Monthly Test'
];
