import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/student_home/graph_std/std_attendance_details.dart';
import 'package:excel_karoor/view/widgets/fonts/google_lemon.dart';
import 'package:excel_karoor/view/widgets/fonts/google_salsa.dart';

attendanceOnClickDetailsShowing() {
  Get.bottomSheet(SingleChildScrollView(
    child: Container(
        color: cWhite,
        width: double.infinity,
        height: 700.h,
        child: Wrap(
          children: <Widget>[
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.sp),
                      child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10.sp),
                            child: SizedBox(
                              height: 40.h,
                              child: Image.asset(
                                  'assets/flaticons/icons8-attendance-100.png'),
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child:  Text("Attendance Graph",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp),),
                          ),
                          
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 60.sp, bottom: 70.sp,left: 50.sp),
                        child: SizedBox(
                          height: 120.h,
                          child: const PieChartSample2(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 25.sp),
                        child: SizedBox(
                          height: 120.h,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child:  Row(
                                  children: [
                                    Indicator(
                                        color: Colors.purple,
                                         text: 'Total       ',
                                         isSquare: true,
                                       ),
                                       Text("50",style: TextStyle(fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                //  GraphDetailsWidgetOfStd(
                                //     image: "assets/flaticons/menu.png",
                                //     text: 'Total Days ',
                                //     number: '50'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child:  Row(
                                  children: [
                                    Indicator(
                                      color: Colors.blue,
                                      text: 'Present  ',
                                      isSquare: true,
                                    ),
                                    Text("45",style: TextStyle(fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    Indicator(
                                            color: Colors.green,
                                            text: 'Absent   ',
                                            isSquare: true,
                                          ),
                                          Text("5",style: TextStyle(fontWeight: FontWeight.w500))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ],),
                  ],
                ),
                //  Padding(
                //   padding: EdgeInsets.only(top: 10.sp),
                //   child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                //     children: [ GraphDetailsWidgetOfStd(text: 'Absent Days', number: '5', image: "assets/flaticons/menu.png"),],),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                  child: GoogleSalsaWidgets(
                    text: "Absent Days",
                    fontsize: 27.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  color: adminePrimayColor.withOpacity(0.2),
                  //const Color.fromARGB(255, 88, 167, 123).withOpacity(0.3),
                  width: double.infinity,
                  height: 600.h,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                        child: Container(
                          height: 45.h,
                          decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 1)],
                              color: cWhite),
                          child: Row(
                            children: [
                              Container(
                                color: cblue,
                                height: 45.h,
                                width: 45.w,
                                child: Center(
                                    child: GoogleLemonWidgets(
                                  text: index.toString(),
                                  fontsize: 17.sp,
                                  color: cWhite,
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.sp),
                                child: Center(
                                    child: GoogleSalsaWidgets(
                                        text: "27 September 2023",
                                        fontsize: 19.sp)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 16,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1.h,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
        ),
  ));
}
