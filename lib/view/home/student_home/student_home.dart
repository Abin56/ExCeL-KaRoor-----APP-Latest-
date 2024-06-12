// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
// import 'package:excel_karoor/view/colors/colors.dart';
// import 'package:excel_karoor/view/home/student_home/student_acc/student_accessories.dart';
// import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
// import 'package:get/get.dart';
// import 'package:upgrader/upgrader.dart';
// import 'package:excel_karoor/view/widgets/icon/icon_widget.dart';

// import 'Student Edit Profile/student_edit_profile_page.dart';

// class StudentHomeScreen extends StatefulWidget {
//   static String routeName = '';

//   const StudentHomeScreen({super.key});

//   @override
//   State<StudentHomeScreen> createState() => _StudentHomeScreenState();
// }

// class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
//         .collection('AllStudents')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set({'deviceToken': deviceToken}, SetOptions(merge: true)).then(
//             (value) => log('Device Token Saved To FIREBASE'));

//     await FirebaseFirestore.instance
//         .collection("SchoolListCollection")
//         .doc(UserCredentialsController.schoolId)
//         .collection(UserCredentialsController.batchId ?? "")
//         .doc(UserCredentialsController.batchId)
//         .collection('classes')
//         .doc(UserCredentialsController.classId)
//         .collection("Students")
//         .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
//         .set({'deviceToken': deviceToken}, SetOptions(merge: true)).then(
//             (value) => log('Device Token Saved To FIREBASE'));

//     //AAAAT5j1j9A:APA91bEDY97KTVTB5CH_4YTnLZEol4Z5fxF0fmO654V7YJO6dL9TV_PyIfv64-pVDx477rONsIl8d63VjxT793_Tj4zuGg32JTy_wUNQ4OhGNbr0KOS2i4z7JaG-ZtENTBpYnEGh-ZLg  apikey
//   }

//   @override
//   void initState() {
//     super.initState();
//     getDeviceToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: UpgradeAlert(
//         upgrader: Upgrader(
//           // shouldPopScope: () => true,
//           // canDismissDialog: true,
//           durationUntilAlertAgain: const Duration(hours: 1),
//           // dialogStyle: Platform.isIOS
//           //     ? UpgradeDialogStyle.cupertino
//           //     : UpgradeDialogStyle.material,
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 color: cgraident,
//                 width: double.infinity,
//                 height: screenSize.width * 0.5,
//                 padding: EdgeInsets.all(15.h),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: screenSize.width / 2,
//                             child: GoogleMonstserratWidgets(
//                               overflow: TextOverflow.ellipsis,
//                               text: UserCredentialsController
//                                   .studentModel!.studentName,
//                               fontsize: 23.sp,
//                               fontWeight: FontWeight.bold,
//                               color: cWhite,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Get.to(() => const StudentProfileEditPage());
//                             },
//                             child: Stack(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       UserCredentialsController
//                                           .studentModel!.profileImageUrl),
//                                   onBackgroundImageError:
//                                       (exception, stackTrace) {
//                                     log(exception.toString());
//                                   },
//                                   radius: 50,
//                                 ),
//                                 const Positioned(
//                                   right: 6,
//                                   bottom: 1,
//                                   child: CircleAvatar(
//                                     backgroundColor: cWhite,
//                                     radius: 12,
//                                     child: Center(child: Icon(Icons.info)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     FutureBuilder(
//                         future: FirebaseFirestore.instance
//                             .collection('SchoolListCollection')
//                             .doc(UserCredentialsController.schoolId)
//                             .collection(UserCredentialsController.batchId!)
//                             .doc(UserCredentialsController.batchId)
//                             .collection('classes')
//                             .doc(UserCredentialsController.classId)
//                             .get(),
//                         builder: (context, snaps) {
//                           if (snaps.hasData) {
//                             return GoogleMonstserratWidgets(
//                               text:
//                                   'Class : ${snaps.data!.data()!['className']}',
//                               fontsize: 13.sp,
//                               fontWeight: FontWeight.w500,
//                               color: cWhite.withOpacity(0.8),
//                             );
//                           } else {
//                             return const Text('');
//                           }
//                         }),
//                     GoogleMonstserratWidgets(
//                       text:
//                           'Ad No : ${UserCredentialsController.studentModel?.admissionNumber}',
//                       fontsize: 13.sp,
//                       fontWeight: FontWeight.w500,
//                       color: cWhite.withOpacity(0.8),
//                     ),
//                     GoogleMonstserratWidgets(
//                       text:
//                           'email : ${UserCredentialsController.studentModel?.studentemail}',
//                       fontsize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: cWhite.withOpacity(0.7),
//                     ),
//                   ],
//                 ),
//               ),
//               const StudentAccessories(),
//             ],
//           ),
//         ),
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


