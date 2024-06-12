// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSalsaWidgets extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  double? letterSpacing;
  Color? color;
  TextOverflow? overflow;
  GoogleSalsaWidgets({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: GoogleFonts.salsa(
        letterSpacing: letterSpacing,
        fontSize: fontsize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
