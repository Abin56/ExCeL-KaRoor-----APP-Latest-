import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/sign_up_controller/parent_sign_up_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/model/parent_model/parent_model.dart';

class SelectTempParentDropDown extends StatelessWidget {
  SelectTempParentDropDown({
    super.key,
  });

  final parentCntrl = Get.put(ParentSignUpController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<ParentModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      // autoValidateMode: AutovalidateMode.always,

      asyncItems: (value) {
        parentCntrl.tempParentList.clear();

        return parentCntrl.fetchAllTempParent();
      },
      itemAsString: (value) => value.parentName??"",
      onChanged: (value) async {
        if (value != null) {
          parentCntrl.tempParentName.value = value.parentName??"";
          parentCntrl.tempParentDocID.value = value.docid??"";
          UserCredentialsController.parentModel = value;
          log("Temp Student ID ${Get.find<ParentSignUpController>().tempParentDocID.value}");
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Parent", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
