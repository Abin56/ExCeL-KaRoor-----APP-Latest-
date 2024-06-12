import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';

showDialogeBox({
  required BuildContext context,
  required List<Widget> children,
  required List<Widget>? actions,
  String? actiontext,
  Widget? headerchild,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: cWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerchild ?? const SizedBox(),
            // GooglePoppinsWidgets(
            //     text: title, fontsize: 13, fontWeight: FontWeight.w600),
            const Padding(
              padding: EdgeInsets.only(top: 10),
           
            )
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: children,
          ),
        ),
        actions: actions,
      );
    },
  );
}
