import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/fonts/text_widget.dart';
import 'package:excel_karoor/view/pages/Subject/student/chapter_display.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/widgets/loading_widget/loading_widget.dart';

import '../../colors/colors.dart';
import '../../constant/sizes/sizes.dart';

class StudentSubjectScreen extends StatelessWidget {
  const StudentSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Text(
            "Subjects".tr,
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
                    .collection('subjects')
                    .snapshots(),
                builder: (context, subjectsnaps) {
                  if (subjectsnaps.hasData) {
                    return ListView.separated(
                      itemCount: subjectsnaps.data!.docs.length,
                      separatorBuilder: ((context, index) {
                        return kHeight10;
                      }),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                 Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ChapterDisplay(subjectID: subjectsnaps.data?.docs[index]['docid']),
                            ));
                                },
                                child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: cblack.withOpacity(0.2))),
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10,right: 05),
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: const AssetImage(
                                                        'assets/flaticons/icons8-books-48.png'),
                                                    onBackgroundImageError:
                                                        (exception, stackTrace) {},
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10.h),
                                                  child: TextFontWidget(
                                                    text: subjectsnaps
                                                                .data?.docs[index]
                                                                .data()[
                                                            'subjectName'] ??
                                                        '',
                                                    fontsize: 21.h,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                                      .collection('classes')
                                                      .doc(
                                                          UserCredentialsController
                                                              .classId)
                                                      .collection('subjects')
                                                      .doc(subjectsnaps
                                                          .data!.docs[index]
                                                          .data()['docid'])
                                                      .collection('teachers')
                                                      .snapshots(),
                                                  builder:
                                                      (context, teachersnaps) {
                                                    return teachersnaps.hasData
                                                        ? Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 10,left: 05),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 60,
                                                                  child: TextFontWidget(text: 
                                                                  "Teachers :", fontsize: 12),
                                                                ),
                                                                Expanded(
                                                                  child: SizedBox(
                                                                    height: 20,
                                                                    child: Center(
                                                                      child: ListView
                                                                          .separated(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          final subjectdatas = teachersnaps
                                                                              .data!
                                                                              .docs[index]['teacherName'];
                                                                          return TextFontWidget(
                                                                            text:
                                                                                "$subjectdatas ,",
                                                                            fontsize:
                                                                                14.h,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                adminePrimayColor,
                                                                          );
                                                                        },
                                                                        separatorBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return const SizedBox(
                                                                            width:
                                                                                05,
                                                                          );
                                                                        },
                                                                        itemCount: teachersnaps
                                                                            .data!
                                                                            .docs
                                                                            .length,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                        : const SizedBox();
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
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
