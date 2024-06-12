import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/helper/shared_pref_helper.dart';
import 'package:excel_karoor/model/teacher_model/teacher_model.dart';
import 'package:excel_karoor/view/pages/splash_screen/splash_screen.dart';

import '../../utils/utils.dart';

class TeacherLoginController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = "TeacherLoginController";
  final formKey = GlobalKey<FormState>();

  //sign in with email and password firebase authentification
  void signIn(BuildContext context) async {
    if (emailIdController.text.isEmpty || passwordController.text.isEmpty) {
      showToast(msg: "Fields are empty");
      return;
    }
    try {
      isLoading.value = true;
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailIdController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        final DocumentSnapshot<Map<String, dynamic>> result =
            await firebaseFirestore
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Teachers')
                .doc(value.user?.uid)
                .get();

        if (result.data() != null) {
          final TeacherModel teacherModel =
              TeacherModel.fromMap(result.data()!);

          if (teacherModel.userRole == "teacher" ||
              teacherModel.userRole == "classTeacher") {
            UserCredentialsController.teacherModel = teacherModel;
            //assigining shared preference user role for app close
            await SharedPreferencesHelper.setString(
                SharedPreferencesHelper.currenUserKey, value.user!.uid);
            await SharedPreferencesHelper.setString(
                    SharedPreferencesHelper.userRoleKey, 'teacher')
                .then((value) => Get.off(() => const SplashScreen()));
          } else {
            await firebaseAuth.signOut();
            showToast(msg: "You are not a Teacher");
          }
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });

      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Login Failed');
      log(name: name, e.toString());
      isLoading.value = false;
    }
  }
}
