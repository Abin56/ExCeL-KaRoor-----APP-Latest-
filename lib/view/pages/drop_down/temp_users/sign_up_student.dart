import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/sign_in_controller/student_sign_in_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/student_model/student_model.dart';

class SelectTempStudentDropDown extends StatelessWidget {
  SelectTempStudentDropDown({
    super.key,

  });


  final studentCntrl = Get.put(StudentSignInController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<StudentModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      // autoValidateMode: AutovalidateMode.always,

      asyncItems: (value) {
        studentCntrl.tempstudentList.clear();

        return studentCntrl.fetchAllTempStudent();
      },
      itemAsString: (value) => value.studentName,
      onChanged: (value) async {
        if (value != null) {
          studentCntrl.tempstudentName.value = value.studentName;
          studentCntrl.tempstudentDocID.value = value.docid;
          UserCredentialsController.studentModel=value;
          log("Temp Student ID ${Get.find<StudentSignInController>().tempstudentDocID.value}");
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Student", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
