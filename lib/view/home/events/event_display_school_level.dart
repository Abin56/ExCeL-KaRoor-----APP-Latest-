import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';

class EventDisplaySchoolLevel extends StatelessWidget {
  const EventDisplaySchoolLevel({super.key, required this.eventData});
  final Map<String, dynamic> eventData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarColorWidget(),
          foregroundColor: cWhite,
          // backgroundColor: adminePrimayColor,
          title: Text("Events".tr),
        ),
        body: SizedBox(
          height: double.infinity, // set the height to fill available space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kHeight30,
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(17.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.h),
                          color: Colors.blue[50],
                        ),
                        height: 650.h,
                        width: 360.w,
                        child: Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GooglePoppinsEventsWidgets(
                                      text: eventData["eventName"],
                                      fontsize: 22.h),
                                  const Icon(Icons.event_note)
                                ],
                              ),
                              kHeight50,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: GooglePoppinsEventsWidgets(
                                      text:
                                          "Description : ${eventData["eventDescription"]}",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  )
                                ],
                              ),
                              kHeight20,
                              // GooglePoppinsEventsWidgets(
                              //     text:
                              //         "This is to inform all the students that  __________________  will be  conductod __________________  at __________________ with various cultural programmes.______________ will be grace the occasion. Student who would like to occasion in various programme should contact their\nrespective classteacher latest by __________________ .",
                              //     fontsize: 18.h),
                              // kHeight10,
                              Row(
                                children: [
                                  GooglePoppinsEventsWidgets(
                                      text: "Date : ${eventData["eventDate"]}",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  GooglePoppinsEventsWidgets(
                                      text: "Venue :${eventData["venue"]}",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight30,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GooglePoppinsEventsWidgets(
                                      text:
                                          "Signed by : ${eventData["signedBy"]}",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
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
        ));
  }
}

class GooglePoppinsEventsWidgets extends StatelessWidget {
 final String text;
 final double fontsize;
 final FontWeight? fontWeight;
 final Color? color;
 final VoidCallback? onTap;
  const GooglePoppinsEventsWidgets({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
