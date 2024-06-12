import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/pages/Notice/Tabs/school_level_tab.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../../controllers/student_controller/student_notice_controller/student_notice_controller.dart';
import '../../colors/colors.dart';

class NoticePage extends StatelessWidget {
  NoticePage({super.key});
  final StudentNoticeController studentNoticeController = Get.put(StudentNoticeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await studentNoticeController.getSchoolLevelNotices();
      await studentNoticeController.getClassLevelNotices();
    });
    return 
    // DefaultTabController(
    //   length: 2,
    //  child: 
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notices".tr),
            flexibleSpace: const AppBarColorWidget(),
            foregroundColor: cWhite,
            //  backgroundColor: adminePrimayColor,
            // bottom: TabBar(tabs: [
            //   Tab(
            //     text: 'Class Level'.tr,
            //   ),
            //   Tab(
            //     text: 'School Level'.tr,
            //   )
            // ]),
          ),
          body: studentNoticeController.isLoading.value
              ? circularProgressIndicatotWidget
              : SafeArea(
                  child:
                  //  TabBarView(
                  //   children: [
                     //
                     // ClassLevelNoticePage(),
                      SchoolLevelNoticePage(),
                  //   ],
                  // ),
                ),
        ),
      );
   // );
  }
}
