import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorConstant {
  static Color scaffolfBgPrimaryColor = const Color(0xFFF35B97);
  static Color scaffolfBgSecondaryColor = const Color(0xFFFFE4DC);
  static Color scaffolfBgTernaryColor = const Color(0xFFFFFFFF);

  static Color primaryColor = const Color(0xFF180786);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color greyColor = const Color(0xFFF8F8F8);
  static Color greenColor = const Color(0xFF3DA44D);
}

class TextStyles {
  static TextStyle headingLarge = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 26,
      color: ColorConstant.primaryColor);
  static TextStyle headingMedium = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 20,
      color: ColorConstant.whiteColor);
  static TextStyle headingSmall = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.w100,
      fontSize: 18,
      color: ColorConstant.whiteColor);
  ////

  static TextStyle titleLarge = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: ColorConstant.primaryColor);
  static TextStyle titleMedium = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: ColorConstant.primaryColor);
  static TextStyle titleSmall = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: ColorConstant.primaryColor);
  ////

  static TextStyle bodyLarge = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 20,
      color: ColorConstant.primaryColor);
  static TextStyle bodyMedium = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: ColorConstant.primaryColor);
  static TextStyle bodySmall = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: ColorConstant.primaryColor);
  ////

  static const TextStyle displayLarge = TextStyle(
    fontFamily: "QuickSand",
    fontWeight: FontWeight.bold,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: "QuickSand",
    fontWeight: FontWeight.bold,
  );
  static TextStyle displaySmall = TextStyle(
      fontFamily: "QuickSand",
      fontWeight: FontWeight.normal,
      fontSize: 12,
      color: ColorConstant.primaryColor);
  static const TextStyle lableLarge = TextStyle(
    fontFamily: "QuickSand",
    fontWeight: FontWeight.bold,
  );
}
