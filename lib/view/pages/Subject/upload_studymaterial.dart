import 'dart:developer';
import 'dart:io';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/Subject/show_teacher_studymaterials.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:excel_karoor/widgets/textformfield.dart';
import 'package:uuid/uuid.dart';

import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';

// ignore: must_be_immutable
class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial(
      {super.key,
      required this.subjectID,
      required this.subjectName,
      required this.chapterID,
      required this.chapterName});

  final String subjectID;
  final String subjectName;
  final String chapterName;
  final String chapterID;
  bool stat = false;

  @override
  State<UploadStudyMaterial> createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  // ignore: unused_field
  final String _selectedLeaveType = '';
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  File? filee;
  String downloadUrl = '';

  Future<String> pickAFile(file) async {
    try {
      setState(() {
        widget.stat = true;
      });

      String uid2 = const Uuid().v1();

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(
              "files/studymaterials/${widget.subjectName}/${widget.chapterName}/$uid2")
          .putFile(file);

      final TaskSnapshot snap = await uploadTask;
      downloadUrl = await snap.ref.getDownloadURL();
      log('downloadUrl $downloadUrl');
      setState(() {
        widget.stat = true;
      });

      return downloadUrl;
    } catch (e) {
      log(e.toString());
      setState(() {
        widget.stat = true;
      });
      return e.toString();
    }
  }

  Future<void> uploadToFirebase() async {
    try {
      String uid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(widget.subjectID)
          .collection('Chapters')
          .doc(widget.chapterID)
          .collection('StudyMaterials')
          .doc(uid)
          .set({
        'subjectName': widget.subjectName,
        'chapterName': widget.chapterName,
        'chapterID': widget.chapterID,
        'subjectID': widget.subjectID,
        'topicName': topicController.text,
        'title': titleController.text,
        'downloadUrl': downloadUrl,
        'docid': uid,
        'uploadedBy': UserCredentialsController.teacherModel!.teacherName
      }).then((value) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Study Materials'.tr),
                  content: Text('New Study Material Added!'.tr),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'.tr),
                    )
                  ],
                );
              }));

      setState(() {
        widget.stat = false;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        widget.stat = false;
      });
    }
  }

  final UploadStudyMaterialsFormController uploadStudyMaterialsFormController =
      Get.put(UploadStudyMaterialsFormController());
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: cblack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Study material".tr,
          style: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: cblack),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight10,
            SizedBox(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: uploadStudyMaterialsFormController.formKey,
                  child: Column(
                    children: [
                      GoogleMonstserratWidgets(
                          text: 'Study material upload'.tr,
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kWidth20,
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  allowedExtensions: ['pdf'],
                                  type: FileType.custom);

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            setState(() {
                              filee = file;
                            });
                          } else {
                            log('No file selected');
                          }
                        },
                        child: Container(
                          height: 130.h,
                          width: double.infinity - 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: cblue,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_file_rounded,
                                  color: cblue, size: 30.w, weight: 10),
                              GoogleMonstserratWidgets(
                                text: (filee == null)
                                    ? 'Upload file here'
                                    : filee!.path.split('/').last,
                                fontsize: 15,
                                color: cblue,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              kWidth20,
                            ],
                          ),
                        ),
                      ),
                      kWidth20,
                      kHeight20,
                      kHeight20,
                      TextFormFieldWidget(
                        function: checkFieldEmpty,
                        textEditingController: topicController,
                        hintText: 'Enter Topic',
                      ),
                      kHeight20,
                      TextFormFieldWidget(
                        function: checkFieldEmpty,
                        textEditingController: titleController,
                        hintText: 'Enter Title',
                      ),
                      kHeight40,
                      (widget.stat == true)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (uploadStudyMaterialsFormController
                                    .formKey.currentState!
                                    .validate()) {
                                  if (filee != null) {
                                    await pickAFile(filee);
                                    await uploadToFirebase().then((value) {
                                      topicController.clear();
                                      titleController.clear();
                                      filee = null;
                                    });
                                  } else {
                                    showToast(msg: "Select a pdf");
                                  }
                                }

                                //check here
                              },
                              child: ButtonContainerWidget(
                                curving: 18,
                                colorindex: 2,
                                height: 60.w,
                                width: 300.w,
                                child: Center(
                                  child: Text(
                                    "SUBMIT".tr,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 13.w,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                      kHeight20,
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudyMaterials(
                                        subjectID: widget.subjectID,
                                        chapterID: widget.chapterID,
                                      )));
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 60.w,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "UPLOADED STUDY MATERIALS".tr,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            kHeight30,
          ],
        ),
      ),
    );
  }
}
