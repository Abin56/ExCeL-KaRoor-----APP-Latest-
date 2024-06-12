import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatGPTController extends GetxController {
  RxString apikey = ''.obs;
  Future<String> getAPIKEY() async {
    final firebase = await FirebaseFirestore.instance
        .collection("Lepton_AIBOT")
        .doc("apikey")
        .get();
    apikey.value = await firebase.data()!['key'];
    log("KEY ++++++     ${apikey.value}");
    return apikey.value;
  }

  @override
  void onInit() async {
    await getAPIKEY();
    super.onInit();
  }
}
