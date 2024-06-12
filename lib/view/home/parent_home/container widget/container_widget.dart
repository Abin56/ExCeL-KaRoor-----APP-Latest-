import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:excel_karoor/view/widgets/fonts/google_poppins.dart';

class ParentContainerWidget extends StatelessWidget {
  final String text;
  final String icon;
  final void Function()? onTap;

  const ParentContainerWidget({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80.w, //110
        height: 110.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 80.h,
                width: 80.w,
                decoration: const BoxDecoration(shape: BoxShape.circle,
                 // borderRadius: BorderRadiusDirectional.all(Radius.circular(10),),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), ],),
                child: Center(
                  child: Image.asset(
                    icon,
                    fit: BoxFit.contain,
                    height: 40,width: 40,
                    scale: 2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                  child:GooglePoppinsWidgets(  
                      
                      fontWeight: FontWeight.w500, text:text,fontsize: 12,)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
