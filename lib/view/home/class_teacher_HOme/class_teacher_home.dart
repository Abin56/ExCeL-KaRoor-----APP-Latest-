
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/class_teacher_mainhome.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/graph_class_teacher/showbottomgraph/viewAllGraph.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/quick_Action.dart';
import 'package:excel_karoor/view/home/events/event_display_school_level.dart';

class ClassTeacherHome extends StatelessWidget {
  const ClassTeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 160.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 247, 229),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.sp),
                      topRight: Radius.circular(15.sp)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 120.sp, right: 20.sp, left: 20.sp),
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: cblack.withOpacity(0.1)),
                            color: const Color.fromARGB(255, 218, 247, 229),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QUICK ACTIONS',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 11, 2, 74),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  viewallMenus();
                                },
                                child: Text(
                                  "View all",
                                  style:
                                      TextStyle(color: cblack.withOpacity(0.8)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 80.sp, right: 20.sp, left: 20.sp),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'NOTIFICATIONS',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 11, 2, 74),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 1.h,
                                    color: const Color.fromARGB(255, 11, 2, 74)
                                        .withOpacity(0.1),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 290.h,
                            child: ListView.separated(
                                // physics:
                                //     const NeverScrollableScrollPhysics(),
                                // shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: cWhite,
                                      radius: 25.sp,
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 20.sp,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "Holiday",
                                      style: TextStyle(
                                          color: const Color.fromARGB(255, 11, 2, 74),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: const Text(
                                      "Tommorow is Holiday",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 11, 2, 74),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                                itemCount: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                // child: const Column(
                //   children: [],
                // ),
              ),
            ),
            //................................>>>>>>>>>>>>>>>>>>>>>>>>>>>Carosal slider>>>>>>>>>>>>>>>>>>>>>>
            Padding(
              padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
              child: Center(
                child: Container(
                  height: 200.h,
                  width: 350.w,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: cblack,
                        ),
                      ],
                      color: cWhite,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CarouselSlider(
                    items: [
                      CaroselWidget(
                          sliderImagePath: imagesList[0], slidertext: "Exam"),
                      CaroselWidget(
                          sliderImagePath: imagesList[1],
                          slidertext: "Project"),
                      GestureDetector(
                        onTap: () => viewProjectGraph(),
                        child: CaroselWidget(
                            sliderImagePath: imagesList[2],
                            slidertext: "Attendence"),
                      ),
                      CaroselWidget(
                          sliderImagePath: imagesList[3],
                          slidertext: "Assignment")
                    ],
                    options: CarouselOptions(
                      // aspectRatio: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 230,

                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.9,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 05.sp,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              UserCredentialsController
                                      .teacherModel?.imageUrl ??
                                  " "),
                          radius: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        child: SizedBox(
                          width: 200,
                          child: GooglePoppinsEventsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.teacherName ??
                                " ",
                            fontsize: 17.sp,
                            color: cblack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.now_widgets)))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 340.sp, left: 40),
              child: const Row(
                children: [
                  QuickActionsWidgetAttendence(),
                  QuickActionWidgetExam(),
                  QuickActionWidgetChat(),
                  QuickActionWidgetTimetable(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
