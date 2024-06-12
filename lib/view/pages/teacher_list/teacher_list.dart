import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/fonts/text_widget.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/widgets/loading_widget/loading_widget.dart';

import '../../colors/colors.dart';
import '../../constant/sizes/sizes.dart';

class TeacherSubjectWiseList extends StatelessWidget {
  final String navValue;
  const TeacherSubjectWiseList({required this.navValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Teachers".tr,
          ),
          flexibleSpace: const AppBarColorWidget(),
          //  backgroundColor: adminePrimayColor,
        ),
        body: Column(
          children: [
            kHeight10,
            Expanded(
              child: StreamBuilder(
                stream: server
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection('classes')
                    .doc(UserCredentialsController.classId)
                    .collection('teachers')
                    .snapshots(),
                builder: (context, classsnaps) {
                  if (classsnaps.hasData) {
                    return ListView.separated(
                      itemCount: classsnaps.data!.docs.length,
                      separatorBuilder: ((context, index) {
                        return kHeight10;
                      }),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                  decoration: const BoxDecoration(),
                                  child: StreamBuilder(
                                      stream: server
                                          .collection('Teachers')
                                          .doc(classsnaps.data!.docs[index]
                                              .data()['teacherId'])
                                          .snapshots(),
                                      builder: (context, teachersnaps) {
                                        if (teachersnaps.hasData) {
                                          final Map<String, dynamic>? data =
                                              teachersnaps.data!.data();
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: cblack
                                                        .withOpacity(0.2))),
                                            height: 150,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: data![
                                                                    'imageUrl'] ==
                                                                ''
                                                            ? const NetworkImage(
                                                                'https://firebasestorage.googleapis.com/v0/b/vidya-veechi-8-feb-2024.appspot.com/o/important***%2Fteacher-avathar2.png?alt=media&token=3db0d66c-225d-429b-a34e-f71b6b7dde7d')
                                                            : NetworkImage(
                                                                data[
                                                                    'imageUrl'],
                                                              ),
                                                        onBackgroundImageError:
                                                            (exception,
                                                                stackTrace) {},
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.h),
                                                        child: TextFontWidget(
                                                          text: data[
                                                                  'teacherName'] ??
                                                              '',
                                                          fontsize: 21.h,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.h),
                                                        child: TextFontWidget(
                                                          text:
                                                              '✉️  Email :  ${data['teacherEmail'] ?? ''}',
                                                          fontsize: 14.h,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.h),
                                                        child: TextFontWidget(
                                                          text:
                                                              '📞  PhoneNo  :  ${data['teacherPhNo'] ?? ''}',
                                                          fontsize: 14.h,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    StreamBuilder(
                                                        stream: server
                                                            .collection(
                                                                UserCredentialsController
                                                                    .batchId!)
                                                            .doc(
                                                                UserCredentialsController
                                                                    .batchId)
                                                            .collection(
                                                                'classes')
                                                            .doc(
                                                                UserCredentialsController
                                                                    .classId)
                                                            .collection(
                                                                'teachers')
                                                            .doc(classsnaps
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'teacherId'])
                                                            .collection(
                                                                'teacherSubject')
                                                            .snapshots(),
                                                        builder: (context,
                                                            subjectsnaps) {
                                                          return subjectsnaps
                                                                  .hasData
                                                              ? Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            40,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              ListView.separated(
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              final subjectdata = subjectsnaps.data!.docs[index]['subjectName'];
                                                                              return TextFontWidget(
                                                                                text: "$subjectdata ,",
                                                                                fontsize: 14.h,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: adminePrimayColor,
                                                                              );
                                                                            },
                                                                            separatorBuilder:
                                                                                (context, index) {
                                                                              return const SizedBox(
                                                                                width: 05,
                                                                              );
                                                                            },
                                                                            itemCount:
                                                                                subjectsnaps.data!.docs.length,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox();
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      })),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const LoadingWidget();
                  }
                },
              ),
            ),
          ],
        ));
  }
}
