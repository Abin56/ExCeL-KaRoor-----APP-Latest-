import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/studentAttendence/take_attentence.dart';

class TakeAttentenceSubjectWise extends StatelessWidget {
  final String schoolId;
  final String batchId;
  final String periodTokenID;
  final int periodNumber;
  final String classID;
  const TakeAttentenceSubjectWise(
      {required this.batchId,
      required this.classID,
      required this.schoolId,
      required this.periodTokenID,
      required this.periodNumber,
      super.key});

  @override
  Widget build(BuildContext context) {
    log(batchId);
    log(classID);
    log(schoolId);
    log(UserCredentialsController.teacherModel!.docid!);
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subject'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(schoolId)
            .collection(batchId)
            .doc(batchId)
            .collection("classes")
            .doc(classID)
            .collection('teachers')
            .doc(UserCredentialsController.teacherModel!.docid)
            .collection("teacherSubject")
            .orderBy('subjectName', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimationLimiter(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  snapshot.data!.docs.length,
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
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  TakeAttenenceScreen(
                                  periodNumber: periodNumber.toString(),
                                  periodTokenID: periodTokenID,
                                  subjectID: snapshot.data!.docs[index]
                                      ['docid'],
                                  subjectName: snapshot.data!.docs[index]
                                      ['subjectName'],
                                  classID: classID,
                                  schoolID: schoolId,
                                  teacheremailID: UserCredentialsController
                                      .teacherModel!.docid!,
                                  batchId: batchId);
                  },));
                              // Get.off(() => TakeAttenenceScreen(
                              //     periodNumber: periodNumber.toString(),
                              //     periodTokenID: periodTokenID,
                              //     subjectID: snapshot.data!.docs[index]
                              //         ['docid'],
                              //     subjectName: snapshot.data!.docs[index]
                              //         ['subjectName'],
                              //     classID: classID,
                              //     schoolID: schoolId,
                              //     teacheremailID: UserCredentialsController
                              //         .teacherModel!.docid!,
                              //     batchId: batchId)
                              //     );
                            },
                            child: Container(
                              height: h / 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: w / 10, left: w / 50, right: w / 50),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(212, 67, 30, 203)
                                    .withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.docs[index]['subjectName'],
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
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
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }
}
