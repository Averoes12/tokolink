import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static double radius = 15;
  static TextTheme mainTextTheme = TextTheme(
    headline1: GoogleFonts.lato(fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.lato(fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.lato(fontSize: 46, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.lato(fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.lato(fontSize: 23, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.lato(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: Colors.white),
    caption: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
  );

  static AppBarTheme appBarTheme = AppBarTheme(
      color: Colors.white,
      elevation: 2,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      iconTheme: IconThemeData(color: Colors.black));

  static ButtonThemeData buttonTheme = ButtonThemeData(
    buttonColor: Colors.cyan,
    textTheme: ButtonTextTheme.accent,
    height: 50.0,
  );
}
