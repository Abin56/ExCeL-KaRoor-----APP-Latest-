import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/utils/utils.dart';

import '../../../model/event_model/class_event_model.dart';
import '../../userCredentials/user_credentials.dart';

class StudentEventController extends GetxController {
  RxBool isLoading = RxBool(false);
  List<ClassEventModel> classEventsLists = [];
  Future<void> getClassEvents() async {
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> classEventsCollection =
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId ?? "")
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('ClassEvents')
              .get();

      classEventsLists = classEventsCollection.docs
          .map(
            (e) => ClassEventModel.fromMap(
              e.data(),
            ),
          )
          .toList();
      classEventsLists.sort(
        (a, b) {
          return b.eventDate.compareTo(a.eventDate);
        },
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Error");
    }
  }

  @override
  void onInit() async {
    await getClassEvents();
    super.onInit();
  }
}
