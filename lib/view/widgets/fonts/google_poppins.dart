// ignore_for_file: must_be_immutable

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GooglePoppinsWidgets extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  Color? color;
  
  GooglePoppinsWidgets({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: fontsize.sp,
        fontWeight: fontWeight,
        color: color,
       
      ),
    );
  }
}

class GooglePoppinsWidgetsPP extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  Color? color;
  
  GooglePoppinsWidgetsPP({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: fontsize.sp,
        fontWeight: fontWeight,
        color: color,
       
      ),
    );
  }
}