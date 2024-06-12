import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/student_model/student_model.dart';
import 'package:excel_karoor/view/pages/login/dujo_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginCheckController extends GetxController {
  String? schoolIDVal;
  String? batchIDVal;
  String? classIDVal;

  void nextpage(context) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    schoolIDVal = p.getString('schoolID');
    batchIDVal = p.getString('batchID');
    classIDVal = p.getString('classID');
    log('schoolID $schoolIDVal');
    log('batchID: $batchIDVal');
    log('classID: $classIDVal');

    FirebaseAuth auth = FirebaseAuth.instance;

    User? currentUser = auth.currentUser;
    if (currentUser == null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const DujoLoginScren();
        },
      ));
      // Get.off(() => const DujoLoginScren());
    } else {
      log('UID: ${currentUser.uid}');

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("SchoolListCollection")
              .doc(schoolIDVal ?? '')
              .collection(batchIDVal!)
              .doc(batchIDVal)
              .collection("Classes")
              .doc(classIDVal ?? '')
              .collection("Students")
              .where('uid', isEqualTo: currentUser.uid)
              .get();
      print(querySnapshot.docs.length);
      if (querySnapshot.docs.length == 1) {
        UserCredentialsController.studentModel =
            StudentModel.fromMap(querySnapshot.docs[0].data());
        log('student!!');
        // Get.off(StudentLoginScreen());
      } else {
        log('not a student!!');

        // Get.off(const DujoLoginScren());
      }
    }
  }
}
