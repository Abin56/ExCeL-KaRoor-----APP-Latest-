// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel_karoor/controllers/attendence_controller/attendence_controller.dart';
import 'package:excel_karoor/controllers/teacher_attendence/teacher_attendence.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/attendence_model/attendence-model.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/fonts/text_widget.dart';
import 'package:excel_karoor/widgets/progress_sync_widget/sync_progress_screen.dart';

import '../../widgets/button_container_widget.dart';

class TakeAttenenceScreen extends StatefulWidget {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final TeacherAttendenceController teacherAttendenceController =
      Get.put(TeacherAttendenceController());
  final String periodNumber;
  final String periodTokenID;
  final String schoolID;
  final String classID;
  final String teacheremailID;
  final String subjectID;
  final String subjectName;
  final String batchId;

  TakeAttenenceScreen(
      {required this.classID,
      required this.schoolID,
      required this.teacheremailID,
      required this.subjectID,
      required this.subjectName,
      required this.batchId,
      required this.periodTokenID,
      required this.periodNumber,
      super.key});

  @override
  State<TakeAttenenceScreen> createState() => _TakeAttenenceScreenState();
}

class _TakeAttenenceScreenState extends State<TakeAttenenceScreen> {
  String schoolTimer = '';
  bool? pageLoading = false;
  bool? present;
  Map<String, bool?> presentlist = {};
  String timer = '';
  List<AttendanceStudentModel> attendanceList = [];
  List<String> tokenList = [];
  List<String> tokenList2 = [];
  DateTime? attendanceTime;
  String substring = '';
  String finalSubjectName = '';
  String schoolName = '';
  String studentName = '';
  bool notificationEnabledOrNot = true;

  List<Map<String, dynamic>> parentListOfAbsentees = [];
  List<Map<String, dynamic>> guardianListOfAbsentees = [];

  getSchoolName() async {
    final docRef = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(widget.schoolID)
        .get();
    schoolName = docRef['schoolName'];
  }

  String subjectNameFormatting() {
    substring = getSubstringUntilNumber(widget.subjectName)!;
    print(substring);
    return substring;
  }

  String? getSubstringUntilNumber(String input) {
    RegExp regex = RegExp(r'^\D+');
    RegExpMatch? match = regex.firstMatch(input);
    if (match != null) {
      return match.group(0);
    }
    return '';
  }

  Future<void> getTime() async {
    DocumentSnapshot<Map<String, dynamic>> timersnap = await FirebaseFirestore
        .instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Notifications')
        .doc('Attendance')
        .get();
    log(timersnap.data()!['timeToDeliverAbsenceNotification']);
    setState(() {
      notificationEnabledOrNot = timersnap.data()!['notificationNeededOrNot'];
      log('tof : $notificationEnabledOrNot');
    });

    timer = timersnap.data()!['timeToDeliverAbsenceNotification'];
  }

  @override
  void initState() {
    getClassName();
    super.initState();
    getSchoolTimer();

    getTime();
    finalSubjectName = subjectNameFormatting();
    log(finalSubjectName);

    getSchoolName();
    pageLoading = true;
  }

