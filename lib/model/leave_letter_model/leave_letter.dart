// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyLeveApplicationModel {
  String id;
  String applyLeaveDate;
  String leaveResontype;
  String leaveFromDate;
  String leaveToDate;
  String leaveReason;
  String studentName;
  String studentParent;
  String dleaveFromDate;
  String dleaveToDate;
  ApplyLeveApplicationModel({
    required this.id,
    required this.applyLeaveDate,
    required this.leaveResontype,
    required this.leaveFromDate,
    required this.leaveToDate,
    required this.leaveReason,
    required this.studentName,
    required this.studentParent,
    required this.dleaveFromDate,
    required this.dleaveToDate,
  });

  ApplyLeveApplicationModel copyWith({
    String? id,
    String? applyLeaveDate,
    String? leaveResontype,
    String? leaveFromDate,
    String? leaveToDate,
    String? leaveReason,
    String? studentName,
    String? studentParent,
    String? dleaveFromDate,
    String? dleaveToDate,
  }) {
    return ApplyLeveApplicationModel(
      id: id ?? this.id,
      applyLeaveDate: applyLeaveDate ?? this.applyLeaveDate,
      leaveResontype: leaveResontype ?? this.leaveResontype,
      leaveFromDate: leaveFromDate ?? this.leaveFromDate,
      leaveToDate: leaveToDate ?? this.leaveToDate,
      leaveReason: leaveReason ?? this.leaveReason,
      studentName: studentName ?? this.studentName,
      studentParent: studentParent ?? this.studentParent,
      dleaveFromDate: dleaveFromDate ?? this.dleaveFromDate,
      dleaveToDate: dleaveToDate ?? this.dleaveToDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'applyLeaveDate': applyLeaveDate,
      'leaveResontype': leaveResontype,
      'leaveFromDate': leaveFromDate,
      'leaveToDate': leaveToDate,
      'leaveReason': leaveReason,
      'studentName': studentName,
      'studentParent': studentParent,
      'dleaveFromDate': dleaveFromDate,
      'dleaveToDate': dleaveToDate,
    };
  }

  factory ApplyLeveApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplyLeveApplicationModel(
      id: map['id'] ??'',
      applyLeaveDate: map['applyLeaveDate'] ??'',
      leaveResontype: map['leaveResontype'] ??'',
      leaveFromDate: map['leaveFromDate'] ??'',
      leaveToDate: map['leaveToDate'] ??'',
      leaveReason: map['leaveReason'] ??'',
      studentName: map['studentName'] ??'',
      studentParent: map['studentParent'] ??'',
      dleaveFromDate: map['dleaveFromDate'] ??'',
      dleaveToDate: map['dleaveToDate'] ??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyLeveApplicationModel.fromJson(String source) =>
      ApplyLeveApplicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApplyLeveApplicationModel(id: $id, applyLeaveDate: $applyLeaveDate, leaveResontype: $leaveResontype, leaveFromDate: $leaveFromDate, leaveToDate: $leaveToDate, leaveReason: $leaveReason, studentName: $studentName, studentParent: $studentParent, dleaveFromDate: $dleaveFromDate, dleaveToDate: $dleaveToDate)';
  }

  @override
  bool operator ==(covariant ApplyLeveApplicationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.applyLeaveDate == applyLeaveDate &&
      other.leaveResontype == leaveResontype &&
      other.leaveFromDate == leaveFromDate &&
      other.leaveToDate == leaveToDate &&
      other.leaveReason == leaveReason &&
      other.studentName == studentName &&
      other.studentParent == studentParent &&
      other.dleaveFromDate == dleaveFromDate &&
      other.dleaveToDate == dleaveToDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      applyLeaveDate.hashCode ^
      leaveResontype.hashCode ^
      leaveFromDate.hashCode ^
      leaveToDate.hashCode ^
      leaveReason.hashCode ^
      studentName.hashCode ^
      studentParent.hashCode ^
      dleaveFromDate.hashCode ^
      dleaveToDate.hashCode;
  }
}

class ApplyLeaveLetterStatusToFireBase {
  Future applyLeaveLetterController(ApplyLeveApplicationModel productModel, context, schoolid,
      classId, studentID, leavedocID, studentName, batchId) async {
    try {
      final firebase = FirebaseFirestore.instance;
      // ignore: unused_local_variable
      final doc = firebase
          .collection("SchoolListCollection")
          .doc(schoolid)
          .collection(batchId)
          .doc(batchId)
          .collection("classes")
          .doc(classId)
          .collection("LeaveApplication")
          .doc(leavedocID)
          .set({'docid': leavedocID}).then((value) {
        firebase
            .collection("SchoolListCollection")
            .doc(schoolid)
            .collection(batchId)
            .doc(batchId)
            .collection("classes")
            .doc(classId)
            .collection("LeaveApplication")
            .doc(leavedocID)
            .collection("StudentsList")
            .doc(studentName)
            .set(productModel.toMap())
            .then((value) {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Message'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Leave Application Sented SuccessFully'.tr),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      });
    } on FirebaseException catch (e) {
      print('Error ${e.message.toString()}');
    }
  }
}
