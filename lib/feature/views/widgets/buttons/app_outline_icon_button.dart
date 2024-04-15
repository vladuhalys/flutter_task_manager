import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';


class AppOutlineIconButton extends StatelessWidget {
  const AppOutlineIconButton(
      {super.key, required this.child, required this.onTap});

  final Widget child;
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
      child: child,
    );
  }
}
