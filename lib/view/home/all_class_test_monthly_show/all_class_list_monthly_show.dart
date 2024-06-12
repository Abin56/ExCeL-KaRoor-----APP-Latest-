import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../../../utils/utils.dart';
import '../../../controllers/all_class_test_show/all_class_test_monthly_show_controller.dart';
import '../../colors/colors.dart';
import 'all_class_data_monthly_show.dart';

class AllClassTestMonthlyPage extends StatelessWidget {
  AllClassTestMonthlyPage({super.key, required this.pageNameFrom});
  final AllClassListMonthlyShowController allClassListShowController =
      Get.put(AllClassListMonthlyShowController());

  final String pageNameFrom;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await allClassListShowController.fetchAllClassTest();
    });
    return Scaffold(
        appBar: AppBar(
          foregroundColor: cWhite,
          flexibleSpace: const AppBarColorWidget(),
          // backgroundColor: adminePrimayColor,
          title: Text("All Monthly Test".tr),
        ),
        body: Obx(
          () => allClassListShowController.isLoading.value
              ? circularProgressIndicatotWidget
              : ListView.builder(
                  itemCount: allClassListShowController.allClassTestList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: cgrey1,
                      child: ListTile(
                        leading: const Icon(Icons.notes),
                        title: Text(allClassListShowController
                            .allClassTestList[index].testName),
                        subtitle: Text(timeStampToDateFormat(
                            allClassListShowController
                                .allClassTestList[index].date)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                        onTap: () {
                          allClassListShowController.classTestModel =
                              allClassListShowController
                                  .allClassTestList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllClassTestMonthlyShowPage(
                                    navigationPageName: pageNameFrom,
                                  )));
                        },
                      ),
                    );
                  },
                ),
        ));
  }
}
