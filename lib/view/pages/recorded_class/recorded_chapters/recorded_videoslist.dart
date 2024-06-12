import 'dart:async';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/recorded_controller/recorded_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/utils/utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/pages/recorded_videos/play_video.dart';
import 'package:excel_karoor/view/widgets/button_container_widget.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/widgets/textformfield.dart';

class RecordedVideosList extends StatefulWidget {
  const RecordedVideosList(
      {super.key, required this.subjectID, required this.chapterID});

  final String subjectID;
  final String chapterID;
  @override
  State<RecordedVideosList> createState() => _RecordedVideosListState();
}

class _RecordedVideosListState extends State<RecordedVideosList> {
  final RecordedChapterController chapterController =
      Get.put(RecordedChapterController());

  final ScrollController controller = ScrollController();
  double _scrollPosition = 0.0;
  final double _scrollMax = 1000.0; // adjust this to your content's height
  Timer? _timer;
  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollPosition < _scrollMax) {
        _scrollPosition += 1.0;
        if (controller.hasClients) {
          controller.animateTo(_scrollPosition,
              duration: const Duration(milliseconds: 50), curve: Curves.linear);
        }
      } else {
        _scrollPosition = 0.0;
        controller.jumpTo(0.0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: const Text("Recorded classes"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: server
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('subjects')
              .doc(widget.subjectID)
              .collection('recorded_classes_chapters')
              .doc(widget.chapterID)
              .collection('RecordedClass')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                        contentPadding: const EdgeInsets.all(0),
                        shape: const BeveledRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 125, 169, 225),
                                width: 0.2)),
                        leading: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 17, right: 8),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: cgrey, width: 1,
                                // indent: 4,
                                // endIndent: 4,
                              )
                            ],
                          ),
                        ),
                        title: SingleChildScrollView(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                ' ${data['topicName']}',
                                style: TextStyle(
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: SizedBox(
                          width: 72,
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlayVideoFlicker(
                                                  videoUrl: data['downloadUrl'])
                                          // Videoplayer(
                                          //     videoUrl:
                                          //         data['downloadUrl']),
                                          ),
                                    );
                                  },
                                  child: const Icon(
                                      Icons.ondemand_video_outlined)),
                              PopupMenuButton(
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      onTap: () {
                                        chapterController.topicController.text =
                                            data['topicName'];
                                        showModalBottomSheet(
                                          context: context,
                                          isDismissible: false,
                                          shape: const BeveledRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.zero)),
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Form(
                                                key: chapterController.formKey,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 25,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                                Icons.close),
                                                          )
                                                        ],
                                                      ),
                                                      const Text(
                                                        "Topic Name *",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      kHeight20,
                                                      TextFormFieldWidget(
                                                        function:
                                                            checkFieldEmpty,
                                                        textEditingController:
                                                            chapterController
                                                                .topicController,
                                                        hintText: "topic name",
                                                      ),
                                                      kHeight40,
                                                      Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (chapterController
                                                                .formKey
                                                                .currentState!
                                                                .validate()) {
                                                              chapterController.updateChapterTopic(
                                                                  subjectID: widget
                                                                      .subjectID,
                                                                  chapterID: widget
                                                                      .chapterID,
                                                                  docId: data[
                                                                      'docid']);
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child:
                                                              ButtonContainerWidget(
                                                            curving: 18,
                                                            colorindex: 2,
                                                            height: 60.h,
                                                            width: 150.w,
                                                            child: Center(
                                                              child:
                                                                  GooglePoppinsWidgets(
                                                                text: "Update",
                                                                color: cWhite,
                                                                fontsize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
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
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "No",
                                                      style: TextStyle(
                                                          color: cblack),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      chapterController
                                                          .deleteRecordedClass(
                                                              subjectID: widget
                                                                  .subjectID,
                                                              chapterID: widget
                                                                  .chapterID,
                                                              docId: data[
                                                                  'docid']);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: cblack),
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
                                        )),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: Text('No Recorded Classes Uploaded Yet!'.tr));
          },
        ),
      ),
    );
  }
}
