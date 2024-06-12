import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/homework_controller/homework_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/Homework/upload_part.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/widgets/login_button.dart';

class UploadHomework extends StatelessWidget {
  const UploadHomework({
    super.key,
    required this.homeWorkName,
    required this.homeworkID,
  });
  final String homeWorkName;
  final String homeworkID;

  @override
  Widget build(BuildContext context) {
    final HomeWorkListController homeWorkController =
        Get.put(HomeWorkListController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          children: [
            kHeight20,
            GooglePoppinsWidgets(text: "Submit HomeWork".tr, fontsize: 20.h)
          ],
        ),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        // backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: StreamBuilder(
            stream: server
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection("classes")
                .doc(UserCredentialsController.classId!)
                .collection("HomeWorks")
                .doc(homeworkID)
                .collection('Submit')
                .doc(UserCredentialsController.studentModel?.docid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                      text: "Task :",
                      fontsize: 25.h,
                      fontWeight: FontWeight.bold,
                    ),
                    kHeight40,
                    GooglePoppinsWidgets(
                      text: homeWorkName,
                      fontsize: 15.h,
                      fontWeight: FontWeight.w500,
                    ),
                    kHeight50,
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UploadHomeworkToTeacher(
                                  homeWorkName: homeWorkName,
                                  homeworkID: homeworkID,
                                );
                              },
                            ),
                          );
                        },
                        child: loginButtonWidget(
                          height: 40,
                          width: 80,
                          text: "Upload",
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                snapshot.data!['Status'] == false
                    ? homeWorkController.homeworkStatus.value = true
                    : false;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                      text: "Task :",
                      fontsize: 25.h,
                      fontWeight: FontWeight.bold,
                    ),
                    kHeight40,
                    GooglePoppinsWidgets(
                      text: homeWorkName,
                      fontsize: 15.h,
                      fontWeight: FontWeight.w500,
                    ),
                    kHeight50,
                    Row(
                      children: [
                        Text(
                          "Status : ",
                          style: TextStyle(
                            fontSize: 20.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data!['Status'] == true
                              ? "Completed"
                              : "Not Completed",
                          style: TextStyle(
                            fontSize: 20.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    kHeight50,
                    snapshot.data!['Status'] == false
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UploadHomeworkToTeacher(
                                        homeWorkName: homeWorkName,
                                        homeworkID: homeworkID,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: loginButtonWidget(
                                height: 40,
                                width: 80,
                                text: "Upload",
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
