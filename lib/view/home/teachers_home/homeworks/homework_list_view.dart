import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/home/teachers_home/homeworks/view_students_list.dart';
import 'package:excel_karoor/view/widgets/appbar_color/appbar_clr.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class HomeworksListView extends StatelessWidget {
  const HomeworksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          children: [
            kHeight20,
            GooglePoppinsWidgets(text: "HomeWorks".tr, fontsize: 20.h)
          ],
        ),
        flexibleSpace: const AppBarColorWidget(),
        foregroundColor: cWhite,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection("classes")
              .doc(UserCredentialsController.classId)
              .collection("HomeWorks")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => kHeight10,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data!.docs[index];
                final uploadDate = data['uploadDate'];
                final endDate = data['endDate'];
                DateTime parseUploadDate =
                    DateTime.parse(uploadDate.toString());
                DateTime parseEndDate = DateTime.parse(endDate.toString());
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                String formatted = formatter.format(parseUploadDate);
                String formattedEndDAte = formatter.format(parseEndDate);
                Duration difference = parseEndDate.difference(DateTime.now());
                int differenceInDays = difference.inDays;
                int differenceInHours = difference.inHours % 24;
                int differenceInMinutes = difference.inMinutes % 60;
                String timeLeft = '';
                if (differenceInDays > 0) {
                  timeLeft += '$differenceInDays days ';
                }
                if (differenceInHours > 0) {
                  timeLeft += '$differenceInHours hours ';
                }
                if (differenceInMinutes > 0) {
                  timeLeft += '$differenceInMinutes minutes';
                }

                return Padding(
                  padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 15.h),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewStudentsList(
                          homeworkID: data['docid'],
                          homeWorkName: data['tasks'],
                        ),
                      ),
                    ),
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(235, 226, 240, 249),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.h,
                                  right: 15.h,
                                  top: 15.h,
                                  bottom: 15.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.paste_sharp),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StreamBuilder(
                                        stream: server
                                            .collection(
                                                UserCredentialsController
                                                    .batchId!)
                                            .doc(UserCredentialsController
                                                .batchId)
                                            .collection("classes")
                                            .doc(UserCredentialsController
                                                .classId)
                                            .collection("subjects")
                                            .doc(data['subjectid'])
                                            .snapshots(),
                                        builder: (context, snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (!snap.hasData) {
                                            return const Center(
                                                child:
                                                    Text('No data available'));
                                          }
                                          return GooglePoppinsWidgets(
                                            text: snap.data!['subjectName'],
                                            fontsize: 17.h,
                                            fontWeight: FontWeight.w700,
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          children: [
                                            GooglePoppinsWidgets(
                                              text: "Task : ",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          const BeveledRectangleBorder(),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text('Task'),
                                                          IconButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            icon: const Icon(
                                                                Icons.close),
                                                          )
                                                        ],
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text(
                                                              data['tasks'] !=
                                                                      ""
                                                                  ? data[
                                                                      'tasks']
                                                                  : "nothing to view",
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: GooglePoppinsWidgets(
                                                text: "View",
                                                fontsize: 16.h,
                                                color: adminePrimayColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: GooglePoppinsWidgets(
                                          text: "Date : $formatted",
                                          fontsize: 15.h,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          children: [
                                            GooglePoppinsWidgets(
                                              text: "From : $formatted",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            const SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: VerticalDivider(
                                                color: cgrey,
                                              ),
                                            ),
                                            GooglePoppinsWidgets(
                                              text: "To : $formattedEndDAte",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(235, 226, 228, 229),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  GooglePoppinsWidgets(
                                    text: "Time left : ",
                                    fontsize: 15.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  GooglePoppinsWidgets(
                                    text: ' $timeLeft left',
                                    fontsize: 15.h,
                                    color: cred,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
