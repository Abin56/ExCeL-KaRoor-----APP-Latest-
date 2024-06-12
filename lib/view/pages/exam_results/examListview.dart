import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/exam_results/select_subject.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

class SelectExamWiseScreen extends StatelessWidget {
  final String classID;
  final String examLevel;

  const SelectExamWiseScreen(
      {required this.classID, required this.examLevel, super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Exam'.tr),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        //backgroundColor: adminePrimayColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(classID)
              .collection('Exam Results')
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return AnimationLimiter(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.all(w / 60),
                  crossAxisCount: columnCount,
                  children: List.generate(
                    snapshots.data!.docs.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 200),
                        columnCount: columnCount,
                        child: ScaleAnimation(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return SelectExamSubjectScreen(
                                    examLevel: examLevel,
                                    classID: classID,
                                    examId: snapshots.data!.docs[index]
                                        ['docid']);
                                },));
                                // Get.off(() => SelectExamSubjectScreen(
                                //     examLevel: examLevel,
                                //     classID: classID,
                                //     examId: snapshots.data!.docs[index]
                                //         ['docid']));
                              },
                              child: Container(
                                height: h / 100,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    bottom: w / 10,
                                    left: w / 50,
                                    right: w / 50),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(212, 67, 30, 203)
                                      .withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshots.data!.docs[index]['docid']}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12.w,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Text('');
            }
          }),
    );
  }
}
