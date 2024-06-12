// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExamNotificationModel {
  String examName;
  String publishDate;
  String startDate;
  String endDate;
  String docId;
  int totalDays;
  ExamNotificationModel({
    required this.examName,
    required this.publishDate,
    required this.startDate,
    required this.endDate,
    required this.docId,
    required this.totalDays,
  });

  ExamNotificationModel copyWith({
    String? examName,
    String? publishDate,
    String? startDate,
    String? endDate,
    String? docId,
    int? totalDays,
  }) {
    return ExamNotificationModel(
      examName: examName ?? this.examName,
      publishDate: publishDate ?? this.publishDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      docId: docId ?? this.docId,
      totalDays: totalDays ?? this.totalDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'examName': examName,
      'publishDate': publishDate,
      'startDate': startDate,
      'endDate': endDate,
      'docId': docId,
      'totalDays': totalDays,
    };
  }

  factory ExamNotificationModel.fromMap(Map<String, dynamic> map) {
    return ExamNotificationModel(
      examName: map['examName'] as String,
      publishDate: map['publishDate'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      docId: map['docId'] as String,
      totalDays: map['totalDays'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamNotificationModel.fromJson(String source) =>
      ExamNotificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExamNotificationModel(examName: $examName, publishDate: $publishDate, startDate: $startDate, endDate: $endDate, docId: $docId, totalDays: $totalDays)';
  }

  @override
  bool operator ==(covariant ExamNotificationModel other) {
    if (identical(this, other)) return true;

    return other.examName == examName &&
        other.publishDate == publishDate &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.docId == docId &&
        other.totalDays == totalDays;
  }

  @override
  int get hashCode {
    return examName.hashCode ^
        publishDate.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        docId.hashCode ^
        totalDays.hashCode;
  }
}
