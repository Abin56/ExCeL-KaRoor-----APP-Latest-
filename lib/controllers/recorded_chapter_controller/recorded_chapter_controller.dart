import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';

class RecordedChapterController extends GetxController {
  TextEditingController chapterNumberController = TextEditingController();
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  updateChapterNumber(
      {required String subjectID, required String chapterID}) async {
    try {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .update({
        'chapterNumber': chapterNumberController.text,
      }).then((value) {
        log("chapter Number updated");
        chapterNumberController.clear();
      });
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }

  updateChapterName(
      {required String subjectID, required String chapterID}) async {
    try {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .update({
        'chapterName': chapterNameController.text,
      }).then((value) {
        log("chapter name updated");
        chapterNameController.clear();
      });
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }

  updateChapterTopic({
    required String subjectID,
    required String chapterID,
    required String docId,
  }) async {
    try {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .collection('RecordedClass')
          .doc(docId)
          .update({
        'topicName': topicController.text,
      }).then((value) {
        log("topic name updated");
        topicController.clear();
      });
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }

  deleteRecordedClassChapter({
    required String subjectID,
    required String chapterID,
  }) async {
    try {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .delete()
          .then((value) {
        log("recorded class chapter deleted");
      });
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }

  deleteRecordedClass({
    required String subjectID,
    required String chapterID,
    required String docId,
  }) async {
    try {
      await server
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(subjectID)
          .collection('recorded_classes_chapters')
          .doc(chapterID)
          .collection('RecordedClass')
          .doc(docId)
          .delete()
          .then((value) {
        log("recorded class deleted");
      });
    } catch (e) {
      showToast(msg: "Something Went Wrong");
    }
  }
}
