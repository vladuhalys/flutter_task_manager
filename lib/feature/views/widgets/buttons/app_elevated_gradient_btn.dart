import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:gradient_coloured_buttons/gradient_coloured_buttons.dart';

class AppElevatedGradientButton extends StatelessWidget {
  const AppElevatedGradientButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      required this.height,
      this.textStyle});

  final String text;
  final Function() onTap;
  final double width;
  final double height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      width: width,
      height: height,
      gradientColors: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
      borderRadius: 20,
      onPressed: onTap,
      text: text,
      textStyle: textStyle ??
          Get.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
    );
  }
}
