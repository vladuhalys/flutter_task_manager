import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:get/get.dart';

class AppOutlineIconButton extends StatelessWidget {
  const AppOutlineIconButton(
      {super.key, required this.icon, required this.text, required this.onTap});

  final Icon icon;
  final Text text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return OutlineGradientButton(
          onTap: onTap,
          gradient: controller.isDark.value
              ? AppColors.btnDarkGradient
              : AppColors.btnLightGradient,
          strokeWidth: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          radius: const Radius.circular(20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 10),
                text,
              ],
            ),
          ),
        );
      },
    );
  }
}
