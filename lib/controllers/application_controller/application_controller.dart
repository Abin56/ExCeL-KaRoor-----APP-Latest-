import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/parent_model/parent_model.dart';
import 'package:excel_karoor/model/student_model/student_model.dart';
import 'package:excel_karoor/model/teacher_model/teacher_model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/parent_edit_profile_full.dart';
import 'package:excel_karoor/view/home/student_home/Student%20Edit%20Profile/student_edit_profile_page.dart';
import 'package:excel_karoor/view/home/student_home/Student%20Edit%20Profile/teacher_edit_profile.dart';
import 'package:excel_karoor/view/pages/splash_screen/splash_screen.dart';
import 'package:excel_karoor/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationController extends GetxController {
  RxString currentversion = '1.0.0+14'.obs;
  RxString latestVersion = ''.obs;
  RxString playstorelink = ''.obs;
  RxString message = ''.obs;

  Future<void> getLatestApplicationVersion() async {
    final firebaseplaystorelink = await FirebaseFirestore.instance
        .collection('Application_version')
        .doc('playstorelink')
        .get();
    final firebaseplaystoremessage = await FirebaseFirestore.instance
        .collection('Application_version')
        .doc('playstorelink')
        .get();
    final firebase = await FirebaseFirestore.instance
        .collection('Application_version')
        .doc('version')
        .get();
    message.value = firebaseplaystoremessage.data()!['message'];
    playstorelink.value = firebaseplaystorelink.data()!['link'];
    latestVersion.value = firebase.data()!['version'];
  }

  Future<String> getpushNotificationKey() async {
    String key = '';
    await FirebaseFirestore.instance
        .collection('Pushnotificationkey')
        .doc('key')
        .get()
        .then((keyvalue) async {
      key = keyvalue.data()?['key'];
    });
    return key;
  }

  checkingLatestVersion(BuildContext context) async {
    if (currentversion.value == latestVersion.value) {
      nextpage(context);
      log("...................................");
    } else {
      log('+++++++++++++++++++++++++++++++++');
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message.value)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () async {
                  await openPlayStore();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> openPlayStore() async {
    String playStoreUrl = playstorelink.value;

    if (await canLaunch(playStoreUrl)) {
      await launch(playStoreUrl);
    } else {
      throw 'Could not launch Play Store';
    }
  }

  Future<void> checkStudentProfile(BuildContext context) async {
    List<String> studentProfileList = [];
    studentProfileList.clear();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await server
          .collection('AllStudents')
          .doc(UserCredentialsController.studentModel?.docid)
          .get()
          .then((value) {
        final studentData = StudentModel.fromMap(value.data()!);
        if (studentData.studentName == '') {
          studentProfileList.add('Name');
        }
        if (studentData.profileImageUrl == '') {
          studentProfileList.add('Profile picture');
        }

        if (studentData.alPhoneNumber == '') {
          studentProfileList.add('Alternative Phone Number');
        }
        if (studentData.bloodgroup == '') {
          studentProfileList.add('Blood Group');
        }
        if (studentData.dateofBirth == '') {
          studentProfileList.add('Date of Birth');
        }
        if (studentData.district == '') {
          studentProfileList.add('District');
        }
        if (studentData.gender == '') {
          studentProfileList.add('Gender');
        }
        if (studentData.houseName == '') {
          studentProfileList.add('House Address');
        }
        if (studentData.parentPhoneNumber == '') {
          studentProfileList.add('Parent Phone Number');
        }
        if (studentData.place == '') {
          studentProfileList.add('Your Place');
        }
        if (studentProfileList.isNotEmpty) {
          log("profile is not completed");
          customShowDilogBox(
              context: context,
              doyouwantCancelButton: false,
              title: "Profile",
              actiononTapfuction: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentProfileEditPage(),
                    ));
              },
              children: [
                const Text(
                  "Please Update profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: studentProfileList.length * 30,
                  width: 200,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Text(studentProfileList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: studentProfileList.length),
                )
              ],
              doyouwantActionButton: true);
        } else {
          log("profile completed");
        }
      });
    });
  }

  Future<void> checkParentProfile(BuildContext context) async {
    List<String> parentProfileList = [];
    parentProfileList.clear();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await server
          .collection('AllParents')
          .doc(UserCredentialsController.parentModel?.docid)
          .get()
          .then((value) {
        final parentData = ParentModel.fromMap(value.data()!);
        if (parentData.profileImageURL == '') {
          parentProfileList.add('Profile picture');
        }
        if (parentData.parentName == '') {
          parentProfileList.add('Name');
        }

        if (parentData.district == '') {
          parentProfileList.add('District');
        }
        if (parentData.gender == '') {
          parentProfileList.add('Gender');
        }
        if (parentData.houseName == '') {
          parentProfileList.add('House Address');
        }
        if (parentData.parentPhoneNumber == '') {
          parentProfileList.add(' Phone Number');
        }
        if (parentData.place == '') {
          parentProfileList.add('Your Place');
        }
        if (parentData.state == '') {
          parentProfileList.add('Your state');
        }
        if (parentData.pincode == '') {
          parentProfileList.add('Your Pincode');
        }
        if (parentProfileList.isNotEmpty) {
          log("profile is not completed");

          customShowDilogBox(
              context: context,
              doyouwantCancelButton: false,
              title: "Profile",
              actiononTapfuction: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParentEditProfileScreenFull(),
                    ));
              },
              children: [
                const Text(
                  "Please Update profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: parentProfileList.length * 30,
                  width: 200,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Text(parentProfileList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: parentProfileList.length),
                )
              ],
              doyouwantActionButton: true);
        } else {
          log("profile completed");
        }
      });
    });
  }

  Future<void> checkTeacherProfile(BuildContext context) async {
    List<String> teacherProfileList = [];
    teacherProfileList.clear();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await server
          .collection('Teachers')
          .doc(UserCredentialsController.teacherModel?.docid)
          .get()
          .then((value) {
        final teacherData = TeacherModel.fromMap(value.data()!);
        if (teacherData.imageUrl == '') {
          teacherProfileList.add('Profile picture');
        }
        if (teacherData.teacherName == '') {
          teacherProfileList.add('Name');
        }

        if (teacherData.district == '') {
          teacherProfileList.add('District');
        }
        if (teacherData.gender == '') {
          teacherProfileList.add('Gender');
        }
        if (teacherData.houseName == '') {
          teacherProfileList.add('House Address');
        }
        if (teacherData.teacherPhNo == '') {
          teacherProfileList.add(' Phone Number');
        }
        if (teacherData.place == '') {
          teacherProfileList.add('Your Place');
        }

        if (teacherProfileList.isNotEmpty) {
          log("profile is not completed");
          customShowDilogBox(
              context: context,
              doyouwantCancelButton: false,
              title: "Profile",
              actiononTapfuction: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherEditProfileScreen(),
                    ));
              },
              children: [
                const Text(
                  "Please Update profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: teacherProfileList.length * 30,
                  width: 200,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Text(teacherProfileList[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: teacherProfileList.length),
                )
              ],
              doyouwantActionButton: true);
        } else {
          log("profile completed");
        }
      });
    });
  }
}
