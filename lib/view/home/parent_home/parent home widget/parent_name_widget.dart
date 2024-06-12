import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/controllers/userCredentials/user_credentials.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/constant/sizes/constant.dart';
import 'package:excel_karoor/view/home/events/event_display_school_level.dart';
import 'package:excel_karoor/view/home/parent_home/parent_profile_edit/parent_edit_profile_full.dart';
import 'package:excel_karoor/view/widgets/fonts/google_monstre.dart';

class ParentNameWidget extends StatelessWidget {
  const ParentNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 05,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      UserCredentialsController.parentModel!.profileImageURL ??
                          netWorkImagePathPerson),
                  radius: 25,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 1),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GooglePoppinsEventsWidgets(
                        text: UserCredentialsController.parentModel!.parentName!,
                        fontsize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                       Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("SchoolListCollection")
                                    .doc(UserCredentialsController.schoolId)
                                    .collection("AllStudents")
                                    .doc(UserCredentialsController
                                            .parentModel?.studentID ??
                                        '')
                                    .get(),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return GoogleMonstserratWidgets(
                                      text:
                                          'Student : ${snap.data?.data()?['studentName']}',
                                      fontsize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cblack.withOpacity(0.8),
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                }),
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ParentEditProfileScreenFull();
                        },
                      ));
                    },
                    icon: const Icon(Icons.now_widgets)))
          ],
        ),
      ),
    );
  }
}
