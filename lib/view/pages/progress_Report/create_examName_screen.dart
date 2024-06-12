import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel_karoor/controllers/form_controller/form_controller.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';

import 'all_student_list.dart';

class CreateExamNameScreen extends StatelessWidget {
  final String schooilID;
  final String classID;
  final String teacherId;
  final String batchId;
  final TextEditingController _examNameController = TextEditingController();
  CreateExamNameScreen(
      {required this.schooilID,
      required this.classID,
      required this.teacherId,
      required this.batchId,
      super.key});

final CreateExamFormController createExamFormController = Get.put(CreateExamFormController());
  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    //final formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Report".tr),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(schooilID)
                  .collection(batchId)
                  .doc(batchId)
                  .collection("classes")
                  .doc(classID)
                  .collection("ProgressReport")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AnimationLimiter(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(w / 60),
                      crossAxisCount: columnCount,
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 200),
                            columnCount: columnCount,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return AllStudentsListScreen(
                                        batchId: batchId,
                                        teacherId: teacherId,
                                        examName: snapshot.data!.docs[index]
                                            .data()['docid'],
                                        schooilID: schooilID,
                                        classID: classID);
                                    },));
                                    // Get.off(() => AllStudentsListScreen(
                                    //     batchId: batchId,
                                    //     teacherId: teacherId,
                                    //     examName: snapshot.data!.docs[index]
                                    //         .data()['docid'],
                                    //     schooilID: schooilID,
                                    //     classID: classID));
                                  },
                                  child: Container(
                                    height: h / 100,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        bottom: w / 10,
                                        left: w / 50,
                                        right: w / 50),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(212, 67, 30, 203)
                                              .withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .data()['docid'],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter Exam Name'.tr),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Form(
                        key: createExamFormController. formKey,
                        child: TextFormField(
                            validator: checkFieldEmpty,
                            controller: _examNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Exam Name'.tr,

                                // prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(19),
                                )),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                            )),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      child: Text('Create'.tr),
                      onPressed: () async {
                        if (createExamFormController. formKey.currentState?.validate() ?? false) {
                          await FirebaseFirestore.instance
                              .collection("SchoolListCollection")
                              .doc(schooilID)
                              .collection(batchId)
                              .doc(batchId)
                              .collection("classes")
                              .doc(classID)
                              .collection("ProgressReport")
                              .doc(_examNameController.text.trim())
                              .set({
                            'docid': _examNameController.text.trim(),
                            'date': DateTime.now().toString()
                          }).then((value) => Get.back());
                        }
                      }),
                  TextButton(
                    child: Text('Cancel'.tr),
                    onPressed: () async {
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
