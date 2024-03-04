import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

class AppGradientBorderTextField extends StatelessWidget {
  const AppGradientBorderTextField(
      {this.controller,
      super.key,
      this.hintText,
      this.onChanged,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.readOnly,
      this.keyboardType});

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
        border: GradientOutlineInputBorder(
          width: 2,
          gradient: LinearGradient(
            colors: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
