import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:excel_karoor/controllers/push_notification_controller/push_notification_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/events/event_display_school_level.dart';
import 'package:excel_karoor/view/home/student_home/Student%20Edit%20Profile/student_edit_profile_page.dart';
import 'package:excel_karoor/view/home/student_home/student_pages/notification_part_std.dart';
import 'package:excel_karoor/view/home/student_home/student_pages/qucik_action.dart';
import 'package:excel_karoor/view/home/student_home/student_pages/quick_action_view_all.dart';
import 'package:excel_karoor/view/home/student_home/student_pages/slider/slider.dart';

class NewStdHomePage extends StatelessWidget {
  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
  NewStdHomePage({super.key});

  @override


  @override
  Widget build(BuildContext context) {
        pushNotificationController.getUserDeviceID().then((value) async =>
        await pushNotificationController.allStudentDeviceID().then(
            (value) async => await pushNotificationController
                .allUSerDeviceID(
                    UserCredentialsController.studentModel!.userRole,UserCredentialsController.studentModel?.docid??"")));

    log(
      UserCredentialsController.studentModel!.docid,
    );

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
                  color: adminePrimayColor.withOpacity(0.1),
                  // const Color.fromARGB(255, 218, 247, 229),
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
                      child:
                          const QuickActionPart(), ////////////////////////////////////////////////////////all tab part
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 80.sp, right: 20.sp, left: 20.sp),
                        child:
                            NotificationPartOfStd() ///////////////////////////////////////////////////notification
                        ),
                  ],
                ),

                // child: const Column(
                //   children: [],
                // ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 60.sp, right: 10.sp, left: 10.sp),
                child:
                    const CarouselSliderStd()), //////////////////////////////////////////////////////details showing graph
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
                                  .studentModel!.profileImageUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            log(exception.toString());
                          },
                          radius: 25,
                        ),
                      ),
                    ), /////////////////////////////////////image
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        child: SizedBox(
                          width: 200,
                          child: GooglePoppinsEventsWidgets(
                            text: UserCredentialsController
                                .studentModel!.studentName,
                            fontsize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ), /////////////////////////////////////////name
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const StudentProfileEditPage();
                                },
                              ));
                              // Get.off(() => const StudentProfileEditPage());
                            },
                            icon: const Icon(Icons
                                .now_widgets))) ////////////////////////////////edit profile
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 340.sp, left: 40),
              child: const Row(
                children: [
                  QuickActionsWidgetAttendance(),
                  QuickActionsWidgetHW(),
                  QuickActionsWidgetTT(),
                  QuickActionsWidgetChat(),
                ],
              ),
            ), /////////////////////////////////////quick action
          ],
        ),
      )),
    );
  }

void callCloudFunction() async {
  try {
    // Replace 'YOUR_CLOUD_FUNCTION_URL' with the URL of your Cloud Function
    var url = Uri.parse('https://us-central1-vidya-veechi-8-feb-2024.cloudfunctions.net/attendanceListener');

    var response = await http.post(url);

    if (response.statusCode == 200) {
      log('Cloud Function executed successfully');
      // log(response.body.toString());
    } else {
      log('Failed to execute Cloud Function: ${response.statusCode}');
    }
  } catch (error) {
    log('Error calling Cloud Function: $error');
  }
}
}