  String className = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(widget.schoolID)
            .collection(widget.batchId)
            .doc(widget.batchId)
            .collection("classes")
            .doc(widget.classID)
            .collection('Students')
            .orderBy('studentName', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          final date = DateTime.now();
          DateTime parseDate = DateTime.parse(date.toString());
          final month = DateFormat('MMMM-yyyy');
          String monthwise = month.format(parseDate);
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          String formatted = formatter.format(parseDate);
          if (snapshot.hasData) {
            if (pageLoading == true) {
              log("Page Loading........................");
              markAllStudentPresent(snapshot);
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  final datetimeNow = DateTime.now();
                  DateTime parseDatee = DateTime.parse(datetimeNow.toString());
                  final DateFormat dayformatterr = DateFormat('EEEE');
                  String dayformattedd = dayformatterr.format(parseDatee);
                  final DateFormat formatterr = DateFormat('dd-MMMM-yyy');
                  String formattedd = formatterr.format(parseDatee);
                  if (index == snapshot.data!.docs.length) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<AttendanceStudentModel> newlist =
                                attendanceList
                                    .where(
                                        (element) => element.present == false)
                                    .toList();
                            await getAttedenceList(newlist, attendanceList);
                          },
                          child: ButtonContainerWidget(
                            curving: 10,
                            colorindex: 2,
                            height: 60,
                            width: 150,
                            child: Center(
                                child: Text(
                              'Submit'.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    height: 60,
                    color: presentlist[snapshot.data!.docs[index]
                                ['studentName']] ==
                            null
                        ? Colors.transparent
                        : presentlist[snapshot.data!.docs[index]
                                    ['studentName']] ==
                                true
                            ? Colors.green.withOpacity(0.4)
                            : Colors.red.withOpacity(0.4),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('${index + 1}'),
                        kWidth20,
                        SizedBox(
                          width: 200,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                  child: Text(snapshot.data!.docs[index]
                                      ['studentName']))),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                presentlist[snapshot.data!.docs[index]
                                    ['studentName']!] = true;
                                log(present.toString());
                              });

                              final indexx = attendanceList.indexWhere(
                                  (element) =>
                                      element.uid ==
                                      snapshot.data!.docs[index]['docid']);

                              if (indexx != -1) {
                                attendanceList[indexx].present = true;
                              } else {
                                attendanceList.add(AttendanceStudentModel(
                                    Date: date.toString(),
                                    present: true,
                                    studentName: snapshot.data!.docs[index]
                                        ['studentName'],
                                    uid: snapshot.data!.docs[index]['docid']));
                              }
                            },
                            icon: const Icon(Icons.add)),
                        kWidth20,
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                presentlist[snapshot.data!.docs[index]
                                    ['studentName']!] = false;
                                log(present.toString());
                              });
                              final indexx = attendanceList.indexWhere(
                                  (element) =>
                                      element.uid ==
                                      snapshot.data!.docs[index]['docid']);

                              if (indexx != -1) {
                                //condition means hasdata in list
                                attendanceList[indexx].present = false;
                              } else {
                                attendanceList.add(AttendanceStudentModel(
                                    Date: date.toString(),
                                    present: false,
                                    studentName: snapshot.data!.docs[index]
                                        ['studentName'],
                                    uid: snapshot.data!.docs[index]['docid']));
                              }
                            },
                            icon: const Icon(Icons.remove))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length + 1);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }

  void getSchoolTimer() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('Notifications')
        .doc('Attendance')
        .get();
    setState(() {
      schoolTimer = vari.data()!['timeToDeliverAbsenceNotification'];
      log('schoolTimer >>>>>>>>>>>>>$schoolTimer');
    });
  }

  getAttedenceList(List<AttendanceStudentModel> list,
      List<AttendanceStudentModel> alllist) async {
    log("message$list");

    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final month = DateFormat('MMMM-yyyy');
        String monthwise = month.format(parseDate);
        return AlertDialog(
          title: const Text('Absentess List'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  width: double.maxFinite,
                  child: list.isEmpty
                      ? const Center(
                          child: Text("No Absentess"),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            log(" List >>>>>>$list");
                            if (list[index].present == false) {
                              return Container(
                                height: 40,
                                width: double.maxFinite,
                                color: Colors.red.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('${index + 1}'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(list[index].studentName),
                                      const Spacer(),
                                      const Text(' - Ab')
                                    ],
                                  ),
                                ),
                              );
                            } else if (list.isEmpty) {
                              log("Emptyyyy");
                              return const Center(child: Text("data"));
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: list.length),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Edit'),
              onPressed: () async {
                Navigator.of(context).pop();

                attendanceTime = DateTime.now();
                String formattedDate =
                    DateFormat.yMMMMd().format(attendanceTime!);
                String formattedTime = DateFormat.jm().format(DateTime.now());
                Future<QuerySnapshot<Map<String, dynamic>>> absentStudentsList =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection("Attendence")
                        .doc(formatted)
                        .collection("Subjects")
                        .doc(widget.subjectID)
                        .collection('AttendenceList')
                        .where('present', isEqualTo: false)
                        .get();

                QuerySnapshot<Map<String, dynamic>> snapshot =
                    await absentStudentsList;
                List<Map<String, dynamic>> mappedAbsentStudentsList =
                    snapshot.docs.map((doc) => doc.data()).toList();

                Future<QuerySnapshot<Map<String, dynamic>>> parentss =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection('Parents')
                        .get();

                Future<QuerySnapshot<Map<String, dynamic>>> guardianss =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection('GuardianCollection')
                        .get();

                QuerySnapshot<Map<String, dynamic>> snapshot2 = await parentss;
                List<Map<String, dynamic>> parentsList =
                    snapshot2.docs.map((doc) => doc.data()).toList();

                QuerySnapshot<Map<String, dynamic>> snapshot3 =
                    await guardianss;
                List<Map<String, dynamic>> guardiansList =
                    snapshot2.docs.map((doc) => doc.data()).toList();

                bool isValueEqual = false;

                for (var item1 in parentsList) {
                  for (var item2 in mappedAbsentStudentsList) {
                    if (item1['studentID'] == item2['uid']) {
                      log('yesss!!!!!');
                      parentListOfAbsentees.add(item1);

                      log('THE LIST : ${parentListOfAbsentees.length.toString()}');
                      isValueEqual = true;
                      break;
                    }
                  }
                  //parentListOfAbsentees
                }

                for (var item1 in guardiansList) {
                  for (var item2 in mappedAbsentStudentsList) {
                    if (item1['studentID'] == item2['uid']) {
                      log('yesss!!!!!');
                      guardianListOfAbsentees.add(item1);

                      log('THE GLIST : ${parentListOfAbsentees.length.toString()}');
                      isValueEqual = true;
                      break;
                    }
                  }
                  //parentListOfAbsentees
                }

                log('HWG: $parentListOfAbsentees');
                for (var k in parentListOfAbsentees) {
                  tokenList.add(k['deviceToken']);
                }

                for (var r in guardianListOfAbsentees) {
                  tokenList2.add(r['deviceToken']);
                }

                Timer(Duration(hours: int.parse(timer)), () async {});
              },
            ),
            TextButton(
              child: const Text('Upload'),
              onPressed: () async {
                return showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                'Are you sure to continue with this absentees list?\nIf you want to edit, please do it before publishing from the Attendance book..')
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            child: const Text('Upload Attendance'),
                            onPressed: () async {
                              getProgressDilogue(context,
                                  widget.attendanceController.progress);
                              final datetimeNow = DateTime.now();
                              DateTime parseDatee =
                                  DateTime.parse(datetimeNow.toString());
                              final DateFormat dayformatterr =
                                  DateFormat('EEEE');
                              String dayformattedd =
                                  dayformatterr.format(parseDatee);
                              final DateFormat formatterr =
                                  DateFormat('dd-MMMM-yyy');
                              String formattedd = formatterr.format(parseDatee);
                              final date = DateTime.now();
                              DateTime parseDate =
                                  DateTime.parse(date.toString());
                              final month = DateFormat('MMMM-yyyy');
                              String monthwise = month.format(parseDate);
                              final DateFormat formatter =
                                  DateFormat('dd-MM-yyyy');
                              String formatted = formatter.format(parseDate);

                              log('period document id ${widget.periodTokenID}');

                              attendanceTime = DateTime.now();
                              String formattedDate =
                                  DateFormat.yMMMMd().format(attendanceTime!);
                              String formattedTime =
                                  DateFormat.jm().format(DateTime.now());

                              for (var i = 0; i < alllist.length; i++) {
                                double progress = (i + 1) / alllist.length / 2;
                                widget.attendanceController
                                    .updateProgress(progress);
                                await FirebaseFirestore.instance
                                    .collection("SchoolListCollection")
                                    .doc(widget.schoolID)
                                    .collection(widget.batchId)
                                    .doc(widget.batchId)
                                    .collection("classes")
                                    .doc(widget.classID)
                                    .collection("Attendence")
                                    .doc(monthwise)
                                    .set({'id': monthwise}).then(
                                  (value) async {
                                    await FirebaseFirestore.instance
                                        .collection("SchoolListCollection")
                                        .doc(widget.schoolID)
                                        .collection(widget.batchId)
                                        .doc(widget.batchId)
                                        .collection("classes")
                                        .doc(widget.classID)
                                        .collection("Attendence")
                                        .doc(monthwise)
                                        .collection(monthwise)
                                        .doc(formatted)
                                        .set({
                                      "docid": formatted,
                                      'dDate': formattedd,
                                      'day': dayformattedd
                                    }, SetOptions(merge: true)).then(
                                      (value) {
                                        FirebaseFirestore.instance
                                            .collection("SchoolListCollection")
                                            .doc(widget.schoolID)
                                            .collection(widget.batchId)
                                            .doc(widget.batchId)
                                            .collection("classes")
                                            .doc(widget.classID)
                                            .collection("Attendence")
                                            .doc(monthwise)
                                            .collection(monthwise)
                                            .doc(formatted)
                                            .collection("Subjects")
                                            .doc(widget.periodTokenID)
                                            .set({
                                          "docid": widget.periodTokenID,
                                          'period': widget.periodNumber,
                                          'subject': widget.subjectName,
                                          'date': DateTime.now().toString(),
                                          'onSubmit': false,
                                          'exTime': DateTime.now()
                                              .add(Duration(
                                                  minutes:
                                                      int.parse(schoolTimer)))
                                              .toString()
                                        }).then(
                                          (value) {
                                            FirebaseFirestore.instance
                                                .collection(
                                                    "SchoolListCollection")
                                                .doc(widget.schoolID)
                                                .collection(widget.batchId)
                                                .doc(widget.batchId)
                                                .collection("classes")
                                                .doc(widget.classID)
                                                .collection("Attendence")
                                                .doc(monthwise)
                                                .collection(monthwise)
                                                .doc(formatted)
                                                .collection("Subjects")
                                                .doc(widget.periodTokenID)
                                                .collection('AttendenceList')
                                                .doc(alllist[i].uid)
                                                .set(alllist[i].toMap())
                                                .then(
                                              (value) async {
                                                widget
                                                    .attendanceController
                                                    .schoolName
                                                    .value = schoolName;
                                                widget
                                                    .attendanceController
                                                    .dateformated
                                                    .value = formatted;
                                                widget
                                                    .attendanceController
                                                    .timeformated
                                                    .value = formattedTime;
                                                await widget
                                                    .attendanceController
                                                    .getSubjectStudentAttendenceList(
                                                  classID: widget.classID,
                                                  studentDocid: alllist[i].uid,
                                                  subjectDocid:
                                                      widget.subjectID,
                                                  studentName:
                                                      alllist[i].studentName,
                                                  present: alllist[i].present,
                                                  subjectName:
                                                      widget.subjectName,
                                                  periodNo: int.parse(
                                                      widget.periodNumber),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                              widget.attendanceController.getStudentAbsentList(
                                classID: widget.classID,
                                periodID: widget.periodTokenID,
                                subject: widget.subjectName,
                              );

                              FirebaseFirestore.instance
                                  .collection("SchoolListCollection")
                                  .doc(widget.schoolID)
                                  .collection(widget.batchId)
                                  .doc(widget.batchId)
                                  .collection("classes")
                                  .doc(widget.classID)
                                  .collection("Attendence")
                                  .doc(monthwise)
                                  .collection(monthwise)
                                  .doc(formatted)
                                  .collection('PeriodCollection')
                                  .doc(widget.periodTokenID)
                                  .delete()
                                  .then((value) async {
                                double progress = 60 / 100;
                                widget.attendanceController
                                    .updateProgress(progress);
                                await widget.teacherAttendenceController
                                    .workingDaysMark(widget.classID);
                                await widget.teacherAttendenceController
                                    .addTeacherAttendence(widget.classID,
                                        className, widget.periodNumber)
                                    .then((value) async {
                                  double progress = 80 / 100;
                                  widget.attendanceController
                                      .updateProgress(progress);
                                  widget.teacherAttendenceController
                                      .studentstatusTeacherDayWise(
                                          classID: widget.classID,
                                          month: monthwise,
                                          date: formatted,
                                          subjectID: widget.periodTokenID)
                                      .then((value) async {
                                    double progress = 90 / 100;
                                    widget.attendanceController
                                        .updateProgress(progress);
                                    widget.teacherAttendenceController
                                        .studentstatusTeacherMonthWise(
                                            classID: widget.classID,
                                            month: monthwise,
                                            date: formatted,
                                            subjectID: widget.periodTokenID);

                                    widget.attendanceController
                                        .updateProgress(100 / 100);
                                  });
                                });
                                await widget.attendanceController.activeClasses(
                                    classID: widget.classID,
                                    periodID: widget.periodTokenID,
                                    month: monthwise,
                                    periodidNO: widget.periodNumber,
                                    subjectName: widget.subjectName,
                                    teacherDocid:
                                        FirebaseAuth.instance.currentUser!.uid);
                                return showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Message'),
                                      content: const SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Attendance uploaded Successfully!')
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });

                              log('DONE');
                            }),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> markAllStudentPresent(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) async {
    for (var i = 0; i < snapshot.data!.docs.length; i++) {
      presentlist[snapshot.data!.docs[i]['studentName']!] = true;
      attendanceList.add(AttendanceStudentModel(
          Date: DateTime.now().toString(),
          present: true,
          studentName: snapshot.data!.docs[i]['studentName'],
          uid: snapshot.data!.docs[i]['docid']));

      log(attendanceList[i].toJson());
    }
    pageLoading = false;
  }

  Future<String> getClassName() async {
    await server
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(widget.classID)
        .get()
        .then((value) async {
      className = value.data()?['className'];
    });
    return className;
  }
}

getProgressDilogue(BuildContext context, RxDouble progressValue) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const BeveledRectangleBorder(),
        title: const TextFontWidget(text: 'Please wait ...', fontsize: 12,fontWeight: FontWeight.bold,),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[ProgressDialog(progressValue: progressValue)],
          ),
        ),
      );
    },
  );
}
