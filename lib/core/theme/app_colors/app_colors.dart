import 'package:flutter/material.dart';

abstract class AppColors {
  //* light theme
  static const Color backgroundColor = Color(0xFFF2F9FF);

  //button colors

  //text colors
  static Color textHeadlineColor = const Color(0xFF0C1013).withOpacity(0.8);
  static Color textTitleColor = const Color(0xFF0C1013).withOpacity(0.5);
  static Color textLableColor = const Color(0xFF0C1013).withOpacity(0.25);
  static Color textBodyColor = const Color(0xFF0C1013).withOpacity(0.10);

  static Color textError = const Color(0xFFD32F2F);

  //* dark theme
  static const Color darkBackgroundColor = Color(0xFF0C1013);

  //button colors
  static Color btnGradientStart = const Color(0xFF00B2FF);
  static Color btnGradientEnd = const Color(0xFF0500FF);

  //text colors
  static Color darkTextHeadlineColor = const Color(0xFFE8F4FF).withOpacity(0.8);
  static Color darkTextTitleColor = const Color(0xFFE8F4FF).withOpacity(0.5);
  static Color darkTextLableColor = const Color(0xFFE8F4FF).withOpacity(0.25);
  static Color darkTextBodyColor = const Color(0xFFE8F4FF).withOpacity(0.10);
}
