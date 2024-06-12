import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/events/event_display_school_level.dart';


class QuickActionsWidget extends StatelessWidget {
 final String text;
 final String image;
 final Function onTap;
   const QuickActionsWidget({
    required this.text,
    required this.image,
    required this.onTap,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          GestureDetector(
           onTap: onTap as void Function()? ,
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                image,
                scale: 2.5,
              ),
            ),
          ),
          GooglePoppinsEventsWidgets(text:text , fontsize: 12,)
        ],
      ),
    );
  }
}

List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];


