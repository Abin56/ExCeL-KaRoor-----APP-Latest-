import 'dart:async';
import 'dart:developer';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/application_controller/application_controller.dart';
import 'package:excel_karoor/controllers/chatgpt_Controller/chatgpt_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/model/parent_model/parent_model.dart';
import 'package:excel_karoor/model/student_model/student_model.dart';
import 'package:excel_karoor/model/teacher_model/teacher_model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/home/class_teacher_HOme/class_teacher_mainhome.dart';
import 'package:excel_karoor/view/home/parent_home/parent_main_home_screen.dart';
import 'package:excel_karoor/view/home/student_home/students_main_home.dart';
import 'package:excel_karoor/view/home/teachers_home/teacher_main_home.dart';
import 'package:excel_karoor/view/pages/login/dujo_login_screen.dart';

import '../../../helper/shared_pref_helper.dart';
import '../../../model/guardian_model/guardian_model.dart';
import '../../home/guardian_home/guardian_main_home.dart';
import '../../widgets/fonts/google_monstre.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ChatGPTController chatGPTController = Get.put(ChatGPTController());

  final ApplicationController applicationController =
      Get.put(ApplicationController());

  @override
  void initState() {
    super.initState();
    applicationController
        .getLatestApplicationVersion()
        .then((value) => applicationController.checkingLatestVersion(context));
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 1,
              duration:  const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration:  const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Container(
                    height: 220.h,
                    width: 220.w,
                    decoration:  const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        officialLogo,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimationConfiguration.staggeredGrid(
              position: 2,
              duration:  const Duration(milliseconds: 4000),
              columnCount: 3,
              child: ScaleAnimation(
                duration:  const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleMonstserratWidgets(
                        text: companyName,
                        fontsize: 25,
                        color:  const Color.fromARGB(255, 230, 18, 3),
                        fontWeight: FontWeight.bold,
                      ),
                      GoogleMonstserratWidgets(
                        text: nameInSmall,
                        fontsize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     GoogleMonstserratWidgets(
          //       text: 'COSTECH',
          //       fontsize: 27.sp,
          //       color:  Color.fromARGB(255, 201, 14, 1),
          //       fontWeight: FontWeight.bold,
          //     ),
          //     Text(
          //       " DuJo",

          //       style: DGoogleFonts.headTextStyleMont,
          //     ),
          //   ],
          // ),  SizedBox(height: 10,),
        ],
      )),
    );
  }
}

nextpage(context) async {
  //creating firebase auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //assigning shared preference value to to UserCredentialController
  UserCredentialsController.schoolId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.schoolIdKey);
  UserCredentialsController.batchId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.batchIdKey);
  UserCredentialsController.classId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.classIdKey);
  UserCredentialsController.userRole =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.userRoleKey);
  UserCredentialsController.currentUSerID =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.currenUserKey);

  await Future.delayed( const Duration(seconds: 6));
  log("schoolId:${UserCredentialsController.schoolId}");
  log("batchId:${UserCredentialsController.batchId}");
  log("classId:${UserCredentialsController.classId}");
  log("userRole:${UserCredentialsController.userRole}");
  log('currentUSerID Auth ${UserCredentialsController.currentUSerID}');

  if (auth.currentUser == null) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return  const DujoLoginScren();
      },
    ));
    // Get.offAll(() =>  const DujoLoginScren());
  } else {
    final DocumentReference<Map<String, dynamic>> firebaseFirestore =
        FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId);
    if (UserCredentialsController.userRole == 'student') {
      //getting studentData
      await checkStudent(
        context,
        firebaseFirestore,
        auth,
      );
    } else if (UserCredentialsController.userRole == 'teacher') {
      //checking user is classTeacher
      await checkTeacher(context, firebaseFirestore, auth);
    } else if (UserCredentialsController.userRole == 'classTeacher') {
      //checking user is parent
      await checkClassTeacher(firebaseFirestore, auth);
    } else if (UserCredentialsController.userRole == 'parent') {
      await checkParent(context, firebaseFirestore, auth);

      //checking user is guardian
    } else if (UserCredentialsController.userRole == 'guardian') {
      await checkGuardian(firebaseFirestore, auth);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return  const DujoLoginScren();
        },
      ));
      //Get.offAll(() =>  const DujoLoginScren());
    }
  }
}

Future<void> checkStudent(
    context,
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final studentData = await firebaseFirestore
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('Students')
      .doc(auth.currentUser?.uid)
      .get();

  if (studentData.data() != null) {
    UserCredentialsController.studentModel =
        StudentModel.fromMap(studentData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  const StudentsMainHomeScreen();
      },
    ));
    // Get.off(() =>  StudentsMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  const DujoLoginScren();
      },
    ));
    // Get.off(() =>  const DujoLoginScren());
  }
}

Future<void> checkTeacher(
    context,
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final teacherData = await firebaseFirestore
      .collection('Teachers')
      .doc(auth.currentUser?.uid)
      .get();

  if (teacherData.data() != null) {
    UserCredentialsController.teacherModel =
        TeacherModel.fromMap(teacherData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  const TeacherMainHomeScreen();
      },
    ));
    // Get.off(() =>  TeacherMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  const DujoLoginScren();
      },
    ));
    //Get.off(() =>  const DujoLoginScren());
  }
}

Future<void> checkClassTeacher(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final classTeacherData = await firebaseFirestore
      .collection('Teachers')
      .doc(auth.currentUser?.uid)
      .get();

  if (classTeacherData.data() != null) {
    UserCredentialsController.teacherModel =
        TeacherModel.fromMap(classTeacherData.data()!);
    Get.off(() =>  const ClassTeacherMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.off(() =>  const DujoLoginScren());
  }
}

Future<void> checkParent(
    context,
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final DocumentSnapshot<Map<String, dynamic>> parentData =
      await firebaseFirestore
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('Parents')
          .doc(auth.currentUser?.uid)
          .get();

  if (parentData.data() != null) {
    UserCredentialsController.parentModel =
        ParentModel.fromMap(parentData.data()!);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return   ParentMainHomeScreen();
      },
    ));
    // Get.off(() =>  ParentMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return  const DujoLoginScren();
      },
    ));
    // Get.off(() =>  const DujoLoginScren());
  }
}

Future<void> checkGuardian(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final DocumentSnapshot<Map<String, dynamic>> guardianData =
      await firebaseFirestore
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('GuardianCollection')
          .doc(auth.currentUser?.uid)
          .get();

  if (guardianData.data() != null) {
    UserCredentialsController.guardianModel =
        GuardianModel.fromMap(guardianData.data()!);
    Get.off(() =>  const GuardianMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.off(() =>  const DujoLoginScren());
  }
}

Future<bool> onbackbuttonpressed(BuildContext context) async {
  bool exitApp = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  const Text('Alert'),
        content:  const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to exit from Lepton VidyaVeechi ?')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child:  const Text('Yes'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
  return exitApp;
}
