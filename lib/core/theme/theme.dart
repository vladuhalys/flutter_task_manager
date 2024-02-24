import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final light = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.textHeadlineColor,
        fontSize: 144,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      titleMedium: TextStyle(
        color: AppColors.textTitleColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      labelMedium: TextStyle(
        color: AppColors.textLableColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textBodyColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    ),
  );

  static final dark = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 144,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkTextTitleColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      labelMedium: TextStyle(
        color: AppColors.darkTextLableColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkTextBodyColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    ),
  );
}
