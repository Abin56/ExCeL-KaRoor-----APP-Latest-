// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class TimeTableModel {
  String? selectClass;
  String? dayName;
  String? teacherName;
  String? subjectName;
  String? periodNumber;
  String? startTime;
  String? endTime;
  Color? selectColor;
  
  String docid;
  TimeTableModel({
    this.selectClass,
    this.dayName,
    this.teacherName,
    this.subjectName,
    this.periodNumber,
    this.startTime,
    this.endTime,
    this.selectColor,
    required this.docid,
  });
  TimeTableModel copyWith({
    String? selectClass,
    String? dayName,
    String? teacherName,
    String? subjectName,
    String? periodNumber,
    String? startTime,
    String? endTime,
    Color? selectColor,
    String? docid,
  }) {
    return TimeTableModel(
      selectClass: selectClass ?? this.selectClass,
      dayName: dayName ?? this.dayName,
      teacherName: teacherName ?? this.teacherName,
      subjectName: subjectName ?? this.subjectName,
      periodNumber: periodNumber ?? this.periodNumber,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectColor: selectColor ?? this.selectColor,
      docid: docid ?? this.docid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectClass': selectClass,
      'dayName': dayName,
      'teacherName': teacherName,
      'subjectName': subjectName,
      'periodNumber': periodNumber,
      'startTime': startTime,
      'endTime': endTime,
      'selectColor': selectColor?.value,
      'docid': docid,
    };
  }

  factory TimeTableModel.fromMap(Map<String, dynamic> map) {
    return TimeTableModel(
      selectClass: map['selectClass'] != null ? map['selectClass'] as String : null,
      dayName: map['dayName'] != null ? map['dayName'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      subjectName: map['subjectName'] != null ? map['subjectName'] as String : null,
      periodNumber: map['periodNumber'] != null ? map['periodNumber'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      selectColor: map['selectColor'] != null ? Color(map['selectColor'] as int) : null,
      docid: map['docid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeTableModel.fromJson(String source) =>
      TimeTableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeTableModel(selectClass: $selectClass, dayName: $dayName, teacherName: $teacherName, subjectName: $subjectName, periodNumber: $periodNumber, startTime: $startTime, endTime: $endTime, selectColor: $selectColor, docid: $docid)';
  }

  @override
  bool operator ==(covariant TimeTableModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.selectClass == selectClass &&
      other.dayName == dayName &&
      other.teacherName == teacherName &&
      other.subjectName == subjectName &&
      other.periodNumber == periodNumber &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.selectColor == selectColor &&
      other.docid == docid;
  }

  @override
  int get hashCode {
    return selectClass.hashCode ^
      dayName.hashCode ^
      teacherName.hashCode ^
      subjectName.hashCode ^
      periodNumber.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      selectColor.hashCode ^
      docid.hashCode;
  }
}
