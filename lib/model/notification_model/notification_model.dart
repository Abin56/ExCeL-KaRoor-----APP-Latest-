// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class NotificationModel {
  final IconData? icon;
  final String messageText;
  final String headerText;
  final Color whiteshadeColor;
  final Color containerColor;
  final bool open;
  final String docid;
  final String dateTime;
  NotificationModel({
    this.icon,
    required this.messageText,
    required this.headerText,
    required this.whiteshadeColor,
    required this.containerColor,
    required this.open,
    required this.docid,
    required this.dateTime,
  });


  NotificationModel copyWith({
    IconData? icon,
    String? messageText,
    String? headerText,
    Color? whiteshadeColor,
    Color? containerColor,
    bool? open,
    String? docid,
    String? dateTime,
  }) {
    return NotificationModel(
      icon: icon ?? this.icon,
      messageText: messageText ?? this.messageText,
      headerText: headerText ?? this.headerText,
      whiteshadeColor: whiteshadeColor ?? this.whiteshadeColor,
      containerColor: containerColor ?? this.containerColor,
      open: open ?? this.open,
      docid: docid ?? this.docid,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon?.codePoint,
      'messageText': messageText,
      'headerText': headerText,
      'whiteshadeColor': whiteshadeColor.value,
      'containerColor': containerColor.value,
      'open': open,
      'docid': docid,
      'dateTime': dateTime,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      icon: map['icon'] != null ? IconData(map['icon'] ?? 0, fontFamily: 'MaterialIcons') : null,
      messageText: map['messageText'] ??"",
      headerText: map['headerText'] ??"",
      whiteshadeColor: Color(map['whiteshadeColor'] ?? 0),
      containerColor: Color(map['containerColor'] ?? 0),
      open: map['open'] as bool,
      docid: map['docid'] ??"",
      dateTime: map['dateTime'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(icon: $icon, messageText: $messageText, headerText: $headerText, whiteshadeColor: $whiteshadeColor, containerColor: $containerColor, open: $open, docid: $docid, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.icon == icon &&
      other.messageText == messageText &&
      other.headerText == headerText &&
      other.whiteshadeColor == whiteshadeColor &&
      other.containerColor == containerColor &&
      other.open == open &&
      other.docid == docid &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
      messageText.hashCode ^
      headerText.hashCode ^
      whiteshadeColor.hashCode ^
      containerColor.hashCode ^
      open.hashCode ^
      docid.hashCode ^
      dateTime.hashCode;
  }
}
