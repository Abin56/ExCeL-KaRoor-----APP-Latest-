import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/home/student_home/student_pages/slider/graph_showing_std.dart';


class CarouselSliderStd extends StatelessWidget {
  const CarouselSliderStd({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
      GraphShowingPartStdAttendance(),
      GraphShowingPartStdExamResult(),
      GraphShowingPartStdHomework(),
      GraphShowingPartStdAssignProject()
    ],
     options: CarouselOptions(
        height: 200.w,
        enlargeCenterPage: true,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),);
  }
}



