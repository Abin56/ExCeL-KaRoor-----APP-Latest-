import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';
import 'package:excel_karoor/widgets/back_button/back_button_widget.dart';

customShowDilogBox(
    {required BuildContext context,
    required String title,
    required List<Widget> children,
    String? actiontext,
    Widget? headerchild,
    required bool doyouwantActionButton,
    required bool doyouwantCancelButton,
    void Function()? actiononTapfuction}) {
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
              GooglePoppinsWidgets(
                  text: title, fontsize: 20, fontWeight: FontWeight.w600),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: BackButtonContainerWidget(),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: children,
            ),
          ),
          actions: doyouwantActionButton == true
              ? <Widget>[
                  GestureDetector(
                    onTap: actiononTapfuction,
                    child: Container(
                      height: 40,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: adminePrimayColor,
                      ),
                      child: Center(
                        child: GooglePoppinsWidgets(
                            text: actiontext ?? 'OK',
                            color: cWhite,
                            fontsize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  doyouwantCancelButton == true
                      ? GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: adminePrimayColor,
                            ),
                            child: Center(
                              child: GooglePoppinsWidgets(
                                  text: actiontext ?? 'Cancel',
                                  color: cWhite,
                                  fontsize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : const SizedBox()
                ]
              : null);
    },
  );
}
