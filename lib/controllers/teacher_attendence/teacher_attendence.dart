import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';

class TeacherAttendenceController extends GetxController {
  RxInt classWiseWoringDayCount = 0.obs;
  RxInt teacherAttendCount = 0.obs;
  Future<void> addTeacherAttendence(
      String classID, String className, String period) async {
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final month = DateFormat('MMMM-yyyy');
    String monthwise = month.format(parseDate);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    final String docid = uuid.v1();
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('TeacherAttendence')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.data() == null) {
        teacherAttendCount.value = 1;
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'docid': FirebaseAuth.instance.currentUser!.uid,
          'CountClassAttended': teacherAttendCount.value,
          'teacherPhNo': UserCredentialsController.teacherModel!.teacherPhNo,
          'teacherEmail': FirebaseAuth.instance.currentUser!.email.toString(),
          'employeeID': UserCredentialsController.teacherModel!.employeeID,
          'teacherdocid': FirebaseAuth.instance.currentUser!.uid,
          'teacherName': UserCredentialsController.teacherModel!.teacherName,
          // 'total'
        }, SetOptions(merge: true)).then((value) async {
          await server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('TeacherAttendence')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('DayWiseAttendence')
              .doc(formatted)
              .set({
            'docid': formatted,
            'date': formatted,
            'teacherdocid': FirebaseAuth.instance.currentUser!.uid,
            'teacherName': UserCredentialsController.teacherModel!.teacherName,
          }, SetOptions(merge: true)).then((value) async {
            await server
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('TeacherAttendence')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('DayWiseAttendence')
                .doc(formatted)
                .collection('AttendedClasses')
                .doc(docid)
                .set({
              'docid': docid,
              'ClassName': className,
              'CountClassAttended': teacherAttendCount.value,
              'period': period,
              'datetime': DateTime.now().toString(),
            }, SetOptions(merge: true)).then((value) async {
              await server
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId)
                  .collection('TeacherAttendence')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('MonthWiseAttendence')
                  .doc(monthwise)
                  .set({
                'docid': monthwise,
                'month': monthwise,
              }, SetOptions(merge: true)).then((value) async {
                await server
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection('TeacherAttendence')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('MonthWiseAttendence')
                    .doc(monthwise)
                    .collection(monthwise)
                    .doc(formatted)
                    .set({
                  'docid': formatted,
                }, SetOptions(merge: true)).then((value) async {
                  await server
                      .collection(UserCredentialsController.batchId!)
                      .doc(UserCredentialsController.batchId)
                      .collection('TeacherAttendence')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('MonthWiseAttendence')
                      .doc(monthwise)
                      .collection(monthwise)
                      .doc(formatted)
                      .collection('AttendedClasses')
                      .doc(docid)
                      .set({
                    'docid': docid,
                    'ClassName': className,
                    'CountClassAttended': teacherAttendCount.value,
                    'period': period,
                    'datetime': DateTime.now().toString(),
                  }, SetOptions(merge: true));
                });
              });
            });
          });
        });
      } else {
        teacherAttendCount.value = value.data()?['CountClassAttended'] + 1;
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'docid': FirebaseAuth.instance.currentUser!.uid,
          'CountClassAttended': teacherAttendCount.value,
          'teacherPhNo': UserCredentialsController.teacherModel!.teacherPhNo,
          'teacherEmail': FirebaseAuth.instance.currentUser!.email.toString(),
          'employeeID': UserCredentialsController.teacherModel!.employeeID,
          'teacherdocid': FirebaseAuth.instance.currentUser!.uid,
          'teacherName': UserCredentialsController.teacherModel!.teacherName,
          // 'total'
        }, SetOptions(merge: true)).then((value) async {
          await server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('TeacherAttendence')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('DayWiseAttendence')
              .doc(formatted)
              .set({
            'docid': formatted,
            'date': formatted,
            'teacherdocid': FirebaseAuth.instance.currentUser!.uid,
            'teacherName': UserCredentialsController.teacherModel!.teacherName,
          }, SetOptions(merge: true)).then((value) async {
            await server
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('TeacherAttendence')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('DayWiseAttendence')
                .doc(formatted)
                .collection('AttendedClasses')
                .doc(docid)
                .set({
              'docid': docid,
              'ClassName': className,
              'CountClassAttended': teacherAttendCount.value,
              'period': period,
              'datetime': DateTime.now().toString(),
            }, SetOptions(merge: true)).then((value) async {
              await server
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId)
                  .collection('TeacherAttendence')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('MonthWiseAttendence')
                  .doc(monthwise)
                  .set({
                'docid': monthwise,
                'month': monthwise,
              }, SetOptions(merge: true)).then((value) async {
                await server
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection('TeacherAttendence')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('MonthWiseAttendence')
                    .doc(monthwise)
                    .collection(monthwise)
                    .doc(formatted)
                    .set({
                  'docid': formatted,
                }, SetOptions(merge: true)).then((value) async {
                  await server
                      .collection(UserCredentialsController.batchId!)
                      .doc(UserCredentialsController.batchId)
                      .collection('TeacherAttendence')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('MonthWiseAttendence')
                      .doc(monthwise)
                      .collection(monthwise)
                      .doc(formatted)
                      .collection('AttendedClasses')
                      .doc(docid)
                      .set({
                    'docid': docid,
                    'ClassName': className,
                    'CountClassAttended': teacherAttendCount.value,
                    'period': period,
                    'datetime': DateTime.now().toString(),
                  }, SetOptions(merge: true));
                });
              });
            });
          });
        });
      }
    });
  }

  Future<void> workingDaysMark(String classID) async {
    // While taking attendece getting count for Working days
    final todaydate = stringTimeToDateConvert(DateTime.now().toString());
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(classID)
        .get()
        .then((value) async {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(classID)
          .get()
          .then((value) async {
        if (value.data()?['lastActiveClassDay'] != todaydate) {
          classWiseWoringDayCount.value = value.data()!['workingDaysCount'];
          await server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(classID)
              .set({'workingDaysCount': classWiseWoringDayCount.value + 1,'lastActiveClassDay': todaydate},
                  SetOptions(merge: true)).then((value) async {
            classWiseWoringDayCount.value = 0;
          });
        }
      });
    });
  }

  Future<void> studentstatusTeacherDayWise(
      {required String classID,
      required String month,
      required String date,
      required String subjectID}) async {
    int totalStudentCount = 0;
    int absentStudent = 0;
    int presentStudent = 0;
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('TeacherAttendence')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('DayWiseAttendence')
        .doc(date)
        .get()
        .then((value) async {
      if (value.data()!.containsKey('totalStudentCount')) {
      } else {
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('DayWiseAttendence')
            .doc(date)
            .set({
          'totalStudentCount': totalStudentCount,
          'absentStudent': absentStudent,
          'presentStudent': presentStudent
        }, SetOptions(merge: true));
      }
    });
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(classID)
        .collection('Attendence')
        .doc(month)
        .collection(month)
        .doc(date)
        .collection('Subjects')
        .doc(subjectID)
        .collection('AttendenceList')
        .get()
        .then((value) async {
      totalStudentCount = value.docs.length;
      for (var i = 0; i < value.docs.length; i++) {
        if (value.docs[i].data()['present'] == true) {
          presentStudent = presentStudent + 1;
        } else {
          absentStudent = absentStudent + 1;
        }
      }
      log("calculation ******$totalStudentCount");
      log("calculation  Paresent ******$absentStudent");
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('TeacherAttendence')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('DayWiseAttendence')
          .doc(date)
          .get()
          .then((value) async {
        int rtotalStudentCount = value.data()?['totalStudentCount'];
        int rabsentStudent = value.data()?['absentStudent'];
        int rpresentStudent = value.data()?['presentStudent'];
        log("000000000000000000  $rtotalStudentCount");
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('DayWiseAttendence')
            .doc(date)
            .update({
          'totalStudentCount': rtotalStudentCount + totalStudentCount,
          'absentStudent': rabsentStudent + absentStudent,
          'presentStudent': rpresentStudent + presentStudent
        });
      });
    });
  }

  Future<void> studentstatusTeacherMonthWise(
      {required String classID,
      required String month,
      required String date,
      required String subjectID}) async {
    int totalStudentCount = 0;
    int absentStudent = 0;
    int presentStudent = 0;
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('TeacherAttendence')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MonthWiseAttendence')
        .doc(month)
        .collection(month)
        .doc(date)
        .get()
        .then((value) async {
      if (value.data()!.containsKey('totalStudentCount')) {
        return;
      } else {
        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('MonthWiseAttendence')
            .doc(month)
            .collection(month)
            .doc(date)
            .set({
          'totalStudentCount': totalStudentCount,
          'absentStudent': absentStudent,
          'presentStudent': presentStudent
        }, SetOptions(merge: true));
      }
    });
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(classID)
        .collection('Attendence')
        .doc(month)
        .collection(month)
        .doc(date)
        .collection('Subjects')
        .doc(subjectID)
        .collection('AttendenceList')
        .get()
        .then((value) async {
      totalStudentCount = value.docs.length;
      for (var i = 0; i < value.docs.length; i++) {
        if (value.docs[i].data()['present'] == true) {
          presentStudent = presentStudent + 1;
        } else {
          absentStudent = absentStudent + 1;
        }
      }
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('TeacherAttendence')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('MonthWiseAttendence')
          .doc(month)
          .collection(month)
          .doc(date)
          .get()
          .then((value) async {
        int rtotalStudentCount = value.data()?['totalStudentCount'];
        int rabsentStudent = value.data()?['absentStudent'];
        int rpresentStudent = value.data()?['presentStudent'];

        await server
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('TeacherAttendence')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('MonthWiseAttendence')
            .doc(month)
            .collection(month)
            .doc(date)
            .update({
          'totalStudentCount': rtotalStudentCount + totalStudentCount,
          'absentStudent': rabsentStudent + absentStudent,
          'presentStudent': rpresentStudent + presentStudent
        });
      });
    });
  }
}
