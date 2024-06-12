// import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
// import 'package:excel_karoor/view/constant/sizes/sizes.dart';

// import '../../view/colors/colors.dart';
// import '../../view/widgets/fonts/google_poppins.dart';
// import '../Subject 2/subject_chapterwise_display.dart';

// class StudyMaterials extends StatelessWidget {
//   const StudyMaterials({super.key, required this.subjectID, required this.chapterID});

//  final String subjectID;
//  final String chapterID;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.white70,
//             appBar: AppBar(
//               title: Row(
//                 children: [
//                   Text("Study Materials".tr),
//                 ],
//               ),
//               backgroundColor: adminePrimayColor,
//             ),
//             body: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('SchoolListCollection')
//                     .doc(UserCredentialsController.schoolId)
//                     .collection(UserCredentialsController.batchId!)
//                     .doc(UserCredentialsController.batchId)
//                     .collection('classes')
//                     .doc(UserCredentialsController.classId)
//                     .collection('subjects')
//                     .doc(subjectID)
//                     .collection('Chapters')
//                     .doc(chapterID)
//                     .collection('StudyMaterials')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   return ListView.separated(
//                       itemCount: snapshot.data!.docs.length,
//                       separatorBuilder: ((context, index) {
//                         return kHeight10;
//                       }),
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListileCardChapterWidget(
//                           leading: const Image(
//                               image: NetworkImage(
//                                   "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 5.h),
//                                 child: GooglePoppinsWidgets(
//                                   fontsize: 15.h,
//                                   text: 'Chapter 3',
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 5.h),
//                                 child: GooglePoppinsWidgets(
//                                     fontsize: 15.h,
//                                     text: 'Topic',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 5.h),
//                                 child: GooglePoppinsWidgets(
//                                     fontsize: 14.h,
//                                     text: 'Pdf',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               kHeight10,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   GooglePoppinsWidgets(
//                                       text: "Posted By :", fontsize: 15.h),
//                                   GooglePoppinsWidgets(
//                                     text: "Anupama",
//                                     fontsize: 15.h,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           title: Padding(
//                             padding: EdgeInsets.only(top: 10.h),
//                             child: GooglePoppinsWidgets(
//                               fontsize: 20.h,
//                               text: snapshot.data!.docs[index]['chapterName'],
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           trailing: InkWell(
//                             child: GooglePoppinsWidgets(
//                                 text: "View".tr,
//                                 fontsize: 16.h,
//                                 fontWeight: FontWeight.w500,
//                                 color: adminePrimayColor),
//                             onTap: () {},
//                           ),
//                         );
//                       });
//                 })));
//   }
// }
