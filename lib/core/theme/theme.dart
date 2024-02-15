import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.backgroundColor,
  );

  static ThemeData dark = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkTextHeadlineColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
