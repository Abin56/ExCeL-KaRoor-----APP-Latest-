
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/widgets/fonts/google_salsa.dart';

class GraphDetailsWidgetOfStd extends StatelessWidget {
  final String text;
  final String number;
  final String image;
  const GraphDetailsWidgetOfStd({
    required this.text,
    required this.number,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,height: 60.h,
      decoration:  const BoxDecoration(color: cWhite,
        borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow: [BoxShadow(blurRadius: 2)]),
                         child:   Padding(
    padding: const EdgeInsets.all(4.0),
    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Image.asset(image,height: 30,),
        ),
        Column(children: [
        GoogleSalsaWidgets(text: text, fontsize: 15,),
         GoogleSalsaWidgets(text: number, fontsize: 15,),
         ],),
      ],
    ),
                            ),
                            );
  }
}