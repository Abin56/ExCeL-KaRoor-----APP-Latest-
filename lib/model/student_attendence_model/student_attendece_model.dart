// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentAttendenceModel {
  String docid;
  String studentDocid;
  String studentName;

  bool present;
  DateTime date;
  String subjectName;
  String subjectID;
  int periodNo;
  StudentAttendenceModel({
    required this.docid,
    required this.studentDocid,
    required this.studentName,
    required this.present,
    required this.date,
    required this.subjectName,
    required this.subjectID,
    required this.periodNo,
  });

  StudentAttendenceModel copyWith({
    String? docid,
    String? studentDocid,
    String? studentName,
    bool? present,
    DateTime? date,
    String? subjectName,
    String? subjectID,
    int? periodNo,
  }) {
    return StudentAttendenceModel(
      docid: docid ?? this.docid,
      studentDocid: studentDocid ?? this.studentDocid,
      studentName: studentName ?? this.studentName,
      present: present ?? this.present,
      date: date ?? this.date,
      subjectName: subjectName ?? this.subjectName,
      subjectID: subjectID ?? this.subjectID,
      periodNo: periodNo ?? this.periodNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'studentDocid': studentDocid,
      'studentName': studentName,
      'present': present,
      'date': date.millisecondsSinceEpoch,
      'subjectName': subjectName,
      'subjectID': subjectID,
      'periodNo': periodNo,
    };
  }

  factory StudentAttendenceModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendenceModel(
      docid: map['docid'] as String,
      studentDocid: map['studentDocid'] as String,
      studentName: map['studentName'] as String,
      present: map['present'] as bool,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      subjectName: map['subjectName'] as String,
      subjectID: map['subjectID'] as String,
      periodNo: map['periodNo'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentAttendenceModel.fromJson(String source) =>
      StudentAttendenceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentAttendenceModel(docid: $docid, studentDocid: $studentDocid, studentName: $studentName, present: $present, date: $date, subjectName: $subjectName, subjectID: $subjectID, periodNo: $periodNo)';
  }

  @override
  bool operator ==(covariant StudentAttendenceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.studentDocid == studentDocid &&
      other.studentName == studentName &&
      other.present == present &&
      other.date == date &&
      other.subjectName == subjectName &&
      other.subjectID == subjectID &&
      other.periodNo == periodNo;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      studentDocid.hashCode ^
      studentName.hashCode ^
      present.hashCode ^
      date.hashCode ^
      subjectName.hashCode ^
      subjectID.hashCode ^
      periodNo.hashCode;
  }
}
