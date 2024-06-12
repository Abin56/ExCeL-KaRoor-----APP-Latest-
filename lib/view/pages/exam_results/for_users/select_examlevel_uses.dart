import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/exam_results/for_users/view_student_result.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class UsersSelectExamLevelScreen extends StatelessWidget {
  final String classID;
  final String studentId;
  const UsersSelectExamLevelScreen(
      {super.key, required this.classID, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Results".tr),
        // backgroundColor: adminePrimayColor,
        foregroundColor: cWhite,
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(classID)
                    .collection('Students')
                    .doc(studentId)
                    .collection('Exam Results')
                    //.doc(schoolLevelExamistValue!['examName'])
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                     return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 5 ,),
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshots.data!.docs[index].data();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return ViewExamResultsScreen(
                            classID: classID,
                            studentId: studentId,
                            examdocid: snapshots.data!.docs[index]
                                ['docid']);
                          },));
                        },
                        child: Container(
                         // width: 320.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: adminePrimayColor,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                               const Padding(
                                 padding: EdgeInsets.all(4.0),
                                 child: Icon(
                                      Icons.receipt,
                                      color: cWhite,
                                    ),
                               ),
                                  GooglePoppinsWidgets(
                                      fontsize: 20.h,
                                      text: data['docid'],
                                       //   schoolLevelExamistValue?['examName'],
                                      color: Colors.white),
                              // TextButton.icon(
                              //     onPressed: () async {
                              //       Navigator.push(context, MaterialPageRoute(
                              //         builder: (context) {
                              //           return ViewExamResultsScreen(
                              //     classID: classID,
                              //     studentId: studentId,
                              //     examdocid: snapshots.data!.docs[index]
                              //         ['docid']);
                              //           //  UsersSelectExamWiseScreen(
                              //           //   classID: classID,
                              //           //   //   examLevel: 'School Level',
                              //           //   studentId: studentId,
                              //           // );
                              //         },
                              //       ));
                              //       // Get.off(() => UsersSelectExamWiseScreen(
                              //       //       classID: classId,
                              //       //       examLevel: 'School Level',
                              //       //       studentId: studentID,
                              //       //     ));
                              //     },
                              //     icon: const Icon(
                              //       Icons.receipt,
                              //       color: cWhite,
                              //     ),
                              //     label: GooglePoppinsWidgets(
                              //         fontsize: 20.h,
                              //         text: data['docid'],
                              //          //   schoolLevelExamistValue?['examName'],
                              //         color: Colors.white)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  }
                 else{
                 return const Center(child: Text("No Exams Results Found"));
                 }
                }),
          )),
    );
  }
}

//  .collection('SchoolListCollection')
//                                     .doc(UserCredentialsController.schoolId)
//                                     .collection(
//                                         UserCredentialsController.batchId!)
//                                     .doc(UserCredentialsController.batchId!)
//                                     .collection('classes')
//                                     .doc(classID)
//                                     .collection('Students')
//                                      .doc(studentId)
//                                      .collection('Exam Results')
//                                     .doc(schoolLevelExamistValue!['examName'])
