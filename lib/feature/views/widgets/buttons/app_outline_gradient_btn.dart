import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppOutlineGradientButton extends StatelessWidget {
  const AppOutlineGradientButton(
      {super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlineGradientButton(
      onTap: onTap,
      gradient: LinearGradient(
        colors: [
          AppColors.btnGradientStart,
          AppColors.btnGradientEnd,
        ],
      ),
      strokeWidth: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      radius: const Radius.circular(20),
      child: Center(
        child: GradientText(
          text,
          style: Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          colors: [
            AppColors.btnGradientStart,
            AppColors.btnGradientEnd,
          ],
        ),
      ),
    );
  }
}
