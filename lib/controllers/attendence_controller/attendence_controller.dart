import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel_karoor/controllers/application_controller/application_controller.dart';
import 'package:excel_karoor/controllers/push_notification_controller/push_notification_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/attendence_model/attendence-model.dart';
import 'package:excel_karoor/model/student_attendence_model/student_attendece_model.dart';
import 'package:excel_karoor/model/student_model/student_model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/widgets/notification_color/notification_color_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final key = Get.put(ApplicationController());
  RxInt notificationTimer = 0.obs;
  List<AttendanceStudentModel> abStudentUIDList = [];
  List<StudentModel> abStsParentUIDList = [];
  RxString schoolName = ''.obs;
  RxString dateformated = ''.obs;
  RxString timeformated = ''.obs;
  final PushNotificationController pushNotificationController =
      Get.put(PushNotificationController());
  var progress = 0.0.obs;

  void updateProgress(double value) {
    progress.value = value;
  }

  dailyAttendanceController(String classID) async {
    final firebase = FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(classID)
        .collection('Attendence');
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final month = DateFormat('MMMM-yyyy');
    String monthwise = month.format(parseDate);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    ////////////////////////////
    ///
    for (var i = 1; i <= 15; i++) {
      final docid = uuid.v1();
      await firebase
          .doc(monthwise)
          .collection(monthwise)
          .doc(formatted)
          .collection("PeriodCollection")
          .doc(docid)
          .set({
        'docid': docid,
        'period': i,
      });
    }
  }

  Future<void> getSubjectStudentAttendenceList({
    required String studentDocid,
    required String subjectDocid,
    required String classID,
    required String studentName,
    required bool present,
    required String subjectName,
    required int periodNo,
  }) async {
    try {
      //  log("Loading.............+++++");
      final date = DateTime.now();

      final attendenceDetail = StudentAttendenceModel(
          docid: uuid.v1(),
          studentDocid: studentDocid,
          studentName: studentName,
          present: present,
          date: date,
          subjectName: subjectName,
          subjectID: subjectDocid,
          periodNo: periodNo);
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(classID)
          .collection('Students')
          .doc(studentDocid)
          .collection('MyAttendenceList')
          .doc(attendenceDetail.docid)
          .set(attendenceDetail.toMap());
      // log("Submmited.............+++++");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> sendPushMessage(String token, String body, String title) async {
    final serverKey = pushNotificationController.pushNotficationKey.value;
    final Uri url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/excel-karoor-48ae3/messages:send');

    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'android': {
          'notification': {
            'title': title,
            'body': body,
            'click_action': 'TOP_STORY_ACTIVITY'
          },
          'data': {'story_id': 'story_12345'}
        },
        'apns': {
          'payload': {
            'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
          },
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print('Failed to send notification: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception caught sending notification: $e');
    }
  }

  Future<void> getNotificationTimer() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('Notifications')
        .doc('Attendance')
        .get();
    notificationTimer.value =
        int.parse(vari.data()?['timeToDeliverAbsenceNotification']);
  }

  // Future<void> sendAbNotificationToParent(String subject) async {
  //   try {
  //     await Future.delayed(Duration(minutes: notificationTimer.value))
  //         .then((value) async {
  //       for (var i = 0; i < abStsParentUIDList.length; i++) {
  //         await server
  //             .collection('AllUsersDeviceID')
  //             .doc(abStsParentUIDList[i].parentId)
  //             .get()
  //             .then((usersDeviceIDvalue) async {
  //           await sendPushMessage(
  //               usersDeviceIDvalue.data()?['devideID'],
  //               'Sir/Madam, your child is absent on for $subject period at ${timeformated.value} on ${dateformated.value},\n സർ/മാഡം, ${dateformated.value} തീയതി ${timeformated.value} ഉണ്ടായിരുന്ന $subject പീരീഡിൽ നിങ്ങളുടെ കുട്ടി ഹാജരായിരുന്നില്ല',
  //               'Absent Notification from ${abStsParentUIDList[i].studentName}');
  //         });
  //       }
  //     });
  //     //  log("sendAbNotificationToParent Success....");
  //   } catch (e) {
  //     log(e.toString());
  //     //  log("sendAbNotificationToParent Failed****");
  //   }
  // }

  Future<void> getAbStsParentDeviceID() async {
    abStsParentUIDList.clear();
    try {
      for (var i = 0; i < abStudentUIDList.length; i++) {
        await server
            .collection('AllStudents')
            .doc(abStudentUIDList[i].uid)
            .get()
            .then((value) async {
          final StudentModel data = StudentModel(
              admissionNumber: value.data()?['admissionNumber'] ?? '',
              alPhoneNumber: value.data()?['alPhoneNumber'] ?? '',
              bloodgroup: value.data()?['bloodgroup'] ?? '',
              classId: value.data()?['classId'] ?? '',
              createDate: value.data()?['createDate'] ?? '',
              dateofBirth: value.data()?['dateofBirth'] ?? '',
              district: value.data()?['district'] ?? '',
              docid: value.data()?['docid'] ?? '',
              gender: value.data()?['gender'] ?? '',
              guardianId: value.data()?['guardianId'] ?? '',
              houseName: value.data()?['houseName'] ?? '',
              parentId: value.data()?['parentId'] ?? '',
              parentPhoneNumber: value.data()?['parentPhoneNumber'] ?? '',
              place: value.data()?['place'] ?? '',
              profileImageId: value.data()?['profileImageId'] ?? '',
              profileImageUrl: value.data()?['profileImageUrl'] ?? '',
              studentName: value.data()?['studentName'] ?? '',
              studentemail: value.data()?['studentemail'] ?? '',
              userRole: value.data()?['userRole'] ?? '');
          abStsParentUIDList.add(data);
        });
      }
      // print("Parent ID ${abStsParentUIDList.length}");
      // log("getAbStsParentDeviceID Success....");
    } catch (e) {
      //    log("getAbStsParentDeviceID Failed ***");
      log(e.toString());
    }
  }

  Future<void> getStudentAbsentList({
    required String periodID,
    required String subject,
    required String classID,
  }) async {
    abStudentUIDList.clear();
    try {
      final date = DateTime.now();
      DateTime parseDate = DateTime.parse(date.toString());
      final month = DateFormat('MMMM-yyyy');
      String monthwise = month.format(parseDate);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);
      await Future.delayed(const Duration(seconds: 10)).then((value) async {
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(classID)
            .collection('Attendence')
            .doc(monthwise)
            .collection(monthwise)
            .doc(formatted)
            .collection('Subjects')
            .doc(periodID)
            .collection('AttendenceList')
            .get()
            .then((attendecevalue) async {
          for (var i = 0; i < attendecevalue.docs.length; i++) {
            print(attendecevalue.docs[i].data()['studentName']);
            if (attendecevalue.docs[i].data()['present'] == false) {
              final AttendanceStudentModel data = AttendanceStudentModel(
                  Date: attendecevalue.docs[i].data()['Date'],
                  present: attendecevalue.docs[i].data()['present'],
                  studentName: attendecevalue.docs[i].data()['studentName'],
                  uid: attendecevalue.docs[i].data()['uid']);
              abStudentUIDList.add(data);
              print(attendecevalue.docs[i].data()['studentName']);
            }
          }
        });
      }).then((value) async {
        //  print('Student count${abStudentUIDList.length}');
        // log("getStudentAbsentList Success....");

        await getAbStsParentDeviceID().then((value) async {
          await markTakeAttendenceToCloud(
              classID: classID, subjectID: periodID,subjectName: subject);
          // await sendAbNotificationToParent(subject);/////////////////////////////////////////////////////////////////
          //////////////////////////////////////////
          ///////////////////////
          ////////////////////////////
        }).then((value) async {
          for (var i = 0; i < abStsParentUIDList.length; i++) {
            pushNotificationController.userNotification(
                parentID: abStsParentUIDList[i].parentId,
                icon: AlertNotifierSetup().icon,
                messageText:
                    '''Sir/Madam, your child was absent on for $subject period at ${timeformated.value} on ${dateformated.value}, സർ/മാഡം, ${dateformated.value} തീയതി ${timeformated.value} ഉണ്ടായിരുന്ന $subject പീരീഡിൽ നിങ്ങളുടെ കുട്ടി ഹാജരായിരുന്നില്ല',
                'Absent Notification from ${abStsParentUIDList[i].studentName}''',
                headerText: 'Absent on ${dateformated.value}',
                whiteshadeColor: AlertNotifierSetup().whiteshadeColor,
                containerColor: AlertNotifierSetup().containerColor);
          }
        });
      });
      // ).then((value) async => await getAbStsParentDeviceID().then(
      //         (value) async =>
      //             await sendAbNotificationToParent(studentName, subject)));
    } catch (e) {
      //  log("getStudentAbsentList Failed ***");

      log(e.toString());
    }
  }

  Future<void> activeClasses({
    required String classID,
    required String teacherDocid,
    required String subjectName,
    required String periodID,
    required String periodidNO,
    required String month,
  }) async {
    try {
      log('activeClasses.........................');
      final date = DateTime.now();
      DateTime parseDate = DateTime.parse(date.toString());

      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('TodayActiveClasses')
          .doc(formatted)
          .set({'docid': formatted}).then((value) async {
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TodayActiveClasses')
            .doc(formatted)
            .collection('Classes')
            .doc(classID)
            .set({
          'docid': classID,
          'teacherDocid': teacherDocid,
          'subjectName': subjectName,
          'periodID': periodID,
          'periodidNO': periodidNO,
        }).then((value) async {
          int totalStudent = 0;
          int absentStudents = 0;
          int presentStudents = 0;
          await server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(classID)
              .collection('Attendence')
              .doc(month)
              .collection(month)
              .doc(formatted)
              .collection('Subjects')
              .doc(periodID)
              .collection('AttendenceList')
              .get()
              .then((value) async {
            totalStudent = value.docs.length;
            for (var i = 0; i < value.docs.length; i++) {
              if (value.docs[i].data()['present'] == true) {
                presentStudents = presentStudents + 1;
              } else {
                absentStudents = absentStudents + 1;
              }
            }
            await server
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('TodayActiveClasses')
                .doc(formatted)
                .collection('Classes')
                .doc(classID)
                .set({
              'totalStudent': totalStudent,
              'absentStudents': absentStudents,
              'presentStudents': presentStudents
            }, SetOptions(merge: true));
          });
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<int> markTakeAttendenceToCloud(
      {required String classID, required String subjectID,required String subjectName}) async {
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final month = DateFormat('MMMM-yyyy');
    String monthwise = month.format(parseDate);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    int result = 0;
    FirebaseFirestore.instance
        .collection("ClassAttendenceNotifer")
        .doc(UserCredentialsController.schoolId)
        .get()
        .then((value) async {
      value.data()!['classCount'] = result;
      result = result + 1;
    }).then((classDetail) async {
      await FirebaseFirestore.instance
          .collection("ClassAttendenceNotifer")
          .doc(UserCredentialsController.schoolId)
          .collection('ClassCollections')
          .doc(classID)
          .set({
        'docid': classID,
        'attendenceTakenTime': DateTime.now().toString(),
        'exdateTime': DateTime.now()
            .add(Duration(minutes: notificationTimer.value))
            .toString(),
        'month': monthwise,
        'date': formatted,
        'subjectID': subjectID,
        "subjectName":subjectName,
      }, SetOptions(merge: true));
    });
    return result;
  }

  @override
  void onInit() async {
    await getNotificationTimer();

    super.onInit();
  }
}
