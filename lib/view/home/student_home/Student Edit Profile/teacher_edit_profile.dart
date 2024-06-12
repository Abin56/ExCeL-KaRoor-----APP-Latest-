import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/widgets/update_text_form_widget.dart';
import 'package:excel_karoor/view/home/teachers_home/widgets/teacher_edit_listile_widget.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/teacher_profile_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../widgets/fonts/google_poppins.dart';

class TeacherEditProfileScreen extends StatelessWidget {
  TeacherEditProfileScreen({super.key});
  final TeacherProfileController teacherProfileEditController =
      Get.put(TeacherProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.h),
                  bottomRight: Radius.circular(12.h),
                ),
                color: adminePrimayColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButtonBackWidget(
                        color: cWhite,
                      ),
                      kWidth50,
                      GooglePoppinsWidgets(
                        text: "Profile".tr,
                        fontsize: 22.h,
                        color: cWhite,
                      )
                    ],
                  ),
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                              child:
                                  CircleAvatharImageSelectionWidgetTeacher()),
                          kHeight20,
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 600.h,
              child: ListView(
                children: [
                  TeacherEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.teacherName ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController.textEditingController
                                .text = UserCredentialsController
                                    .teacherModel?.teacherName ??
                                "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              validator: checkFieldEmpty,
                              documentKey: "teacherName",
                              textInputType: TextInputType.text,
                              hint: 'Name',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TeacherEditListileWidget(
                    icon: Icons.call,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.teacherPhNo ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "Phone No.".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController.textEditingController
                                .text = UserCredentialsController
                                    .teacherModel?.teacherPhNo ??
                                "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              validator: checkFieldPhoneNumberIsValid,
                              documentKey: "teacherPhNo",
                              textInputType: TextInputType.phone,
                              hint: 'Phone No.',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TeacherEditListileWidgetEmail(
                    icon: Icons.email,
                    subtitle: GooglePoppinsWidgets(
                        text: UserCredentialsController
                                .teacherModel?.teacherEmail ??
                            "",
                        fontsize: 19.h),
                    title:
                        GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
                    editicon: Icons.edit,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('SchoolListCollection')
                        .doc(UserCredentialsController.schoolId)
                        .collection(UserCredentialsController.batchId!)
                        .doc(UserCredentialsController.batchId)
                        .collection('classes')
                        .doc(UserCredentialsController.classId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return TeacherEditListileWidget(
                          subtitle: Row(
                            children: [
                              GooglePoppinsWidgets(
                                  text:
                                      '${snapshot.data!.data()!['className']}',
                                  fontsize: 19.h),
                            ],
                          ),
                          icon: Icons.class_rounded,
                          title: Row(
                            children: [
                              GooglePoppinsWidgets(
                                  text: 'Class'.tr, fontsize: 12.h),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  TeacherEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.gender ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Gender".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController.textEditingController
                                .text = UserCredentialsController
                                    .teacherModel?.gender ??
                                "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              validator: checkFieldEmpty,
                              documentKey: "gender",
                              textInputType: TextInputType.text,
                              hint: 'gender',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  TeacherEditListileWidget(
                    icon: Icons.home,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.houseName ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "Address".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController.textEditingController
                                .text = UserCredentialsController
                                    .teacherModel?.houseName ??
                                "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              documentKey: "houseName",
                              validator: checkFieldEmpty,
                              textInputType: TextInputType.text,
                              hint: 'Address',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  TeacherEditListileWidget(
                    icon: Icons.place,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController
                                    .teacherModel?.district ??
                                "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: "District".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController.textEditingController
                                .text = UserCredentialsController
                                    .teacherModel?.district ??
                                "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              validator: checkFieldEmpty,
                              documentKey: "district",
                              textInputType: TextInputType.text,
                              hint: 'District',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  TeacherEditListileWidget(
                    icon: Icons.location_on,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text:
                                UserCredentialsController.teacherModel?.place ??
                                    "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Place".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            teacherProfileEditController
                                    .textEditingController.text =
                                UserCredentialsController.teacherModel?.place ??
                                    "";
                            await profileUpdate(
                              context: context,
                              textEditingController:
                                  teacherProfileEditController
                                      .textEditingController,
                              validator: checkFieldEmpty,
                              documentKey: "place",
                              textInputType: TextInputType.text,
                              hint: 'Place',
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getClassName(String classId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .get();
      return result.data()?["className"];
    } catch (e) {
      return " ";
    }
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
      builder: (context) => Form(
        key: teacherProfileEditController.formKey,
        child: updateTextFormField(
          validator: validator,
          context: context,
          hintText: hint,
          textEditingController: textEditingController,
          voidCallback: () async {
            if (teacherProfileEditController.formKey.currentState!.validate()) {
              await teacherProfileEditController.updateTeacherProfile(
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

// ignore: must_be_immutable
class TeacherEditListileWidgetEmail extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  // final _formKey = GlobalKey<FormState>();
  String newEmail = "";
  TeacherProfileController teacherProfileEditController =
      Get.put(TeacherProfileController());

  TeacherEditListileWidgetEmail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.editicon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: title,
      subtitle: subtitle,
      trailing: InkWell(
        child: Icon(editicon),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                title: Text("Do you want to change Email ID ?".tr),
                actions: [
                  TextButton(
                    child: Text("Cancel".tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Ok".tr),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController emailController =
                              TextEditingController();
                          final TextEditingController passwordController =
                              TextEditingController();
                          return Form(
                            key: teacherProfileEditController.formKey,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              title: Text("Update Mail".tr),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: checkFieldEmailIsValid,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        hintText: "Enter new email address".tr),
                                  ),
                                  TextFormField(
                                    validator: checkFieldEmpty,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        hintText: "Password".tr),
                                  ),
                                ],
                              ),
                              actions: [
                                Obx(
                                  () => teacherProfileEditController
                                          .isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : TextButton(
                                          child: Text("Update".tr),
                                          onPressed: () {
                                            if (teacherProfileEditController
                                                .formKey.currentState!
                                                .validate()) {
                                              teacherProfileEditController
                                                  .changeTeacherEmail(
                                                      emailController.text
                                                          .trim(),
                                                      context,
                                                      passwordController.text
                                                          .trim());
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CircleAvatharImageSelectionWidgetTeacher extends StatelessWidget {
  CircleAvatharImageSelectionWidgetTeacher({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: UserCredentialsController.teacherModel?.imageUrl ==
                      null ||
                  UserCredentialsController.teacherModel!.imageUrl!.isEmpty
              ? const NetworkImage(netWorkImagePathPerson)
              : NetworkImage(
                      UserCredentialsController.teacherModel?.imageUrl ?? " ")
                  as ImageProvider,
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  _getCameraAndGallery(context);
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    // backgroundColor: Color.fromARGB(255, 52, 50, 50),
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BottomProfilePhotoContainerWidget(
          getImageController: getImageController,
        );
      },
    ).then((value) {
      if (getImageController.pickedImage.value.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible:
              false, // Added to prevent dialog dismissal on tap outside
          builder: (context) {
            return Obx(
              () => Get.find<TeacherProfileController>().isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AlertDialog(
                      title: Text('Do you want to change profile picture?'.tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<TeacherProfileController>()
                                .updateTeacherProfilePicture();
                          },
                          child: Text('Update'.tr),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImageController.pickedImage.value = '';
                          },
                          child: Text('Cancel'.tr),
                        ),
                      ],
                    ),
            );
          },
        );
      }
    });
  }
}
