// import 'dart:developer';

// import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
// import 'package:excel_karoor/view/colors/colors.dart';
// import 'package:excel_karoor/view/home/student_home/Student%20Edit%20Profile/teacher_edit_profile.dart';
// import 'package:excel_karoor/view/home/teachers_home/teacher_classes_list.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';

// class TeacherNewHomePage extends StatefulWidget {
//    static String routeName = '';
//   const TeacherNewHomePage({super.key});

//   @override
//   State<TeacherNewHomePage> createState() => _TeacherNewHomePageState();
// }
 
// class _TeacherNewHomePageState extends State<TeacherNewHomePage> {
//   String deviceToken = '';

//   void getDeviceToken() async {
//     await FirebaseMessaging.instance.getToken().then((token) {
//       setState(() {
//         deviceToken = token ?? 'Not get the token ';
//         log("User Device Token :: $token");
//       });
//       saveDeviceTokenToFireBase(deviceToken);
//     });
//   }

//   void saveDeviceTokenToFireBase(String deviceToken) async {
//     await FirebaseFirestore.instance
//         .collection("SchoolListCollection")
//         .doc(UserCredentialsController.schoolId)
//         .collection(UserCredentialsController.batchId!)
//         .doc(UserCredentialsController.batchId)
//         .collection('classes')
//         .doc(UserCredentialsController.classId)
//         .collection('teachers')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set({'deviceToken': deviceToken}, SetOptions(merge: true))
//         .then((value) => log('Device Token Saved To FIREBASE'))
//         .then((value) => FirebaseFirestore.instance
//                 .collection('PushNotificationToAll')
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .set({
//               'deviceToken': deviceToken,
//               'schoolID': UserCredentialsController.schoolId,
//               'batchID': UserCredentialsController.batchId,
//               'classID': UserCredentialsController.classId,
//               'personID': FirebaseAuth.instance.currentUser!.uid,
//               'role': 'Teacher'
//             }))
//         .then((value) => FirebaseFirestore.instance
//                 .collection('SchoolListCollection')
//                 .doc(UserCredentialsController.schoolId)
//                 .collection('PushNotificationList')
//                 .doc(FirebaseAuth.instance.currentUser!.uid)
//                 .set({
//               'deviceToken': deviceToken,
//               'batchID': UserCredentialsController.batchId,
//               'classID': UserCredentialsController.classId,
//               'personID': FirebaseAuth.instance.currentUser!.uid,
//               'role': 'Teacher'
//             }));
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getDeviceToken();

//     //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                      gradient: LinearGradient(colors: [
//                              Color.fromARGB(255, 27, 92, 176),
//                       Colors.blue,
//                           ]),
//                     // image: DecorationImage(
//                     //     fit: BoxFit.cover,
//                     //     image: AssetImage(
//                     //         "assets/flaticons/4884794.jpg")),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(25),
//                         bottomRight: Radius.circular(25))),
//                         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                           children: [  GoogleMonstserratWidgets(
//                               overflow: TextOverflow.ellipsis,
//                               text: UserCredentialsController
//                                       .teacherModel?.teacherName ??
//                                   "",
//                               fontsize: 23.sp,
//                               fontWeight: FontWeight.bold,
//                               color: cWhite,
//                             ),
//                  GoogleMonstserratWidgets(
//                       text:
//                           'Employee ID : ${UserCredentialsController.teacherModel?.employeeID ?? ""}',
//                       fontsize: 14.5.sp,
//                       fontWeight: FontWeight.w500,
//                       color: cWhite.withOpacity(0.8),
//                     ),
//                  GoogleMonstserratWidgets(
//                       text:
//                           'email : ${UserCredentialsController.teacherModel?.teacherEmail ?? ""}',
//                       fontsize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: cWhite.withOpacity(0.7),
//                     ),]),
//               ),
//               GestureDetector(
//                           onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (context)
//               {return TeacherEditProfileScreen();}));
                            
//                             // Get.to(() => const TeacherEditProfileScreen());
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 150,left: 150,bottom: 50),
//                             child: Container( 
//                               child: Column(
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundImage: NetworkImage(
//                                             UserCredentialsController
//                                                     .teacherModel?.imageUrl ??
//                                                 ""),
//                                         radius: 50,
//                                       ),
//                                       const Positioned(
//                                         right: 6,
//                                         bottom: 1,
//                                         child: Center(child: Icon(Icons.info)),
//                                       ),
//                                     ],
//                                   ),
                                 
//                                 ],
//                               ),
                              
//                             ),
//                           ),
//                         ),
//             ],
//           ),
          
          
//            TeacherClassListView(),
//         ],
//       ),
//     );
//   }
// }
// Widget MenuItem(int id, String image, String title, bool selected, onTap) {
//   return Material(
//     color: Colors.white,
//     child: InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 30,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(image))),
//               ),
//             ),
//             Expanded(
//                 flex: 3,
//                 child: Text(
//                   title,
//                   style: const TextStyle(color: Colors.black, fontSize: 16),
//                 ))
//           ],
//         ),
//       ),
//     ),
//   );
// }