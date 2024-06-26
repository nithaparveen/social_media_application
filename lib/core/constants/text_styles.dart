import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class GLTextStyles {
  static robotoStyl({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static poppinsStyl({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size ?? 20,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static kanitStyl({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.kanit(
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static ralewayStyl(
      {double? size,
      FontWeight? weight,
      Color? color,
      TextDecoration? textDecoration,
      TextDecorationStyle? textDecorationStyle,
      Color? decorationColor}) {
    return GoogleFonts.raleway(
        fontSize: size ?? 16,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? ColorTheme.black,
        decoration: textDecoration,
        decorationStyle: textDecorationStyle,
        decorationColor: decorationColor);
  }

  static leagueSpartan({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.leagueSpartan(
      fontSize: size ?? 16,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }
}
