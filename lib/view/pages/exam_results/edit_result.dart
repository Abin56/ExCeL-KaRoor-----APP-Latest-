import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';

import '../../../controllers/userCredentials/user_credentials.dart';

class EditExamResultScreen extends StatelessWidget {
  final String examlevel;
  final String classID;
  final String examId;
  final String subjectID;
  const EditExamResultScreen({
    super.key,
    required this.classID,
    required this.examId,
    required this.subjectID,
    required this.examlevel,
  });

  @override
  Widget build(BuildContext context) {
    log('class Id :::$classID');
    log('exam id :::$examId');
    log('subjectid ::;$subjectID');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: GoogleMonstserratWidgets(
            text: 'Mark List'.tr, fontsize: 19.w, fontWeight: FontWeight.w600),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                kWidth10,
                SizedBox(
                    height: 35.w,
                    width: 30.w,
                    //
                    child: Center(
                        child: GoogleMonstserratWidgets(
                            text: "No:", fontsize: 14.w))),
                SizedBox(
                    height: 35.w,
                    width: 160.w,

                    //,
                    child: Center(
                        child: GoogleMonstserratWidgets(
                            text: "Name", fontsize: 14.w))),
                SizedBox(
                    height: 35.w,
                    width: 100.w,

                    // ,
                    child: Center(
                        child: GoogleMonstserratWidgets(
                            text: "Marks", fontsize: 14.w))),
                SizedBox(
                    height: 35.w,
                    width: 50.w,
                    child: Center(
                        child: GoogleMonstserratWidgets(
                            text: "Grade ", fontsize: 14.w))),
                kWidth10,
                SizedBox(
                    height: 35.w,
                    width: 60.w,
                    child: Center(
                        child: GoogleMonstserratWidgets(
                            text: "Delete", fontsize: 14.w))),
              ],
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('SchoolListCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection(UserCredentialsController.batchId!)
                        .doc(UserCredentialsController.batchId!)
                        .collection('classes')
                        .doc(classID)
                        .collection('Exam Results')
                        .doc(examId)
                        .collection('Subjects')
                        .doc(subjectID)
                        .collection('MarkList')
                        .snapshots(),
                    builder: (context, snaps) {
                      if (snaps.hasData) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 50.w,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          height: 35.w,
                                          width: 30.w,
                                          child: Center(
                                              child: GoogleMonstserratWidgets(
                                                  text: '${index + 1}',
                                                  fontsize: 16.w))),
                                      // kWidth20,
                                      SizedBox(
                                          height: 35.w,
                                          width: 160.w,
                                          child: Center(
                                              child: GoogleMonstserratWidgets(
                                                  text: snaps.data!.docs[index]
                                                      ['studentName'],
                                                  fontsize: 14.w))),
                                      // const Spacer(),
                                      SizedBox(
                                          height: 35.w,
                                          width: 50.w,
                                          child: Center(
                                              child: GoogleMonstserratWidgets(
                                                  text: snaps.data!.docs[index]
                                                      ['obtainedMark'],
                                                  fontsize: 16.w))),
                                      SizedBox(
                                        height: 35.w,
                                        width: 35.w,
                                        child: IconButton(
                                            onPressed: () async {
                                              editMark(
                                                  context,
                                                  classID,
                                                  examId,
                                                  subjectID,
                                                  snaps.data!.docs[index]
                                                      ['obtainedMark'],
                                                  snaps.data!.docs[index]
                                                      ['studentid'],
                                                  examlevel);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: 25.w,
                                            )),
                                      ),
                                      //  kWidth10,
                                      SizedBox(
                                        height: 35.w,
                                        width: 50.w,
                                        child: Center(
                                          child: GoogleMonstserratWidgets(
                                              text: snaps.data!.docs[index]
                                                  ['obtainedGrade'],
                                              fontsize: 16.w),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.w,
                                        width: 35.w,
                                        child: IconButton(
                                            onPressed: () async {
                                              editGrade(
                                                  context,
                                                  classID,
                                                  examId,
                                                  subjectID,
                                                  snaps.data!.docs[index]
                                                      ['obtainedGrade'],
                                                  snaps.data!.docs[index]
                                                      ['studentid'],
                                                  examlevel);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: 25.w,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 35.w,
                                        width: 40.w,
                                        child: IconButton(
                                            onPressed: () async {
                                              deleteResult(
                                                  context,
                                                  classID,
                                                  examId,
                                                  subjectID,
                                                  snaps.data!.docs[index]
                                                      ['obtainedGrade'],
                                                  snaps.data!.docs[index]
                                                      ['studentid'],
                                                  examlevel);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 25.w,
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: snaps.data!.docs.length),
                        );
                      } else {
                        return const Text('');
                      }
                    }))
          ],
        ),
      )),
    );
  }
}

