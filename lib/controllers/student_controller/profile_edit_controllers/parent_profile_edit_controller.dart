import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/home/parent_home/parent_main_home_screen.dart';

import '../../../helper/shared_pref_helper.dart';
import '../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../model/parent_model/parent_model.dart';
import '../../../utils/utils.dart';
import '../../../view/pages/login/dujo_login_screen.dart';
import '../../userCredentials/user_credentials.dart';

class ParentProfileEditController {
  RxBool isLoading = RxBool(false);
  final formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  final DocumentReference<Map<String, dynamic>> parentDocumentCollection =
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('Parents')
          .doc(UserCredentialsController.parentModel?.docid);
  Future<void> changeParentEmail(
      String newEmail, BuildContext context, String password) async {
    final auth = FirebaseAuth.instance;
    String email = auth.currentUser?.email ?? "";

    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseAuth.instance.currentUser
            ?.verifyBeforeUpdateEmail(newEmail)
            .then((value) async {
          await parentDocumentCollection
              .update({'parentEmail': newEmail}).then((value) async {
            server
                .collection('AllParents')
                .doc(UserCredentialsController.parentModel?.docid)
                .update({'parentEmail': newEmail});
          });

          showToast(msg: 'Successfully Updated');

          await FirebaseAuth.instance.signOut().then((value) async {
            await SharedPreferencesHelper.clearSharedPreferenceData();
            UserCredentialsController.clearUserCredentials();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const DujoLoginScren();
              },
            ));
            // Get.offAll(() => const DujoLoginScren());
          });
        });
      });

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showToast(msg: e.code);
    }
  }

  Future<void> updateParentProfilePicture(context) async {
    try {
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        isLoading.value = true;

        String imageId =
            "${DateTime.now().millisecondsSinceEpoch.toString()}${UserCredentialsController.parentModel?.parentName}";

        if (UserCredentialsController.parentModel != null) {
          if (UserCredentialsController
                  .parentModel!.profileImageID?.isNotEmpty ??
              false) {
            imageId =
                UserCredentialsController.parentModel?.profileImageID ?? "";
          }
        }

        final result = await FirebaseStorage.instance
            .ref(
                "files/parentProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        final imageUrl = await result.ref.getDownloadURL();

        await parentDocumentCollection.update({
          "profileImageURL": imageUrl,
          "profileImageID": imageId,
        }).then((value) async {
          server
              .collection('AllParents')
              .doc(UserCredentialsController.parentModel?.docid)
              .update({
            "profileImageURL": imageUrl,
            "profileImageID": imageId,
          });
        });

        isLoading.value = false;

        Get.find<GetImage>().pickedImage.value = "";
        final DocumentSnapshot<Map<String, dynamic>> parentData =
            await parentDocumentCollection.get();

        if (parentData.data() != null) {
          UserCredentialsController.parentModel =
              ParentModel.fromMap(parentData.data()!);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const ParentMainHomeScreen();
            },
          ));
          // Get.offAll(const ParentMainHomeScreen());
        }
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }

  Future<void> updateParentProfile(
    context, {
    required String value,
    required String documentKey,
  }) async {
    try {
      isLoading.value = true;
      await parentDocumentCollection.update({
        documentKey: value,
      }).then((values) async {
        await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('AllParents')
            .doc(UserCredentialsController.parentModel?.docid)
            .update({
          documentKey: value,
        }).then((thvalue) async {
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('Parents')
              .doc(UserCredentialsController.parentModel?.docid)
              .update({
            documentKey: value,
          });
        }).then((value) async {
          final DocumentSnapshot<Map<String, dynamic>> parentData =
              await parentDocumentCollection.get();
          if (parentData.data() != null) {
            UserCredentialsController.parentModel =
                ParentModel.fromMap(parentData.data()!);
            Navigator.pop(context);
          }
          isLoading.value = false;
          textEditingController.clear();
          showToast(msg: "Successfully Updated");
        });
      });
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
      isLoading.value = false;
    }
  }
}
