// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';

import '../../../../../controllers/student_controller/profile_edit_controllers/student_profile_edit_controller.dart';

class StudentEditListileWidgetEmail extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  // final _formKey = GlobalKey<FormState>();
  String newEmail = "";
  StudentProfileEditController studentProfileEditContrller =
      Get.put(StudentProfileEditController());

  StudentEditListileWidgetEmail({
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
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                          final TextEditingController emailController = TextEditingController();
                          final TextEditingController passwordController = TextEditingController();
                          return Form(
                            key: studentProfileEditContrller.formKey,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                              title: Text("Update Mail".tr),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: checkFieldEmailIsValid,
                                    controller: emailController,
                                    decoration:
                                        InputDecoration(hintText: "Enter new email address".tr),
                                  ),
                                  TextFormField(
                                    validator: checkFieldEmpty,
                                    controller: passwordController,
                                    decoration: InputDecoration(hintText: "Password".tr),
                                  ),
                                ],
                              ),
                              actions: [
                                Obx(() => studentProfileEditContrller.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : TextButton(
                                        child: Text("Update".tr),
                                        onPressed: () {
                                          if (studentProfileEditContrller.formKey.currentState!
                                              .validate()) {
                                            studentProfileEditContrller.changeStudentEmail(
                                                emailController.text.trim(),
                                                context,
                                                passwordController.text.trim());
                                          }
                                        },
                                      )),
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

class StudentEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;

  const StudentEditListileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: title,
      subtitle: subtitle,
    );
  }
}
