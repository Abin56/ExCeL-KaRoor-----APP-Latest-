import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/home/student_home/Student%20Edit%20Profile/widget/student_profile_edit_listtile.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/student_profile_edit_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../widgets/fonts/google_poppins.dart';

class StudentProfileEditPage extends StatefulWidget {
  const StudentProfileEditPage({super.key});

  @override
  State<StudentProfileEditPage> createState() => _StudentProfileEditPageState();
}

final StudentProfileEditController studentProfileEditController =
    Get.put(StudentProfileEditController());

class _StudentProfileEditPageState extends State<StudentProfileEditPage> {
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
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 350.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.h), bottomRight: Radius.circular(12.h)),
                color: adminePrimayColor,
                //const Color.fromARGB(255, 88, 167, 123),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButtonBackWidget(
                        color: cWhite,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GooglePoppinsWidgets(
                        text: "Profile".tr,
                        fontsize: 22.h,
                        color: cWhite,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: StudentCircleAvatarImgeWidget(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  GooglePoppinsWidgets(
                    text: "***",
                    fontsize: 18,
                    color: cWhite,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: GooglePoppinsWidgets(
                      text:
                          "   This photo and informations provided may\n be used for enteries in student Id card",
                      fontsize: 12,
                      fontWeight: FontWeight.w500,
                      color: cWhite,
                    ),
                  ),
                  GooglePoppinsWidgets(
                    text: "***",
                    fontsize: 18,
                    color: cWhite,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 520.h,
              child: ListView(
                children: [
                  StudentEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.studentName ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.studentName ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'Name',
                              updateValue: 'studentName',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.call,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.parentPhoneNumber ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Phone No.".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.parentPhoneNumber ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'Phone Number',
                              updateValue: 'parentPhoneNumber',
                              validator: checkFieldPhoneNumberIsValid,
                              textInputType: TextInputType.number,
                            );

                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StudentEditListileWidgetEmail(
                    icon: Icons.email,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                            text: UserCredentialsController.studentModel?.studentemail ?? "",
                            fontsize: 19.h),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
                      ],
                    ),
                    editicon: Icons.edit,
                  ),
                  StudentEditListileWidget(
                    icon: Icons.class_rounded,
                    subtitle: Row(
                      children: [
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
                              return GooglePoppinsWidgets(
                                  text: snapshot.data!.data()!['className'], fontsize: 19.h);
                            } else {
                              return const Text('');
                            }
                          },
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Class".tr, fontsize: 12.h),
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.bloodtype_outlined,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.bloodgroup ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Blood Group".tr, fontsize: 12.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.bloodgroup ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'Blood Group',
                              updateValue: 'bloodgroup',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.home,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.houseName ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Address".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.houseName ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'Address',
                              updateValue: 'houseName',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.place,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.place ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Place".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.place ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'place',
                              updateValue: 'place',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.person,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.gender ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Gender".tr, fontsize: 13.h),
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
                            studentProfileEditController.editvalueController.text = newValue ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'Gender',
                              updateValue: 'gender',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          items: <String>[
                            'Male',
                            'Female',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        // IconButton(
                        //   onPressed: () async {
                        //     studentProfileEditController.editvalueController
                        //         .text = UserCredentialsController
                        //             .studentModel?.gender ??
                        //         "";
                        //     await changeStudentData(
                        //       context: context,
                        //       hintText: 'Gender',
                        //       updateValue: 'gender',
                        //       validator: checkFieldEmpty,
                        //     );
                        //     setState(() {});
                        //   },
                        //   icon: const Icon(
                        //     Icons.edit,
                        //     color: Colors.green,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.calendar_month,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.dateofBirth ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(text: "Dob".tr, fontsize: 13.h),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.dateofBirth ?? "";
                            await changeStudentData(
                                onTapFunction: () async {
                                  studentProfileEditController.editvalueController.text =
                                      await dateTimePicker(context);
                                },
                                context: context,
                                textInputType: TextInputType.none,
                                validator: checkFieldEmpty,
                                hintText: 'DOB',
                                updateValue: 'dateofBirth');
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.place,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.district ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: "District".tr,
                          fontsize: 13.h,
                        ),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.district ?? "";
                            await changeStudentData(
                              context: context,
                              hintText: 'District',
                              updateValue: 'district',
                              validator: checkFieldEmpty,
                            );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                  StudentEditListileWidget(
                    icon: Icons.phone,
                    subtitle: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: UserCredentialsController.studentModel?.alPhoneNumber ?? "",
                          fontsize: 19.h,
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        GooglePoppinsWidgets(
                          text: "Alternate phone number".tr,
                          fontsize: 13.h,
                        ),
                        IconButton(
                          onPressed: () async {
                            studentProfileEditController.editvalueController.text =
                                UserCredentialsController.studentModel?.alPhoneNumber ?? "";
                            await changeStudentData(
                              context: context,
                              validator: checkFieldPhoneNumberIsValid,
                              hintText: 'Alternate PhoneNumber',
                              updateValue: 'alPhoneNumber',
                              textInputType: TextInputType.number,
                            );
                            setState(() {});
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

class StudentCircleAvatarImgeWidget extends StatelessWidget {
  StudentCircleAvatarImgeWidget({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: UserCredentialsController.studentModel?.profileImageUrl == null ||
                  UserCredentialsController.studentModel!.profileImageUrl.isEmpty
              ? const NetworkImage(netWorkImagePathPerson)
              : NetworkImage(UserCredentialsController.studentModel?.profileImageUrl ?? " ")
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
                    backgroundColor: cWhite,
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(getImageController: getImageController);
        }).then(
      (value) {
        if (getImageController.pickedImage.value.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Obx(
                () => Get.find<StudentProfileEditController>().isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : AlertDialog(
                        title: Text('Do you want to change profile picture'.tr),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.find<StudentProfileEditController>()
                                    .updateStudentProfilePicture();
                              },
                              child: Text('Update'.tr)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              getImageController.pickedImage.value = "";
                            },
                            child: Text('Cancel'.tr),
                          ),
                        ],
                      ),
              );
            },
          );
        }
      },
    );
  }
}

changeStudentData({
  required BuildContext context,
  required String hintText,
  required String updateValue,
  TextInputType? textInputType,
  void Function()? onTapFunction,
  String? Function(String?)? validator,
}) {
  // final formkey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Form(
        key: studentProfileEditController.formKey,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: Text('Edit $hintText'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onTap: onTapFunction,
                  validator: validator,
                  controller: studentProfileEditController.editvalueController,
                  decoration: InputDecoration(hintText: "Enter your $hintText"),
                  keyboardType: textInputType,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                if (studentProfileEditController.formKey.currentState!.validate()) {
                  await studentProfileEditController.updateprofile(context,
                      updateValue: updateValue,
                      valuee: studentProfileEditController.editvalueController.text.trim());
                } else {
                  showToast(msg: "Something went wrong");
                  return;
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
