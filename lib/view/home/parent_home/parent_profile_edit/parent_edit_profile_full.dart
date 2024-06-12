import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/widgets/edit_list_tile_widget.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/widgets/parent_email_update_widget.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/parent_profile_edit_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../utils/utils.dart';
import '../../../colors/colors.dart';
import '../../../widgets/fonts/google_poppins.dart';
import 'widgets/circle_avatar_image_widget.dart';
import 'widgets/update_text_form_widget.dart';

class ParentEditProfileScreenFull extends StatefulWidget {
  const ParentEditProfileScreenFull({super.key});

  @override
  State<ParentEditProfileScreenFull> createState() => _ParentEditProfileScreenFullState();
}

class _ParentEditProfileScreenFullState extends State<ParentEditProfileScreenFull> {
  final ParentProfileEditController parentProfileEditController =
      Get.put(ParentProfileEditController());

       String? selectedGender;

        @override
  void initState() {
    super.initState();
    selectedGender = UserCredentialsController.parentModel?.gender;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: adminePrimayColor,
          title: const Text("Profile"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.h),
                    bottomRight: Radius.circular(12.h)),
                color: adminePrimayColor,
              ),
              child: CircleAvatharImageSelectionWidgetParent(),
            ),
            ParentEditListileWidget(
              icon: Icons.person,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController.parentModel?.parentName ??
                          "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.parentName ??
                                "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "parentName",
                          textInputType: TextInputType.text,
                          hint: 'Name',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),

            //phone number
            ParentEditListileWidget(
              icon: Icons.call,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController
                              .parentModel?.parentPhoneNumber ??
                          "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "Phone Number".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController
                                    .parentModel?.parentPhoneNumber ??
                                "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          documentKey: "parentPhoneNumber",
                          textInputType: TextInputType.phone,
                          hint: 'Phone Number',
                          validator: checkFieldPhoneNumberIsValid,
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),

            //email
            ParentEditListileWidgetEmail(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.parentModel?.parentEmail ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),
            //Gender
            ParentEditListileWidget(
              icon: Icons.person,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController.parentModel?.gender ?? "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "Gender".tr, fontsize: 12.h),
                   DropdownButton<String>(
         // value: selectedGender,
          icon: const Icon(Icons.edit),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: const SizedBox.shrink(),  
          onChanged: (String? newValue) async {
            setState(() {
              selectedGender = newValue;
            });
            parentProfileEditController.textEditingController.text = newValue ?? "";
            await profileUpdate(
              context: context,
              textEditingController: parentProfileEditController.textEditingController,
              validator: checkFieldEmpty,
              documentKey: "gender",
              textInputType: TextInputType.text,
              hint: 'Gender',
            );
              setState(() {});
          },
          items: <String>['Male', 'Female',]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
                  // IconButton(
                  //     onPressed: () async {
                  //       parentProfileEditController.textEditingController.text =
                  //           UserCredentialsController.parentModel?.gender ?? "";
                  //       await profileUpdate(
                  //         context: context,
                  //         textEditingController:
                  //             parentProfileEditController.textEditingController,
                  //         validator: checkFieldEmpty,
                  //         documentKey: "gender",
                  //         textInputType: TextInputType.text,
                  //         hint: 'Gender',
                  //       );
                  //         setState(() {});
                  //     },
                  //     icon: const Icon(
                  //       Icons.edit,
                  //       color: Colors.green,
                  //     ))
                ],
              ),
            ),
            //House Name
            ParentEditListileWidget(
              icon: Icons.home,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController.parentModel?.houseName ??
                          "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "House Name".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.houseName ??
                                "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "houseName",
                          textInputType: TextInputType.text,
                          hint: 'House Name',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            //place
            ParentEditListileWidget(
              icon: Icons.place,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController.parentModel?.place ?? "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "Place".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.place ?? "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "place",
                          textInputType: TextInputType.text,
                          hint: 'Place',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            //district
            ParentEditListileWidget(
              icon: Icons.place,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text:
                          UserCredentialsController.parentModel?.district ?? "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "District".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.district ??
                                "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "district",
                          textInputType: TextInputType.text,
                          hint: 'District',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            //state
            ParentEditListileWidget(
              icon: Icons.place,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text: UserCredentialsController.parentModel?.state ?? "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "State".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.state ?? "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "state",
                          textInputType: TextInputType.text,
                          hint: 'State',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            //pincode
            ParentEditListileWidget(
              icon: Icons.pin,
              subtitle: Row(
                children: [
                  GooglePoppinsWidgets(
                      text:
                          UserCredentialsController.parentModel?.pincode ?? "",
                      fontsize: 19.h),
                ],
              ),
              title: Row(
                children: [
                  GooglePoppinsWidgets(text: "Pincode".tr, fontsize: 12.h),
                  IconButton(
                      onPressed: () async {
                        parentProfileEditController.textEditingController.text =
                            UserCredentialsController.parentModel?.pincode ??
                                "";
                        await profileUpdate(
                          context: context,
                          textEditingController:
                              parentProfileEditController.textEditingController,
                          validator: checkFieldEmpty,
                          documentKey: "pincode",
                          textInputType: TextInputType.number,
                          hint: 'Pincode',
                        );
                          setState(() {});
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> profileUpdate({
    required BuildContext context,
    required TextEditingController textEditingController,
    required String documentKey,
    required String hint,
    required TextInputType textInputType,
    String? Function(String?)? validator,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Form(
        key: parentProfileEditController.formKey,
        child: updateTextFormField(
          validator: validator,
          context: context,
          hintText: hint,
          textEditingController: textEditingController,
          voidCallback: () async {
            if (parentProfileEditController.formKey.currentState!.validate()) {
              await parentProfileEditController.updateParentProfile(
                context,
                value: textEditingController.text,
                documentKey: documentKey,
              );
            } else {
              return showToast(msg: "Please enter a valid data");
            }
          },
          textInputType: textInputType,
        ),
      ),
    );
  }
}
