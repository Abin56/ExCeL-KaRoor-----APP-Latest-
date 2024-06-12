import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/teacher_model/teacher_model.dart';
import 'package:excel_karoor/view/pages/splash_screen/splash_screen.dart';

import '../../helper/shared_pref_helper.dart';
import '../../utils/utils.dart';

class ClassTeacherLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = "ClassTeacherLoginController";
  //sign in with email and password firebase authentification
  void signIn(BuildContext context) async {
    if (emailIdController.text.isEmpty || passwordController.text.isEmpty) {
      showToast(msg: "Fields are empty");
      return;
    }
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
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

          if (teacherModel.userRole == "classTeacher") {
              await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.currenUserKey, value.user!.uid);
            UserCredentialsController.teacherModel = teacherModel;

            await SharedPreferencesHelper.setString(
                SharedPreferencesHelper.userRoleKey, 'classTeacher').then((value) => Get.off(()=>const SplashScreen()));

          } else {
            showToast(msg: "You are not a class Teacher");
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
