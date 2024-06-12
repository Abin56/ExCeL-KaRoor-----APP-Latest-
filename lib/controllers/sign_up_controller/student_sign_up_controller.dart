import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/sign_in_controller/student_sign_in_controller.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/pages/login/sign_up/student_sign_up/student_sign_up.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../model/student_model/student_model.dart';
import '../userCredentials/user_credentials.dart';

class StudentSignUpController extends GetxController {
  Rx<ButtonState> buttonstate = ButtonState.idle.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController studentPassController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = RxBool(false);
  List<StudentModel> classWiseStudentList = [];

  String? bloodGroup;
  String? gender;

  //for photo id creation
  Uuid uuid = const Uuid();
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");

//fetching all students data from firebase

  //updating students data

  Future<void> updateStudentData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        isLoading.value = true;
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref(
                "files/studentsProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.studentModel?.studentName}$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
        // getting firebase uid and updated it to collection
        String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";

        final studentModel = StudentModel(
            password: passwordController.text,
            admissionNumber: "",
            alPhoneNumber: altPhoneNoController.text,
            bloodgroup: bloodGroup ?? "",
            classId: UserCredentialsController.studentModel?.classId ?? "",
            createDate: DateTime.now().toString(),
            dateofBirth: dateOfBirthController.text,
            district: districtController.text,
            docid: userUid,
            gender: gender ?? "",
            guardianId:
                UserCredentialsController.studentModel?.guardianId ?? "",
            houseName: houseNameController.text.trim(),
            parentId: UserCredentialsController.studentModel?.parentId ?? "",
            parentPhoneNumber:
                UserCredentialsController.studentModel?.parentPhoneNumber ?? "",
            place: placeController.text.trim(),
            profileImageId: imageId,
            profileImageUrl: imageUrl,
            studentName:
                UserCredentialsController.studentModel?.studentName ?? "",
            studentemail: emailController.text.trim(),
            userRole: "student");

        await getAdmissionNumber().then((value) async {
          await increaseAdNo().then((value) async {
            studentModel.admissionNumber = '000${stAdNumber.value}';
            await FirebaseFirestore.instance
                .collection("SchoolListCollection")
                .doc(UserCredentialsController.schoolId)
                .collection('AllStudents')
                .doc(userUid)
                .set(studentModel.toMap())
                .then((value) async {
              await firebaseData
                  .doc(userUid)
                  .set(studentModel.toMap())
                  .then((value) async {
                log("SchoolID ${UserCredentialsController.schoolId}");
                log("batchId ${UserCredentialsController.batchId ?? ""}");
                log("classId ${UserCredentialsController.classId}");
                log("Temp Student ID ${Get.find<StudentSignInController>().tempstudentDocID.value}");
                await FirebaseFirestore.instance
                    .collection("SchoolListCollection")
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId ?? "")
                    .doc(UserCredentialsController.batchId ?? "")
                    .collection("classes")
                    .doc(UserCredentialsController.classId)
                    .collection("Temp_Students")
                    .doc(Get.find<StudentSignInController>()
                        .tempstudentDocID
                        .value)
                    .delete();
              });
            });
          });
        });

        clearFields();
        Get.find<GetImage>().pickedImage.value = "";
        isLoading.value = false;
      } else {
        showToast(msg: "Please Upload Profile Picture");
      }
    } catch (e) {
      showToast(msg: "Updation Failed");
      isLoading.value = false;
    }
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    houseNameController.clear();
    houseNumberController.clear();
    placeController.clear();
    districtController.clear();
    altPhoneNoController.clear();
    dateOfBirthController.clear();
    bloodGroup = null;
  }

  bool checkAllFieldIsEmpty() {
    if (houseNameController.text.isEmpty ||
        houseNumberController.text.isEmpty ||
        placeController.text.isEmpty ||
        districtController.text.isEmpty ||
        altPhoneNoController.text.isEmpty ||
        dateOfBirthController.text.isEmpty ||
        bloodGroup == null) {
      return true;
    } else {
      return false;
    }
  }

  RxInt stAdNumber = 0000.obs; // Student Admission Number
  RxString stUID = ''.obs; // Student Email Auth ID
  Future<int> getAdmissionNumber() async {
    final result = await server.collection('AdmissionNumber').doc('AdNo').get();

    if (result.data() == null) {
      await FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId ?? "")
          .collection('AdmissionNumber')
          .doc('AdNo')
          .set({'AdNumber': stAdNumber.value});
    } else {
      stAdNumber.value = result.data()?['AdNumber'] ?? 0;
    }

    return stAdNumber.value;
  }

  Future<String> increaseAdNo() async {
    final int newAdNo = stAdNumber.value + 1;

    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId ?? "")
        .collection('AdmissionNumber')
        .doc('AdNo')
        .update({'AdNumber': newAdNo});

    return '000$newAdNo';
  }

  @override
  void onReady() async {
    await getAdmissionNumber();
    super.onReady();
  }

  Future<void> checkStudentProfilePAss() async {
    buttonstate.value = ButtonState.loading;
    try {
      await server
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId ?? "")
          .collection("classes")
          .doc(UserCredentialsController.classId)
          .collection("Temp_Students")
          .doc(UserCredentialsController.studentModel?.docid ?? "")
          .get()
          .then((value) async {
        if (value.data()?['password'] == studentPassController.text.trim()) {
          studentPassController.clear();
          StudentPasswordSaver.studentEmailID = emailController.text.trim();
          StudentPasswordSaver.studentPassword = passwordController.text.trim();
          buttonstate.value = ButtonState.success;
          await Future.delayed(const Duration(seconds: 2)).then((value) {
            buttonstate.value = ButtonState.idle;
          }).then((value) => Get.offAll(() => StudentSignInPageScreen()));
        } else {
          buttonstate.value = ButtonState.fail;
          await Future.delayed(const Duration(seconds: 2)).then((value) {
            buttonstate.value = ButtonState.idle;
          });
          return showToast(msg: "Wrong Password");
        }
      });
    } catch (e) {
      log(e.toString());
      buttonstate.value = ButtonState.fail;
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        buttonstate.value = ButtonState.idle;
      });
    }
  }
}