editMark(BuildContext context, String classID, String examId, String subjectID,
    String mark, String studentID, String examlevel) async {
  log('class id :::: $classID');
  log('examid :::: $examId');
  log('subjectid :::$subjectID');
  log('studentid ::: $studentID');
  //final formkey = GlobalKey<FormState>();
  final EditResultFormController editResultFormController =
      Get.put(EditResultFormController());
  TextEditingController markController = TextEditingController();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Mark'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Form(
                key: editResultFormController.formKey,
                child: TextFormField(
                  validator: checkFieldEmpty,
                  keyboardType: TextInputType.number,
                  controller: markController,
                  decoration: InputDecoration(hintText: mark),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              if (editResultFormController.formKey.currentState?.validate() ??
                  false) {
                FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(classID)
                    .collection('Exam Results')
                    .doc(examId)
                    .collection('Subjects')
                    .doc(subjectID)
                    .collection('MarkList')
                    .doc(studentID)
                    .update({'obtainedMark': markController.text.trim()}).then(
                        (value) async {
                  log("classID ::$classID");
                  log("studentID ::$studentID");
                  log("examlevel ::$examlevel");
                  log("examId ::$examId");
                  log("subjectID ::$subjectID");
                  await FirebaseFirestore.instance
                      .collection('SchoolListCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection(UserCredentialsController.batchId!)
                      .doc(UserCredentialsController.batchId!)
                      .collection('classes')
                      .doc(classID)
                      .collection('Students')
                      .doc(studentID)
                      .collection("Exam Results")
                      .doc(examId)
                      .collection('Marks')
                      .doc(subjectID)
                      .update({
                    'obtainedMark': markController.text.trim()
                  }).then((value) async {
                    showToast(msg: 'Mark Changed');
                    Navigator.pop(context);
                  });
                });
              }
            },
          ),
        ],
      );
    },
  );
}

editGrade(BuildContext context, String classID, String examId, String subjectID,
    String mark, String studentID, String examlevel) async {
  log('class id :::: $classID');
  log('examid :::: $examId');
  log('subjectid :::$subjectID');
  log('studentid ::: $studentID');
  // final formKey = GlobalKey<FormState>();
  final EditResultFormController editResultFormController =
      Get.put(EditResultFormController());
  TextEditingController markController = TextEditingController();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Mark'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Form(
                key: editResultFormController.formKey,
                child: TextFormField(
                  validator: checkFieldEmpty,
                  controller: markController,
                  decoration: InputDecoration(hintText: mark),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              if (editResultFormController.formKey.currentState?.validate() ??
                  false) {
                FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(classID)
                    .collection('Exam Results')
                    .doc(examId)
                    .collection('Subjects')
                    .doc(subjectID)
                    .collection('MarkList')
                    .doc(studentID)
                    .update({'obtainedGrade': markController.text.trim()}).then(
                        (value) {
                  FirebaseFirestore.instance
                      .collection('SchoolListCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection(UserCredentialsController.batchId!)
                      .doc(UserCredentialsController.batchId!)
                      .collection('classes')
                      .doc(classID)
                      .collection('Students')
                      .doc(studentID)
                      .collection("Exam Results")
                      .doc(examId)
                      .collection('Marks')
                      .doc(subjectID)
                      .update({
                    'obtainedGrade': markController.text.trim()
                  }).then((value) {
                    showToast(msg: 'Grade Changed');
                    Navigator.pop(context);
                  });
                });
              }
            },
          ),
        ],
      );
    },
  );
}

deleteResult(BuildContext context, String classID, String examId,
    String subjectID, String mark, String studentID, String examlevel) async {
  log('class id :::: $classID');
  log('examid :::: $examId');
  log('subjectid :::$subjectID');
  log('studentid ::: $studentID');
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text('Are you sure to remove result ?')],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection('SchoolListCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection('classes')
                  .doc(classID)
                  .collection('Exam Results')
                  .doc(examId)
                  .collection('Subjects')
                  .doc(subjectID)
                  .collection('MarkList')
                  .doc(studentID)
                  .delete()
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(classID)
                    .collection('Students')
                    .doc(studentID)
                    .collection("Exam Results")
                    .doc(examId)
                    .collection('Marks')
                    .doc(subjectID)
                    .delete()
                    .then((value) {
                  showToast(msg: 'Result Removed');
                  Get.back();
                });
              });
            },
          ),
        ],
      );
    },
  );
}
