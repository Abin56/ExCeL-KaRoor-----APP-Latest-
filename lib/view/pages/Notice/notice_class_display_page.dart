import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:excel_karoor/model/notice_model/class_level_notice_model.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../widgets/fonts/google_poppins.dart';

class NoticeClassDisplayPage extends StatelessWidget {
  const NoticeClassDisplayPage({super.key, required this.classLevelNoticeModel});
  final ClassLevelNoticeModel classLevelNoticeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          // backgroundColor: adminePrimayColor,
          title: Text("Notices".tr),
        ),
        body: SizedBox(
          height: double.infinity, // set the height to fill available space
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight30,
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 17.h, right: 17.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            color: Colors.blue[50],
                          ),
                          height: 650.h,
                          width: 360.w,
                          child: Padding(
                            padding: EdgeInsets.all(13.h),
                            child: ListView(
                              children: [
                                Center(
                                  child: GooglePoppinsWidgets(
                                      text: classLevelNoticeModel.heading, fontsize: 22.h),
                                ),
                                kHeight50,
                                GooglePoppinsWidgets(
                                  text: "Topic :",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.topic,
                                  fontsize: 19.h,
                                ),
                                kHeight20,
                                GooglePoppinsWidgets(
                                  text: "Content :",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.content,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                  text: "Date : ",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.date,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                    text: "Signed by :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.signedBy,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                kHeight30,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
