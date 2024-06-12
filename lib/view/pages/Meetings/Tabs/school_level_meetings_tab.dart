import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/student_controller/student_meeting_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/Meetings/meetings_school_display.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../../constant/sizes/sizes.dart';
import '../../../widgets/fonts/google_poppins.dart';

class SchoolLevelMeetingPage extends StatelessWidget {
  SchoolLevelMeetingPage({super.key});
  final StudentMeetingController studentMeetingController =
      Get.put(StudentMeetingController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await studentMeetingController.getMeetings();
    // });

    // if (studentMeetingController.meetingLists.isEmpty) {
    //   return const Material(
    //     child: Center(
    //       child: Text("Empty meeting list"),
    //     ),
    //   );
    // }
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        //backgroundColor: adminePrimayColor,
        title: Text("Meetings".tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId!)
                    .collection(UserCredentialsController.batchId ?? "")
                    .doc(UserCredentialsController.batchId)
                    .collection('AdminMeetings')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      // studentMeetingController.meetingLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = snapshot.data?.docs[index].data();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              child: Card(
                                child: ListTile(
                                    shape: BeveledRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.2))),
                                    leading: const Icon(Icons.message_outlined),
                                    trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MeetingDisplaySchoolLevel(
                                              meetingModel: data,
                                            ),
                                          ),
                                        );
                                      },
                                      child: GooglePoppinsWidgets(
                                        text: "View".tr,
                                        fontsize: 16.h,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: GooglePoppinsWidgets(
                                          text: data?['topic'], fontsize: 19.h),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: GooglePoppinsWidgets(
                                              text: "Date : ${data?['date']}",
                                              fontsize: 14.h),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: GooglePoppinsWidgets(
                                              text: "Time : ${data?['time']}",
                                              fontsize: 14.h),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return kHeight10;
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No Data Found"),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
