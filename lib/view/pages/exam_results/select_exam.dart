import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/exam_results/examListview.dart';
import 'package:excel_karoor/view/pages/exam_results/upload_exam_screen.dart';

import '../../widgets/fonts/google_monstre.dart';

class SelectExamLevelScreen extends StatelessWidget {
  final String classId;
  const SelectExamLevelScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GoogleMonstserratWidgets(
            text: 'Exam Results Upload'.tr,
            fontsize: 15.w,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: adminePrimayColor),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: adminePrimayColor,
                    ),
                    child: TextButton.icon(
                      onPressed: () async {
                        // return getBottomSheet(classId, 'School Level', context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ExamResultsView(
                            classID: classId,
                            // examlevel: 'School Level',
                          );
                        }));
                      },
                      icon: const Icon(Icons.list_alt, color: cWhite),
                      label: GoogleMonstserratWidgets(
                        text: 'Upload'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  kHeight30,
                  Container(
                    height: 80.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: adminePrimayColor,
                    ),
                    child: TextButton.icon(
                      onPressed: () async {
                        // return getBottomSheet(classId, 'Public Level', context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SelectExamWiseScreen(
                            classID: classId,
                            examLevel: 'Public Level',
                          );
                        }));
                      },
                      icon: const Icon(Icons.list_alt, color: cWhite),
                      label: GoogleMonstserratWidgets(
                        text: 'View'.tr,
                        fontsize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: cWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

getBottomSheet(String classId, String examlevel, BuildContext context) {
  Get.bottomSheet(
      SizedBox(
        height: 250.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamResultsView(
                    classID: classId,
                    // examlevel: examlevel,
                  );
                }));

                // Get.to(() => ExamResultsView(
                //       classID: classId,
                //       examlevel: examlevel,
                //     ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: adminePrimayColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                height: 65.h,
                width: 150.w,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      Icon(Icons.upload_sharp, color: cWhite, size: 20.w),
                      SizedBox(
                        width: 2.w,
                      ),
                      GoogleMonstserratWidgets(
                        text: 'Upload'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelectExamWiseScreen(
                    classID: classId,
                    examLevel: examlevel,
                  );
                }));

                // Get.to(() => SelectExamWiseScreen(
                //       classID: classId,
                //       examLevel: examlevel,
                //     ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: adminePrimayColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                height: 65.h,
                width: 150.w,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.view_headline_sharp,
                          color: cWhite, size: 20.w),
                      SizedBox(
                        width: 2.w,
                      ),
                      GoogleMonstserratWidgets(
                        text: 'View'.tr,
                        fontsize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: cWhite,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: cWhite);
}
