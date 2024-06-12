import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/recorded_controller/recorded_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/recorded_class/recorded_chapters/recorded_videoslist.dart';
import 'package:excel_karoor/view/widgets/button_container_widget.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/widgets/textformfield.dart';

class RecordedClassChapters extends StatelessWidget {
  const RecordedClassChapters({super.key, required this.subjectID});
  final String subjectID;

  @override
  Widget build(BuildContext context) {
    final RecordedChapterController chapterController =
        Get.put(RecordedChapterController());
    // TextEditingController chapterNumbercontroller = TextEditingController();
    // TextEditingController chapterNamecontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: const Text("Chapters"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('subjects')
              .doc(subjectID)
              .collection('recorded_classes_chapters')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Please Create Chapters"),
                  );
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: ((context, index) {
                      return kHeight10;
                    }),
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
                        child: Card(
                          color: const Color.fromARGB(236, 228, 244, 255),
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecordedVideosList(
                                    subjectID: subjectID,
                                    chapterID: data['docid'],
                                  ),
                                ),
                              );
                            },
                            shape: const BeveledRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 125, 169, 225),
                                    width: 0.2)),
                            leading: SizedBox(
                              width: 40,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 10),
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 16.h,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: cgrey,
                                  )
                                ],
                              ),
                            ),
                            title: Text(
                              data['chapterNumber'],
                              // "Chapter number",
                              style: TextStyle(
                                fontSize: 20.h,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Text(
                                data['chapterName'],
                                // "Chapter name ",
                                style: TextStyle(
                                  fontSize: 15.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            trailing: PopupMenuButton(
                              padding: const EdgeInsets.only(left: 50),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {
                                      chapterController.chapterNumberController
                                          .text = data['chapterNumber'] ?? "";
                                      chapterController.chapterNameController
                                          .text = data['chapterName'] ?? "";
                                      showModalBottomSheet(
                                        context: context,
                                        isDismissible: false,
                                        shape: const BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero)),
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: Form(
                                              key: chapterController.formKey,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    top: 20,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                    const Text(
                                                      "Chapter number *",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    kHeight10,
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 60,
                                                          width: 279,
                                                          child:
                                                              TextFormFieldWidget(
                                                            function:
                                                                checkFieldEmpty,
                                                            textEditingController:
                                                                chapterController
                                                                    .chapterNumberController,
                                                            hintText:
                                                                "chapter number",
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (chapterController
                                                                .formKey
                                                                .currentState!
                                                                .validate()) {
                                                              chapterController
                                                                  .updateChapterNumber(
                                                                subjectID:
                                                                    subjectID,
                                                                chapterID: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['docid'],
                                                              );
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child:
                                                              ButtonContainerWidget(
                                                            curving: 5,
                                                            colorindex: 2,
                                                            height: 40.h,
                                                            width: 92.w,
                                                            child: Center(
                                                              child:
                                                                  GooglePoppinsWidgets(
                                                                text: "Update",
                                                                color: cWhite,
                                                                fontsize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    kHeight40,
                                                    const Text(
                                                      "Chapter Name *",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    kHeight10,
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 60,
                                                          width: 279,
                                                          child:
                                                              TextFormFieldWidget(
                                                            function:
                                                                checkFieldEmpty,
                                                            textEditingController:
                                                                chapterController
                                                                    .chapterNameController,
                                                            hintText:
                                                                "chapter name",
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (chapterController
                                                                .formKey
                                                                .currentState!
                                                                .validate()) {
                                                              chapterController
                                                                  .updateChapterName(
                                                                subjectID:
                                                                    subjectID,
                                                                chapterID: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['docid'],
                                                              );
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child:
                                                              ButtonContainerWidget(
                                                            curving: 5,
                                                            colorindex: 2,
                                                            height: 40.h,
                                                            width: 92.w,
                                                            child: Center(
                                                              child:
                                                                  GooglePoppinsWidgets(
                                                                text: "Update",
                                                                color: cWhite,
                                                                fontsize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    kHeight20,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: const Text(
                                              "Do you want to delete the video?",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "No",
                                                  style:
                                                      TextStyle(color: cblack),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  chapterController
                                                      .deleteRecordedClassChapter(
                                                          subjectID: subjectID,
                                                          chapterID:
                                                              data['docid']);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Yes",
                                                  style:
                                                      TextStyle(color: cblack),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      " Delete",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error occurred while fetching data"),
                );
              } else {
                return const Center(
                  child: Text("No data available"),
                );
              }
            } else {
              return const Center(
                child: Text("Please Create Chapters"),
              );
            }
          },
        ),
      ),
    );
  }
}
