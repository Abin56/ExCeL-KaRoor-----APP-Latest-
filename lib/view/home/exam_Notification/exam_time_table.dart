import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/exam_Notification/public_level.dart';
import 'package:excel_karoor/view/home/exam_Notification/state_Level.dart';

class ExmNotifications extends StatelessWidget {
  const ExmNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Exams'.tr),
          backgroundColor: adminePrimayColor,
          bottom: TabBar(tabs: [
            Tab(
              text: 'School Level'.tr,
            ),
            Tab(
              text: 'Public Level'.tr,
            )
          ]),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              PublicLevel(),
              StateLevel(),
            ],
          ),
        ),
      ),
    );
  }
}
