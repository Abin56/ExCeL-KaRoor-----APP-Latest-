// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeacherModel {
  String? teacherName;
  String? teacherEmail;
  String? password;
  String? houseName;
  String? houseNumber;
  String? place;
  String? gender;
  String? district;
  String? altPhoneNo;
  String? employeeID;
  String? createdAt;
  String? teacherPhNo;
  String? docid;
  String userRole;
  String? imageId;
  String? imageUrl;
  String? classID;
  String? cardID;
  TeacherModel({
    this.teacherName,
    this.teacherEmail,
    this.password,
    this.houseName,
    this.houseNumber,
    this.place,
    this.gender,
    this.district,
    this.altPhoneNo,
    this.employeeID,
    this.createdAt,
    this.teacherPhNo,
    this.docid,
    this.userRole = 'teacher',
    this.imageId,
    this.imageUrl,
    this.classID,
    this.cardID,
  });

  TeacherModel copyWith({
    String? teacherName,
    String? teacherEmail,
    String? password,
    String? houseName,
    String? houseNumber,
    String? place,
    String? gender,
    String? district,
    String? altPhoneNo,
    String? employeeID,
    String? createdAt,
    String? teacherPhNo,
    String? docid,
    String? userRole,
    String? imageId,
    String? imageUrl,
    String? classID,
    String? cardID,
  }) {
    return TeacherModel(
      teacherName: teacherName ?? this.teacherName,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      password: password ?? this.password,
      houseName: houseName ?? this.houseName,
      houseNumber: houseNumber ?? this.houseNumber,
      place: place ?? this.place,
      gender: gender ?? this.gender,
      district: district ?? this.district,
      altPhoneNo: altPhoneNo ?? this.altPhoneNo,
      employeeID: employeeID ?? this.employeeID,
      createdAt: createdAt ?? this.createdAt,
      teacherPhNo: teacherPhNo ?? this.teacherPhNo,
      docid: docid ?? this.docid,
      userRole: userRole ?? this.userRole,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      classID: classID ?? this.classID,
      cardID: cardID ?? this.cardID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacherName': teacherName ?? "",
      'teacherEmail': teacherEmail ?? "",
      'password': password ?? '',
      'houseName': houseName ?? '',
      'houseNumber': houseNumber ?? '',
      'place': place ?? '',
      'gender': gender ?? '',
      'district': district ?? '',
      'altPhoneNo': altPhoneNo ?? '',
      'employeeID': employeeID ?? '',
      'createdAt': createdAt ?? '',
      'teacherPhNo': teacherPhNo ?? '',
      'docid': docid ?? '',
      'userRole': userRole,
      'imageId': imageId ?? '',
      'imageUrl': imageUrl ?? '',
      'classID': classID ?? '',
      'cardID': cardID ?? '',
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      teacherName: map['teacherName'] ?? "",
      teacherEmail: map['teacherEmail'] ?? "",
      password: map['password'] ?? "",
      houseName: map['houseName'] ?? '',
      houseNumber: map['houseNumber'] ?? '',
      place: map['place'] ?? '',
      gender: map['gender'] ?? '',
      district: map['district'] ?? '',
      altPhoneNo: map['altPhoneNo'] ?? '',
      employeeID: map['employeeID'] ?? '',
      createdAt: map['createdAt'] ?? '',
      teacherPhNo: map['teacherPhNo'] ?? '',
      docid: map['docid'] ?? '',
      userRole: map['userRole'] ?? '',
      imageId: map['imageId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      classID: map['classID'] ?? '',
      cardID: map['cardID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherModel(teacherName: $teacherName, teacherEmail: $teacherEmail, password: $password, houseName: $houseName, houseNumber: $houseNumber, place: $place, gender: $gender, district: $district, altPhoneNo: $altPhoneNo, employeeID: $employeeID, createdAt: $createdAt, teacherPhNo: $teacherPhNo, docid: $docid, userRole: $userRole, imageId: $imageId, imageUrl: $imageUrl, classID: $classID, cardID: $cardID)';
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;

    return other.teacherName == teacherName &&
        other.teacherEmail == teacherEmail &&
        other.password == password &&
        other.houseName == houseName &&
        other.houseNumber == houseNumber &&
        other.place == place &&
        other.gender == gender &&
        other.district == district &&
        other.altPhoneNo == altPhoneNo &&
        other.employeeID == employeeID &&
        other.createdAt == createdAt &&
        other.teacherPhNo == teacherPhNo &&
        other.docid == docid &&
        other.userRole == userRole &&
        other.imageId == imageId &&
        other.imageUrl == imageUrl &&
        other.classID == classID &&
        other.cardID == cardID;
  }

  @override
  int get hashCode {
    return teacherName.hashCode ^
        teacherEmail.hashCode ^
        password.hashCode ^
        houseName.hashCode ^
        houseNumber.hashCode ^
        place.hashCode ^
        gender.hashCode ^
        district.hashCode ^
        altPhoneNo.hashCode ^
        employeeID.hashCode ^
        createdAt.hashCode ^
        teacherPhNo.hashCode ^
        docid.hashCode ^
        userRole.hashCode ^
        imageId.hashCode ^
        imageUrl.hashCode ^
        classID.hashCode ^
        cardID.hashCode;
  }
}
