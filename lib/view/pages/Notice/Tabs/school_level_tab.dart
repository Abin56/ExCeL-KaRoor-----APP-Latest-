import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/student_controller/student_notice_controller/student_notice_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/pages/Notice/notice_school_display_page.dart';

import '../../../widgets/fonts/google_poppins.dart';

class SchoolLevelNoticePage extends StatelessWidget {
  SchoolLevelNoticePage({super.key});

  // final StudentNoticeController studentNoticeController =
  //     Get.put(StudentNoticeController());
  final StudentNoticeController studentNoticeController =
      Get.put(StudentNoticeController());

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await studentNoticeController.getSchoolLevelNotices();
    // });

    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId!)
                .collection(UserCredentialsController.batchId ?? "")
                .doc(UserCredentialsController.batchId)
                .collection('AdminNotices')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  //   reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  // studentNoticeController.schoolLevelNoticeLists.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = snapshot.data?.docs[index].data();
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.h, right: 10.w, left: 10.w),
                      child: Card(
                        child: ListTile(
                          shape: BeveledRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2))),
                          leading: const Image(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                          title: GooglePoppinsWidgets(
                            fontsize: 22.h,
                            text: data?['heading'],
                            //  studentNoticeController
                            //     .schoolLevelNoticeLists[index].heading,
                          ),
                          subtitle: GooglePoppinsWidgets(
                              fontsize: 14.h, text: data?['publishedDate']
                              // studentNoticeController
                              //     .schoolLevelNoticeLists[index].publishedDate,
                              ),
                          trailing: InkWell(
                            child: GooglePoppinsWidgets(
                                text: "View".tr,
                                fontsize: 16.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoticeClassDisplayPage(noticeModel: data
                                            // studentNoticeController
                                            //     .schoolLevelNoticeLists[index]
                                            ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Text('');
                  },
                );
              } else {
                return const Center(
                  child: Text("No Data Found"),
                );
              }
            }));
  }
}
