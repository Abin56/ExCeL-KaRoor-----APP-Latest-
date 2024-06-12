import 'dart:developer';
import 'dart:io';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/Signup_Image_Selction/image_selection.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/button_container_widget.dart';
import 'package:excel_karoor/view/widgets/button_homework_photo_upload_container';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class UploadHomeworkToTeacherParent extends StatefulWidget {
  UploadHomeworkToTeacherParent({
    super.key,
    required this.homeworkID,
    required this.homeWorkName,
  });

  final String homeworkID;
  final String homeWorkName;
  bool stat = false;

  @override
  State<UploadHomeworkToTeacherParent> createState() => _UploadHomeworkToTeacherParentState();
}

class _UploadHomeworkToTeacherParentState extends State<UploadHomeworkToTeacherParent> {
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
          .child("files/studymaterials/${widget.homeWorkName}/$uid2")
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
      // String uid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('HomeWorks')
          .doc(widget.homeworkID)
          // .collection('Chapters')
          // .doc(widget.chapterID)
          .collection('Submit')
          .doc(UserCredentialsController.parentModel!.studentID)
          .set({
        'Status': true,
        'homeWorkName': widget.homeWorkName,
        'homeworkID': widget.homeworkID,
        'downloadUrl': downloadUrl,
        'docid': UserCredentialsController.parentModel!.studentID,
        'uploadedBy': UserCredentialsController.parentModel!.parentName
      }).then((value) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Home Work'.tr),
                  content: Text('New Home Work Added!'.tr),
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

  final HomeWorkController homeWorkController = Get.put(HomeWorkController());
  //final _formKey = GlobalKey<FormState>();

  final GetImage getImageController = Get.put(GetImage());
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
          "Home Work".tr,
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
                  key: homeWorkController.formKey,
                  child: Column(
                    children: [
                      GoogleMonstserratWidgets(
                          text: 'Home Work upload'.tr,
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kWidth20,
                      GestureDetector(
                        onTap: () async {
                          _getCameraAndGallery(context);
                          // log(getImageController.pickedImage.value);
                          // setState(() {
                          //   filee = File(getImageController.pickedImage.value);
                          // });
                          // FilePickerResult? result = await FilePicker.platform
                          //     .pickFiles(
                          //         allowedExtensions: ['pdf'],
                          //         type: FileType.custom);

                          // if (result != null) {
                          //   File file = File(result.files.single.path!);
                          //   setState(() {
                          //     filee = file;
                          //   });
                          // }
                          // else {
                          //   print('No file selected');
                          // }
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
                              Icon(Icons.attach_file_rounded, color: cblue, size: 30.w, weight: 10),
                              SizedBox(
                                width: 300,
                                child: Center(
                                  child: Obx(() {
                                    filee = File(getImageController.pickedImage.value);
                                    return GoogleMonstserratWidgets(
                                      text: (getImageController.pickedImage.value == "")
                                          ? 'Upload image here'.tr
                                          : getImageController.pickedImage.value.split('/').last,
                                      fontsize: 22,
                                      color: cblue,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }),
                                ),
                              ),
                              kWidth20,
                            ],
                          ),
                        ),
                      ),
                      kWidth20,
                      kHeight20,
                      kHeight20,
                      kHeight40,
                      (widget.stat == true)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (homeWorkController.formKey.currentState!.validate()) {
                                  if (getImageController.pickedImage.value != '') {
                                    await pickAFile(filee);
                                    await uploadToFirebase().then((value) {
                                      topicController.clear();
                                      titleController.clear();
                                      filee = null;
                                      getImageController.pickedImage.value = '';
                                    });
                                  } else {
                                    showToast(msg: "Select a image");
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
                      // GestureDetector(
                      //   onTap: () async {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomeWorkShow(
                      //                   homeworkID: widget.homeworkID,
                      //                 //  chapterID: widget.chapterID,
                      //                 )));
                      //   },
                      //   child: ButtonContainerWidget(
                      //     curving: 18,
                      //     colorindex: 2,
                      //     height: 60.w,
                      //     width: 300.w,
                      //     child: Center(
                      //       child: Text(
                      //         "UPLOADED HOME WORK".tr,
                      //         style: GoogleFonts.montserrat(
                      //             color: Colors.white,
                      //             fontSize: 13,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ),
                      //   ),
                      // )
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

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomHomeworkPhotoUploadContainer(getImageController: getImageController);
        });
  }
}
