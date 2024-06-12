import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class ContainerWidget extends StatelessWidget {
  final String text;
  //final IconData icon;
  final String image;
  final void Function()? onTap;

  const ContainerWidget({
    required this.text,
    //required this.icon,
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
        child: Container(
          decoration:  const BoxDecoration(color: cWhite,
             boxShadow: [
                BoxShadow(
                  color: cWhite,
                  offset: Offset( .5, 0, ),
                  blurRadius: 3,
                  spreadRadius: 1,
                ), 
                BoxShadow(
                   color: cWhite,
                  offset: Offset( .5, 0, ),
                  blurRadius: 3,
                  spreadRadius: 1,
                  // color: cWhite,
                  // offset: Offset(5.0, 5.0),
                  // blurRadius: 5,
                  // spreadRadius: 5,
                ), 
              ],
            //  border: Border(right: BorderSide(color: Colors.green,width: 2),top: BorderSide(color: Colors.green,width: 2),
            //  bottom: BorderSide(color: cWhite,width: 2,),left: BorderSide(color: cWhite,width: 2,) )
             ),
          width: 109.w,
          height: 110.h,
          child: Container(
            color: cWhite,
            width: 109.w, //110
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(color: cWhite,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: adminePrimayColor.withOpacity(0.5))),
                  child: Center(
                    child: Image.asset(
                      image,height: 40,width: 40,
                      fit: BoxFit.contain,
                      scale: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: GooglePoppinsWidgets(text: text, fontsize: 10,fontWeight: FontWeight.bold,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
