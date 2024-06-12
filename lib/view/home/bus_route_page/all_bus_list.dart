import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

import '../../../controllers/bus_list_controller/bus_controller.dart';
import 'bus_detail_show_page.dart';

class BusRouteListPage extends StatelessWidget {
  BusRouteListPage({super.key});
  final BusListController busListController = Get.put(BusListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
        //backgroundColor: adminePrimayColor,
        title: Text("Bus Route".tr),
      ),
      body: FutureBuilder(
          future: busListController.getAllBusList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return BusRouteDetailPageListileWidget(
                      title: Text(snapshot.data?[index].busNumber ?? ""),
                      title1: Text(
                          "Driver Mob :${snapshot.data?[index].driveMobNum ?? ""}"),
                      title2: Text(
                          "Assistant Mob :${snapshot.data?[index].assistantMobNum ?? ""}"),
                      leading: kHeight,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BusRouteDetailPage(
                            busRouteModel: snapshot.data![index],
                          );
                        }));
                      },
                    );
                  });
            } else {
              return kHeight;
            }
          }),
    );
  }
}
