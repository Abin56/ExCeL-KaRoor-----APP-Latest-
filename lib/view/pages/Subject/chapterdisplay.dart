import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/sizes.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class SubjectWiseDisplay extends StatelessWidget {
  const SubjectWiseDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Chapters"),
        ),
        body: Container(
          color: Colors.white54,
          child: ListView.separated(
            itemCount: 7,
            separatorBuilder: (BuildContext context, int index) => kHeight10,
            itemBuilder: (BuildContext context, int index) {
              return ListileCardChapterWidget(
                leading: const Icon(Icons.note_rounded),
                title: GooglePoppinsWidgets(
                  text: "Chapter 1",
                  fontsize: 20.h,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: GooglePoppinsWidgets(
                        text: "CMOS & NMOS",
                        fontsize: 15.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  StudyMaterials()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: GooglePoppinsWidgets(
                          text: "Study Materials".tr,
                          fontsize: 16.h,
                          color: adminePrimayColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GooglePoppinsWidgets(
                            text: "Teacher Name : ",
                            fontsize: 15.h,
                          ),
                          GooglePoppinsWidgets(
                            text: "Anupama",
                            fontsize: 15.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: null,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListileCardChapterWidget extends StatelessWidget {
  const ListileCardChapterWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

 final Widget leading;
 final Widget title;
 final Widget subtitle;
 final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: const BeveledRectangleBorder(side: BorderSide(color: cWhite)),
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
