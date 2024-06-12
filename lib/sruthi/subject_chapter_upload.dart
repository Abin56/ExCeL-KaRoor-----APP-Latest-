import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/Subject/sunject_display_teacher.dart';
import 'package:excel_karoor/view/widgets/button_container_widget.dart';
import 'package:excel_karoor/widgets/Iconbackbutton.dart';
import 'package:uuid/uuid.dart';

import '../controllers/userCredentials/user_credentials.dart';

// ignore: must_be_immutable
class ChapterUpoload extends StatelessWidget {
  ChapterUpoload({super.key, required this.subjectID});

  final ChapterUploadController chapterUploadController = Get.put(ChapterUploadController());

  TextEditingController chapterNumberController = TextEditingController();
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();

  String subjectID;

  Uuid idgen = const Uuid();
  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> uploadChapters(id) async {
    FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('subjects')
        .doc(subjectID)
        .collection('Chapters')
        .doc(id)
        .set({
      'chapterNumber': chapterNumberController.text,
      'chapterName': chapterNameController.text,
      'subjectName': subjectNameController.text,
      'docid': id,
      'uploadedBy':
          UserCredentialsController.teacherModel!.teacherName.toString()
    }).then((value) {
      chapterNameController.clear();
      chapterNumberController.clear();
      subjectNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButtonBackWidget(
              color: cWhite,
            ),
            Text("Chapter Upload".tr),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: chapterUploadController. formKey,
          child: Column(
            children: [
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter values';
                    }
                    return null;
                  },
                  textfromController: chapterNumberController,
                  text: "Chapter No.".tr,
                  hintText: "Chapter Number".tr),
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter values';
                    }
                    return null;
                  },
                  textfromController: chapterNameController,
                  text: "Chapter Name".tr,
                  hintText: "Chapter Name".tr),
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter values';
                    }
                    return null;
                  },
                  textfromController: subjectNameController,
                  text: "Subject Name".tr,
                  hintText: "Subject Name".tr),
              kHeight20,
              GestureDetector(
                onTap: () {
                  //print('subjejctname: ${subjectNameController.text}');
        
                  if (chapterUploadController.formKey.currentState!.validate()) {
                    String generatedDocID =
                        subjectNameController.text.trim() + idgen.v1();
                    uploadChapters(generatedDocID).then((value) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Chapter Upload'.tr),
                              content: Text('New Chapter Added!'.tr),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: MaterialButton(
                                    child: Text('Ok'.tr),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                )
                              ],
                            );
                          });
                    });
                  }
                },
                child: ButtonContainerWidget(
                  curving: 18,
                  colorindex: 2,
                  height: 70.h,
                  width: 300.w,
                  child: Center(
                    child: Text(
                      "SUBMIT".tr,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubjectWiseDisplayTeacher(subjectID: subjectID),
                      ));
                },
                child: ButtonContainerWidget(
                  curving: 18,
                  colorindex: 2,
                  height: 70.h,
                  width: 300.w,
                  child: Center(
                    child: Text(
                      "UPLOAD STUDY MATERIALS".tr,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
