import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/pages/chat/group_chats/parent_group/parent_groups.dart';
import 'package:excel_karoor/view/pages/chat/group_chats/student_group/student_groups.dart';

import '../../../../controllers/group_chat_controller/group_StudentsTeacher_chat_controller.dart';

class GroupChatScreenForTeachers extends StatelessWidget {
  final TeacherGroupChatController teacherGroupChatController =
      Get.put(TeacherGroupChatController());
  GroupChatScreenForTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('ChatGroups')
            .snapshots(),
        builder: (context, snaps) {
          if (snaps.hasData) {
            if (snaps.data!.docs.isEmpty) {
              return Center(
                child: TextButton.icon(
                    onPressed: () async {
                      teacherGroupChatController.createGroupChatForWho(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Create a group")),
              );
            } else {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
                      child: TabBar(
                        // splashBorderRadius: BorderRadius.circular(0),

                        // labelPadding:
                        //     EdgeInsetsDirectional.symmetric(horizontal: 80.w),
                        isScrollable: false,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: adminePrimayColor),
                        tabs: [
                          Tab(
                            text: 'Students'.tr,
                          ),
                          Tab(text: "Parents".tr)
                        ],
                      ),
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      StudentsGroupsMessagesScreen(),
                      ParentssGroupsMessagesScreen(),
                    ],
                  ),
                  floatingActionButton: StreamBuilder(
                      builder: (context, checkClassTeacher) {
                        if (checkClassTeacher.hasData) {
                          return FloatingActionButton(
                            child: const Icon(
                              Icons.add,
                            ),
                            onPressed: () async {
                              teacherGroupChatController
                                  .createGroupChatForWho(context);
                            },
                          );
                        } else {
                          return const Text('');
                        }
                      },
                      stream: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .snapshots()),
                  // builder: (context, checkClassTeacher) {

                  // }
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}

userIndexBecomeZero(String docid, String groupName,
    {required String teacherParameter}) async {
  log("message Caliingggggggggggggggggggggggggg");
  final firebase = await FirebaseFirestore.instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId!)
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('ChatGroups')
      .doc('ChatGroups')
      .collection(groupName)
      .doc(docid)
      .collection('Participants')
      .get();
  if (firebase.docs.isNotEmpty) {
    addteacherTopaticipance(docid, groupName,
        teacherParameter: teacherParameter);
    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection(groupName)
        .doc(docid)
        .collection('Participants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'messageIndex': 0}, SetOptions(merge: true));
  }
}
