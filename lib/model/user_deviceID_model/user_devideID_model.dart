// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDeviceIDModel {
  String batchID;
  String classID;
  String devideID;
  String uid;
  String userrole;
  String schoolID;
  bool message;
  UserDeviceIDModel({
    required this.batchID,
    required this.classID,
    required this.devideID,
    required this.uid,
    required this.userrole,
    required this.schoolID,
    required this.message,
  });

  UserDeviceIDModel copyWith({
    String? batchID,
    String? classID,
    String? devideID,
    String? uid,
    String? userrole,
    String? schoolID,
    bool? message,
  }) {
    return UserDeviceIDModel(
      batchID: batchID ?? this.batchID,
      classID: classID ?? this.classID,
      devideID: devideID ?? this.devideID,
      uid: uid ?? this.uid,
      userrole: userrole ?? this.userrole,
      schoolID: schoolID ?? this.schoolID,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batchID': batchID,
      'classID': classID,
      'devideID': devideID,
      'uid': uid,
      'userrole': userrole,
      'schoolID': schoolID,
      'message': message,
    };
  }

  factory UserDeviceIDModel.fromMap(Map<String, dynamic> map) {
    return UserDeviceIDModel(
      batchID: map['batchID'] ??'',
      classID: map['classID'] ??'',
      devideID: map['devideID'] ??'',
      uid: map['uid'] ??'',
      userrole: map['userrole'] ??'',
      schoolID: map['schoolID'] ??'',
      message: map['message'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDeviceIDModel.fromJson(String source) =>
      UserDeviceIDModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDeviceIDModel(batchID: $batchID, classID: $classID, devideID: $devideID, uid: $uid, userrole: $userrole, schoolID: $schoolID, message: $message)';
  }

  @override
  bool operator ==(covariant UserDeviceIDModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.batchID == batchID &&
      other.classID == classID &&
      other.devideID == devideID &&
      other.uid == uid &&
      other.userrole == userrole &&
      other.schoolID == schoolID &&
      other.message == message;
  }

  @override
  int get hashCode {
    return batchID.hashCode ^
      classID.hashCode ^
      devideID.hashCode ^
      uid.hashCode ^
      userrole.hashCode ^
      schoolID.hashCode ^
      message.hashCode;
  }
}
