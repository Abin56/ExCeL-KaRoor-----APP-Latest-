import 'dart:math';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/controllers/live_room_controller/live_room_controller.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/info/info.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/pages/live_classes/teacher_live_section/list_of_rooms.dart';
import 'package:excel_karoor/view/widgets/button_container_widget.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class CreateRoomScreen extends StatefulWidget {
 final LiveRoomController liveRoomController = Get.put(LiveRoomController());
  CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  String randomID = '';
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  createRandomID() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    randomID = roomName;
  }

  @override
  void initState() {
    createRandomID();
    super.initState();
  }
final CreateLiveRoomController createLiveRoomController = Get.put(CreateLiveRoomController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: ButtonContainerWidget(
                curving: 0,
                colorindex: 2,
                height: 100.h,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90.h,
                    ),
                    GoogleMonstserratWidgets(
                        text: live,
                        fontsize: 35.sp,
                        color: cWhite,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId!)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .collection('LiveRooms')
                                .snapshots(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                if (snap.data!.docs.isEmpty) {
                                  return const Center();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)
              {return const ListofRoomsScreen();}));




                                      // Get.to(() => const ListofRoomsScreen());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        height: 40.h,
                                        width: 150.w,
                                        color: const Color.fromARGB(
                                            63, 255, 255, 255),
                                        child: Center(
                                          child: GooglePoppinsWidgets(
                                            fontsize: 16.sp,
                                            text: 'View session',
                                            color: cWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return const Center();
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: createLiveRoomController.formKey,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 300,
                child: Container(
                  decoration: const BoxDecoration(
                      color: cWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: 250.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        GooglePoppinsWidgets(
                          fontsize: 30.sp,
                          text: 'Create live session',
                          fontWeight: FontWeight.bold,
                        ),
                        //  kHeight10,
                        GooglePoppinsWidgets(
                          fontsize: 16.sp,
                          text: 'Enter session details',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        ButtonContainerWidget(
                            curving: 10,
                            colorindex: 2,
                            height: 40.h,
                            width: 300.w,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10),
                              child: Center(
                                child: GooglePoppinsWidgets(
                                    text: 'Session ID :  $randomID',
                                    color: Colors.white,
                                    fontsize: 15.sp),
                              ),
                            )),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 80.h,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // GooglePoppinsWidgets(
                                    //   fontsize: 12,
                                    //   fontWeight: FontWeight.w300,
                                    //   text: 'Room Name : ',
                                    // ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 200.w,
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 16.sp),
                                          controller: _roomNameController,
                                          validator: (value) {
                                            if (_roomNameController
                                                .text.isEmpty) {
                                              return 'Please Enter Room Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Enter the topic',
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.all(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectTime(context);
                          },
                          child: SizedBox(
                            height: 80.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                        width: 150.h,
                                        child: Center(
                                            child: TextFormField(
                                          style: TextStyle(fontSize: 16.sp),
                                          validator: (value) {
                                            if (_timeController.text.isEmpty) {
                                              return "Please select Time";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: _timeController,
                                          decoration: const InputDecoration(
                                            hintText: '  Selected Time',
                                          ),
                                          readOnly: true,
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            selectTime(context);
                                          },
                                          icon: const Icon(Icons.timer))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {
                            if (createLiveRoomController.formKey.currentState!.validate()) {
                              await widget.liveRoomController
                                  .createRoom(
                                      context,
                                      _roomNameController.text.trim(),
                                      _timeController.text,
                                      uuid.v1(),
                                      randomID,
                                      UserCredentialsController
                                              .teacherModel!.teacherName ??
                                          "test")
                                  .then((value) {
                                _timeController.clear();
                                _roomNameController.clear();

                                ////
                              });
                            } else {
                              return;
                            }
                          },
                          child: ButtonContainerWidget(
                              curving: 10,
                              colorindex: 2,
                              height: 50.h,
                              width: 240.h,
                              child: Center(
                                  child: GooglePoppinsWidgets(
                                text: 'Create Session ',
                                fontsize: 18.sp,
                                color: cWhite,
                              ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Column(
                                children: [
                                  GooglePoppinsWidgets(
                                      text:
                                          'Owner : ${UserCredentialsController.teacherModel?.teacherName}',
                                      fontsize: 14.sp),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      _timeController.text = formattedTime;
    }
  }
}

const containerColor = [
  [
    Color.fromARGB(255, 27, 199, 159),
    Color.fromARGB(255, 202, 141, 161),
  ],
  [Color.fromARGB(255, 202, 141, 161), Color.fromARGB(255, 55, 124, 158)],
  [Color(0xff6448fe), Color(0xff5fc6ff)],
  [Color(0xfffe6197), Color.fromARGB(255, 159, 94, 25)],
  [Color.fromARGB(107, 2, 141, 64), Color.fromARGB(107, 2, 141, 64)],
  [Color.fromARGB(255, 116, 130, 255), Color.fromARGB(255, 86, 74, 117)],
  [Color.fromARGB(255, 205, 215, 15), Color.fromARGB(255, 224, 173, 22)],
  [Color.fromARGB(255, 208, 104, 105), Color.fromARGB(255, 241, 66, 66)],
  [Color.fromARGB(255, 242, 230, 230), Color.fromARGB(255, 255, 252, 252)]
];
