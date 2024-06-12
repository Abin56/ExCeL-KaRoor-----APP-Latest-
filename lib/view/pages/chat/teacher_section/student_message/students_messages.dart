import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

import '../search_students/search_students.dart';
import 'chats/students_chats.dart';

class StudentsMessagesScreen extends StatelessWidget {
  const StudentsMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> showsearch() async {
      await showSearch(context: context, delegate: SearchStudentsForChat());
    }

    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("StudentChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: size.height * 0.72,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70.h,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return StudentsChatsScreen(
                                    studentName: snapshots.data!.docs[index]
                                        ['studentname'],
                                    studentDocID: snapshots.data!.docs[index]
                                        ['docid'],
                                  );
                                },
                              ));
                              // Get.off(() => StudentsChatsScreen(
                              //       studentName: snapshots.data!.docs[index]
                              //           ['studentname'],
                              //       studentDocID: snapshots.data!.docs[index]
                              //           ['docid'],
                              //     ));
                            },
                            leading: const CircleAvatar(
                              radius: 30,
                            ),
                            title: Text(
                                snapshots.data!.docs[index]['studentname'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp)),
                            contentPadding: const EdgeInsetsDirectional.all(1),
                            subtitle: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection(
                                        UserCredentialsController.batchId!)
                                    .doc(UserCredentialsController.batchId!)
                                    .collection('classes')
                                    .doc(snapshots.data?.docs[index]['classID'])
                                    .get(),
                                builder: (context, futuredata) {
                                  if (futuredata.hasData) {
                                    return Row(
                                      children: [
                                        Text(
                                          'class : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp),
                                        ),
                                        Text(
                                          futuredata.data?.data()?['className'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center();
                                  }
                                }),
                            trailing: snapshots.data!.docs[index]
                                        ['messageindex'] ==
                                    0
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: const Color.fromARGB(
                                          255, 118, 229, 121),
                                      child: Text(
                                        snapshots
                                            .data!.docs[index]['messageindex']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: snapshots.data!.docs.length),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: GestureDetector(
                        onTap: () {
                          showsearch();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.sp)),
                              color: const Color.fromARGB(255, 232, 224, 224)),
                          height: 50.h,
                          width: 200.w,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.search),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.sp),
                                  child: GooglePoppinsWidgets(
                                    text: 'Search Student'.tr,
                                    fontsize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
