import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/homework_controller/homework_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/home/teachers_home/homeworks/view_homework.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class ViewStudentsList extends StatelessWidget {
  const ViewStudentsList({
    super.key,
    required this.homeworkID,
    required this.homeWorkName,
  });
  final String homeworkID;
  final String homeWorkName;

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
            GooglePoppinsWidgets(
              text: "Homework submitted students".tr,
              fontsize: 20.h,
            ),
          ],
        ),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        // backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
          child: StreamBuilder(
            stream: server
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection("classes")
                .doc(UserCredentialsController.classId)
                .collection("Students")
                .snapshots(),
            builder: (context, firstsnapshot) {
              if (firstsnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (firstsnapshot.hasError) {
                return Center(child: Text('Error: ${firstsnapshot.error}'));
              } else if (!firstsnapshot.hasData ||
                  firstsnapshot.data!.docs.isEmpty) {
                return const Center(child: Text('no students '));
              }
              final List<DocumentSnapshot> firstCollection =
                  firstsnapshot.data!.docs;

              return StreamBuilder(
                stream: server
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection("classes")
                    .doc(UserCredentialsController.classId)
                    .collection("HomeWorks")
                    .doc(homeworkID)
                    .collection('Submit')
                    .snapshots(),
                builder: (context, secondSnapshot) {
                  if (secondSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final List<DocumentSnapshot> secondCollection =
                      secondSnapshot.data!.docs;

                  return ListView.separated(
                    itemCount: firstCollection.length,
                    separatorBuilder: ((context, index) {
                      return const Divider(
                        height: 10,
                      );
                    }),
                    itemBuilder: (context, index) {
                      final String studentID = firstCollection[index].id;
                      final bool isInSecondCollection = secondCollection
                          .any((document) => document.id == studentID);
                      bool isChecked = isInSecondCollection &&
                          secondCollection.firstWhere(
                              (doc) => doc.id == studentID)['Status'];
                      return Container(
                        decoration: const BoxDecoration(
                            // color: Color.fromARGB(236, 228, 244, 255),
                            ),
                        child: ListTile(
                          leading: isChecked
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 40,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.cancel_outlined,
                                  size: 40,
                                  color: cred,
                                ),
                          title: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GooglePoppinsWidgets(
                                  text:
                                      "Name : ${firstCollection[index]['studentName']} ",
                                  fontsize: 16.h,
                                  fontWeight: FontWeight.bold,
                                ),
                                isChecked
                                    ? GestureDetector(
                                        onTap: () {
                                          if (secondCollection.firstWhere(
                                                      (doc) =>
                                                          doc.id == studentID)[
                                                  'downloadUrl'] !=
                                              "") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  final List<String>
                                                      downloadUrl = [];
                                                  downloadUrl.add(
                                                      secondCollection
                                                              .firstWhere(
                                                                  (doc) =>
                                                                      doc.id ==
                                                                      studentID)[
                                                          'downloadUrl']);
                                                  return StudentHomeWork(
                                                    downloadUrl: downloadUrl,
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "No proof is provided",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                            Icons.close),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: GooglePoppinsWidgets(
                                          text: "View ",
                                          fontsize: 15.h,
                                          color: cblue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : const Text(""),
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                      text: "Status :  ",
                                      fontsize: 15.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    GooglePoppinsWidgets(
                                      text: isChecked
                                          ? "Completed"
                                          : "Not completed",
                                      fontsize: 15.h,
                                      color: isChecked ? Colors.green : cred,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: isInSecondCollection == true
                                      ? isChecked
                                      : false,
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    if (isInSecondCollection == true) {
                                      homeWorkController.status.value = value!;
                                      homeWorkController.updateCompleteStatus(
                                          homeworkID: homeworkID,
                                          docID: secondCollection.firstWhere(
                                                  (doc) => doc.id == studentID)[
                                              'docid']);
                                    } else {
                                      homeWorkController
                                          .setUpdateCompleteStatus(
                                        studentid: studentID,
                                        homeWorkName: homeWorkName,
                                        homeworkID: homeworkID,
                                        studentName: firstCollection[index]
                                            ['studentName'],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
