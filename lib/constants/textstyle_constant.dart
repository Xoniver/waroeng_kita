import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleConstant {
  static TextStyle get textStyleRegular => GoogleFonts.roboto();
  static TextStyle get textStyleSemiBold =>
      GoogleFonts.roboto(fontWeight: FontWeight.w600);
  static TextStyle get textStyleBold =>
      GoogleFonts.roboto(fontWeight: FontWeight.bold);
}
