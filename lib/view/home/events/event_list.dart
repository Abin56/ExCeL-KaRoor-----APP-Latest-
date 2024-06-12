import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/events/Tabs/school_level_tab.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

class EventList extends StatelessWidget {
  const EventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          title: Row(
            children: [
              // IconButtonBackWidget(),
              SizedBox(
                width: 20.w,
              ),
              Text("Events".tr),
            ],
          ),
          flexibleSpace: const AppBarColorWidget(),
          // backgroundColor: adminePrimayColor,
          // bottom: TabBar(tabs: [
          //   Tab(
          //     text: 'Class Level'.tr,
          //   ),
          //   Tab(
          //     text: 'School Level'.tr,
          //   )
          // ]),
        ),

        //  appBar: AppBar(backgroundColor: adminePrimayColor),
        body: SafeArea(
          child: TabBarView(
            children: [
              // const ClassLevelPage(),
              SchoolLevelPage(),
            ],
          ),
        ),
      ),
    );
  }
}
