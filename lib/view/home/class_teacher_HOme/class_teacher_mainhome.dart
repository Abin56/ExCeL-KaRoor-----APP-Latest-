//ClassTeacherMainHomeScreen

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:excel_karoor/controllers/log_out/user_logout_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/gemini_ChatBOT/geminiscreen.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/class_teacher_home.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/assignmentGraph.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/attendenceGraph.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/exam.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/projectGraph.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/leave_letters/leave_lettersList.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/my_students/my_students.dart';
import 'package:excel_karoor/view/home/drawer/class_teacher.dart';
import 'package:excel_karoor/view/home/events/event_list.dart';
import 'package:excel_karoor/view/home/exam_Notification/teacher_adding/add_subject.dart';
import 'package:excel_karoor/view/home/student_home/subjects/subject_display.dart';
import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
import 'package:excel_karoor/view/pages/Homework/homework.dart';
import 'package:excel_karoor/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:excel_karoor/view/pages/Notice/notice_list.dart';
import 'package:excel_karoor/view/pages/attendence_book/attendence_book_status_month.dart';
import 'package:excel_karoor/view/pages/chat/teacher_section/teacher_chat-screen.dart';
import 'package:excel_karoor/view/pages/live_classes/teacher_live_section/create_room.dart';
import 'package:excel_karoor/view/pages/recorded_videos/select_subjects.dart';
import 'package:excel_karoor/view/pages/studentAttendence/select_period.dart';
import 'package:excel_karoor/view/pages/teacher_list/teacher_list.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/view/widgets/icon/icon_widget.dart';
import 'package:line_icons/line_icons.dart';

class ClassTeacherMainHomeScreen extends StatefulWidget {
  const ClassTeacherMainHomeScreen({super.key});

  @override
  State<ClassTeacherMainHomeScreen> createState() =>
      _ClassTeacherMainHomeScreenState();
}

class _ClassTeacherMainHomeScreenState
    extends State<ClassTeacherMainHomeScreen> {
  UserLogOutController userLogOutController = Get.put(UserLogOutController());
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const ClassTeacherHome(),
      RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      CreateRoomScreen(),
      const GeminiAIBOT(),
    ];
    return Scaffold(
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
            color: Colors.black,
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
              topLeft: Radius.circular(0), topRight: Radius.circular(0)),
          border: Border.all(color: Colors.white.withOpacity(0.13)),

          color: const Color.fromARGB(255, 92, 180, 132),
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
      drawer: Drawer(
          backgroundColor: cWhite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClassTeacherHeaderDrawer(),
                MyDrawerList(context),
              ],
            ),
          ),
        ),
    );
  }
}

//ClassTeacherMainHomeScreen.........................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


