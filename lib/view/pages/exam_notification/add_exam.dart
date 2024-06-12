import 'package:flutter/material.dart';
import 'package:excel_karoor/view/pages/exam_notification/view_exams.dart';

class ExamNotification extends StatelessWidget {
  const ExamNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ViewExamsScreen();
                },));
              //  Get.off(() => const ViewExamsScreen());
              },
              child: const Text('View'))
        ],
      ),
    );
  }
}
