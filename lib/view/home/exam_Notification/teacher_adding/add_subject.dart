import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/home/exam_Notification/list_of_exam/list_of_exam.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../../widgets/fonts/google_poppins.dart';
import '../exam_time_table.dart';

class AddTimeTable extends StatelessWidget {
  const AddTimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        // backgroundColor: adminePrimayColor,
        title: Text('Exam Time Table'.tr),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)
              {return const ViewSchoolExamScreen();}));


                // Get.to(()=>const ViewSchoolExamScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    ),
                child: SizedBox(
                    height: 80.h,
                    width: 250.w,
                    child: Center(
                      child: GooglePoppinsWidgets(
                        text: 'Upload Time Table'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                      ),
                    )),
              ),
            ),
            kHeight30,
            GestureDetector(
              onTap: () {
                
                 Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return const ExmNotifications();
                }));
                // Get.to(() => const ExmNotifications());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: adminePrimayColor),
                child: SizedBox(
                    height: 80.h,
                    width: 250.w,
                    child: Center(
                      child: GooglePoppinsWidgets(
                        text: 'View Time Table'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                      ),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
