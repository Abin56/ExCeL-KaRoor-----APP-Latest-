import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/home/exam_Notification/teacher_adding/add_subject.dart';
import 'package:excel_karoor/view/home/student_home/time_table/ss.dart';
import 'package:excel_karoor/view/pages/chat/teacher_section/teacher_chat-screen.dart';
import 'package:excel_karoor/view/pages/studentAttendence/select_period.dart';

class QuickActionsWidgetAttendence extends StatelessWidget {
  const QuickActionsWidgetAttendence({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){return  SelectPeriodWiseScreen(
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!);}));},
            child: Container(
              
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/roll-call.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Attendence",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
class QuickActionWidgetExam extends StatelessWidget {
  const QuickActionWidgetExam({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){return  const AddTimeTable() ;}));},
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/icons8-grades-100.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Exam",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
class QuickActionWidgetChat extends StatelessWidget {
  const QuickActionWidgetChat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          InkWell(
             onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){return  const TeacherChatScreen() ;}));},
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/icons8-chat-100.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Chat",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
class QuickActionWidgetTimetable extends StatelessWidget {
  const QuickActionWidgetTimetable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      width: 86.w,
      child: Column(
        children: [
          InkWell(
             onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){return  const TimeTable() ;}));},
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                  color: cWhite,
                  border: Border.all(color: cblack.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                'assets/flaticons/worksheet.png',
                scale: 2.5,
              ),
            ),
          ),
          Text(
            "Time Table",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}


List<String> quicktext = ['Attendence', 'Home work', 'Exam', 'Chat'];