viewallMenus() {
  // ignore: unused_local_variable
  UserLogOutController userLogOutController = Get.put(UserLogOutController());
  final screenNavigationOfClsTr = [
    SelectPeriodWiseScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!), //Take Attendance

    AttendenceBookScreenSelectMonth(
      batchId: UserCredentialsController.batchId!,
      classID: UserCredentialsController.classId!,
      schoolId: UserCredentialsController.schoolId!,
    ), ////////////  Attendance book

    const TeacherChatScreen(), // Chats

    const TimeTable(), //TimeTable

    LeaveLettersListviewScreen(
        schooilID: UserCredentialsController.schoolId!,
        batchID: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!), //Leave letters

    HomeWorkUpload(
      batchId: UserCredentialsController.batchId!,
      classId: UserCredentialsController.classId!,
      schoolID: UserCredentialsController.schoolId!,
      teacherID: UserCredentialsController.teacherModel!.docid!,
    ), //////////Home Work

    const MyStudents(), //My students

    const StudentSubjectHome(), //Subject

      SchoolLevelMeetingPage(), //Meetings

    const AddTimeTable(), //Exam

    // SelectExamLevelScreen(classId: classID), //exam result upload

    NoticePage(), //Notice

    const EventList(), //Events

    const TeacherSubjectWiseList(navValue: ''), //Teachers

    /////// all bus
  ];

  Get.bottomSheet(
      SingleChildScrollView(
        child: SizedBox(
          height: 700,
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: Text("All Catagories", style: TextStyle(fontSize: 15)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       ContainerWidget(
                              // icon: Icons.waving_hand,
                              text: ' Take Attendance',
                              onTap: () {
                                Get.to(() =>screenNavigationOfClsTr[0]);
                              }, 
                              image: 'assets/flaticons/roll-call.png',
                            ),
                      ContainerWidget(
                        //icon:images.import_contacts,
                        text: 'Attendance Book',
                        onTap: () => Get.to(() => screenNavigationOfClsTr[1]),
        
                       image: 'assets/flaticons/book.png',
                      ),
                       ContainerWidget(
                              //icon:images.chat_rounded,
                              text: 'Chats',
                              onTap: () {
                                   Get.to(() =>screenNavigationOfClsTr[2]);
                              },image: 'assets/flaticons/icons8-chat-100.png',
                            ),
                           
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        ContainerWidget(
                              //image:images.waving_hand,
                              text: ' Time Table',
                              onTap: () {
                                   Get.to(() =>screenNavigationOfClsTr[3]);
                              },image: 'assets/flaticons/worksheet.png',
                            ),
                      ContainerWidget(
                        //icon:images.import_contacts,
                        text: 'Leave Letters',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[4]);
                        },
                       image: 'assets/flaticons/email.png',
                      ),
                      ContainerWidget(
                        //icon:images.chat_rounded,
                        text: 'Home Work',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[5]);
                        },
                       image: 'assets/flaticons/homework.png',
                      ),
                      
                     
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       ContainerWidget(
                        //image:images.waving_hand,
                        text: 'My Students ',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[6]);
                        },
                       image: 'assets/flaticons/students.png',
                      ),
                      ContainerWidget(
                        //icon:images.import_contacts,
                        text: 'Study Materials',
                       onTap: () {
                          Get.to(() => screenNavigationOfClsTr[7]);
                        },
                       image: 'assets/flaticons/school-material.png',
                      ),
                      ContainerWidget(
                        //icon:images.chat_rounded,
                        text: 'Meeting',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[8]);
                        },
                       image: 'assets/flaticons/teamwork.png',
                      ),
                     
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       ContainerWidget(
                              //image:images.waving_hand,
                              text: 'Exams ',
                              onTap: () {
                                   Get.to(() =>screenNavigationOfClsTr[9]);
                              },image: 'assets/flaticons/icons8-grades-100.png',
                            ),
                        ContainerWidget(
                        //icon:images.import_contacts,
                        text: 'Notices',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[10]);
                        },
                       image: 'assets/flaticons/icons8-notice-100.png',
                      ),
                      ContainerWidget(
                        //icon:images.chat_rounded,
                        text: 'Events',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[11]);
                        },
                       image: 'assets/flaticons/calendar.png',
                      ),
                    
                     
                    ],
                    
                  ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       
                        ContainerWidget(
                        //image:images.waving_hand,
                        text: 'Teacher ',
                        onTap: () {
                          Get.to(() => screenNavigationOfClsTr[12]);
                        },
                       image: 'assets/flaticons/female.png',
                      ),
                      
                     
                    ],
                    
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white);
}

class CaroselWidget extends StatelessWidget {
 final Widget sliderImagePath;
 final String slidertext;
  const CaroselWidget({
    required this.sliderImagePath,
    required this.slidertext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: sliderImagePath),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: GooglePoppinsWidgets(
            text: slidertext,
            fontsize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

final List<Widget> imagesList = [
  const ExamGraphClassTeacher(),
  const PrjectClassThrGraph(),
  const AttendenceClassThrGraph(),
  AssignmentGraphClassTeacher(),
];
