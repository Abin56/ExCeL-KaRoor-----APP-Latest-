import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/notification_model/notification_model.dart';
import 'package:excel_karoor/model/user_deviceID_model/user_devideID_model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationController extends GetxController {
  RxString deviceID = ''.obs;
  Future<void> getUserDeviceID() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceID.value = token ?? "";
      log("Device ID $token");
    });
  }

  Future<void> allUSerDeviceID(String userrole, String currentUSer) async {
    log('>currentUID>>>>$currentUSer');
    log('>>>>>User Role ${UserCredentialsController.userRole}');
    print('allUSerDeviceID');
    print('allUSerDeviceID  $currentUSer');
    try {
      final UserDeviceIDModel userModel = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: currentUSer,
          userrole: userrole,
          schoolID: UserCredentialsController.schoolId!);
      print(userModel);
      await server
          .collection('AllUsersDeviceID')
          .doc(currentUSer)
          .set(userModel.toMap(), SetOptions(merge: true))
          .then((value) async {
        await server
            .collection('AllUsersDeviceID')
            .doc(currentUSer)
            .update({"devideID": deviceID.value});
      });
      print('allUSerDeviceID**** FINISHED');
    } catch (e) {
      log(e.toString());
    }
  }

  /////////////////////////////////// Teacher Part

  Future<void> allTeacherDeviceID(String currentUSer) async {
    final String teacherUID =
        UserCredentialsController.teacherModel!.docid ?? currentUSer;
    try {
      final UserDeviceIDModel teacherModel = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: teacherUID,
          userrole: 'teacher',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection('AllTeacherDeviceID')
          .doc(teacherUID)
          .set(teacherModel.toMap())
          .then((value) async {
        await teacherDeviceID(currentUSer);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> teacherDeviceID(String currentUSer) async {
    final String teacherUID =
        UserCredentialsController.teacherModel!.docid ?? currentUSer;
    try {
      final UserDeviceIDModel student = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: teacherUID,
          userrole: 'teacher',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId!)
          .collection('teachers')
          .doc(teacherUID)
          .collection('DevideID')
          .doc('DevideID')
          .set(student.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  /////////////////////////////////// Teacher Part
  ///

  /////////////////////////////////// Student Part

  Future<void> allStudentDeviceID() async {
    final String studentUID = UserCredentialsController.studentModel!.docid;

    try {
      final UserDeviceIDModel studentModel = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: studentUID,
          userrole: 'studnet',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection('AllStudentDeviceID')
          .doc(studentUID)
          .set(studentModel.toMap())
          .then((value) async {
        await studentDeviceID();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> studentDeviceID() async {
    final String studentUID = UserCredentialsController.studentModel!.docid;
    try {
      final UserDeviceIDModel student = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: studentUID,
          userrole: 'student',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId!)
          .collection('Students')
          .doc(studentUID)
          .collection('DevideID')
          .doc('DevideID')
          .set(student.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  /////////////////////////////////// Student Part
  ///
  ///
  /////////////////////////////////// Parent Part

  Future<void> allParentDeviceID(String currentUSer) async {
    log('Parent DE:ID +++++++ $deviceID ++++++');
    final String parentUID =
        UserCredentialsController.parentModel!.docid ?? currentUSer;

    try {
      final UserDeviceIDModel parentmodel = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: parentUID,
          userrole: 'parent',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection('AllParentDeviceID')
          .doc(parentUID)
          .set(parentmodel.toMap())
          .then((value) async {
        await parentDeviceID(currentUSer);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> parentDeviceID(String currentUSer) async {
    final String parentUID =
        UserCredentialsController.parentModel!.docid ?? currentUSer;
    try {
      final UserDeviceIDModel parentmodel = UserDeviceIDModel(
          message: false,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          devideID: deviceID.value,
          uid: parentUID,
          userrole: 'parent',
          schoolID: UserCredentialsController.schoolId!);
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId!)
          .collection('Parents')
          .doc(parentUID)
          .collection('DevideID')
          .doc('DevideID')
          .set(parentmodel.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  updateOpenMessageStatus() async {
    await server
        .collection('AllUsersDeviceID')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        //  .collection("Notification_Message")
        // .doc(uid)
        .update({'message': false});
  }
  /////////////////////////////////// Parent Part

  Future<void> removeSingleNotification(String docid) async {
    await server
        .collection("AllUsersDeviceID")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Notification_Message')
        .doc(docid)
        .delete()
        .then((value) => Get.back());
  }

  Future<void> removeAllNotification() async {
    await server
        .collection("AllUsersDeviceID")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Notification_Message")
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        await server
            .collection("AllUsersDeviceID")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("Notification_Message")
            .doc(value.docs[i].data()['docid'])
            .delete();
      }
      Get.back();
    });
  }

  Future<void> userNotification({
    required String parentID,
    required IconData icon,
    required String messageText,
    required String headerText,
    required Color whiteshadeColor,
    required Color containerColor,
  }) async {
    final String docid = uuid.v1();
    try {
      log('Calling user notification');
      final details = NotificationModel(
          icon: icon,
          messageText: messageText,
          headerText: headerText,
          whiteshadeColor: whiteshadeColor,
          containerColor: containerColor,
          open: false,
          docid: docid,
          dateTime: DateTime.now().toString());
      await server
          .collection("AllUsersDeviceID")
          .doc(parentID)
          .collection("Notification_Message")
          .doc(docid)
          .set(details.toMap());
    } catch (e) {}
  }

  RxString pushNotficationKey = ''.obs;
  getPushNotification() async {
    FirebaseFirestore.instance
        .collection('PushNotification')
        .doc('key')
        .get()
        .then((value) async {
      pushNotficationKey.value = value.data()?['key'];
    });
  }

  @override
  void onInit() {
    getPushNotification();
    super.onInit();
  }
}
