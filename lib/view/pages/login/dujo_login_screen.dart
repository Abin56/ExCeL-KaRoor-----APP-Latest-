import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/helper/shared_pref_helper.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/pages/login/widgets/login_screenDegin.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

import '../../../widgets/login_button.dart';
import '../search/search_school/search_school.dart';

class DujoLoginScren extends StatelessWidget {
  const DujoLoginScren({super.key});

  @override
  Widget build(BuildContext context) {
    log("");
    log(FirebaseAuth.instance.currentUser?.uid??"no user");
     log(UserCredentialsController.currentUSerID.toString());
          log(SharedPreferencesHelper.currenUserKey.toString());
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const LoginScreenDesign(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GoogleMonstserratWidgets(
                  text: 'Welcome To'.tr,
                  letterSpacing: 2,
                  fontsize: 25,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GoogleMonstserratWidgets(
                      text: companyName,
                      fontsize: 25,
                      color: const Color.fromARGB(255, 230, 18, 3),
                      fontWeight: FontWeight.bold,
                    ),
                    GoogleMonstserratWidgets(
                      text: nameInSmall,
                      fontsize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchSchoolScreen();
              },));
                   // Get.off(() => SearchSchoolScreen());
                  },
                  child: loginButtonWidget(
                    height: 60,
                    width: 180,
                    text: 'Login'.tr,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(text: "Developed by", fontsize: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/leptonlogo.png'))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GoogleMonstserratWidgets(
                              text: "Lepton Communications",
                              fontsize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
