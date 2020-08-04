import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';

class StyleConfig {
  static final double _radius = 20;

  static BorderRadiusGeometry mainBoxBorder = BorderRadius.only(
    topLeft: Radius.circular(_radius),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(_radius),
    bottomRight: Radius.circular(_radius),
  );

  static BorderRadiusGeometry fullBoxBorder = BorderRadius.only(
    topLeft: Radius.circular(_radius),
    topRight: Radius.circular(_radius),
    bottomLeft: Radius.circular(_radius),
    bottomRight: Radius.circular(_radius),
  );

  static BorderRadiusGeometry confirmRightBoxBorder = BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(0),
    bottomRight: Radius.circular(_radius),
  );

  static BorderRadiusGeometry confirmLeftBoxBorder = BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(_radius),
    bottomRight: Radius.circular(0),
  );

  static PinBoxDecoration defaultPinBoxDecoration = (
    Color borderColor,
    Color pinBoxColor, {
    double borderWidth = 2.0,
    double radius = 5.0,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      color: pinBoxColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(_radius),
        bottomRight: Radius.circular(_radius),
      ),
    );
  };

  static ThemeData defaultStyle = ThemeData(
      primarySwatch: Colors.green,
      primaryColor: ColorConfig.PRIMARY,
      accentColor: ColorConfig.ACCENT,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.2,
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.montserrat(
          fontSize: 97,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        headline2: GoogleFonts.montserrat(
          fontSize: 61,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        headline3: GoogleFonts.montserrat(
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headline4: GoogleFonts.montserrat(
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headline5: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        headline6: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle1: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        subtitle2: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyText1: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyText2: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        button: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          color: ColorConfig.N1,
        ),
        caption: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        overline: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorConfig.N3,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.zero,
            topLeft: Radius.circular(_radius),
            bottomRight: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.all(1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorConfig.N2,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: TextStyle(color: ColorConfig.N3),
        prefixStyle: TextStyle(color: ColorConfig.N3),
        suffixStyle: TextStyle(color: ColorConfig.N3),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(_radius),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(_radius),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(_radius),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(_radius),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(_radius),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
        padding: EdgeInsets.symmetric(vertical: 15),
        disabledColor: ColorConfig.N3,
        buttonColor: ColorConfig.PRIMARY,
      ),
      dialogBackgroundColor: Colors.white,
      dialogTheme: DialogTheme(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: StyleConfig.mainBoxBorder)));
}
