import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';

class StudentHomeWork extends StatelessWidget {
  const StudentHomeWork({super.key, required this.downloadUrl});
  final List<String> downloadUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: cblack,
        appBar: AppBar(
          foregroundColor: cblack,
          title: const Text(
            "Submitted Work",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: cblack),
        ),
        body: PageView.builder(
          itemCount: downloadUrl.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${index + 1} / ${downloadUrl.length}',
                          style: TextStyle(fontSize: 17.h),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: InteractiveViewer(
                      panAxis: PanAxis.aligned,
                      child: Image.network(
                        downloadUrl[index],
                        // 'https://thebig.co/images/blogs/vertical_panorama02.jpg',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
