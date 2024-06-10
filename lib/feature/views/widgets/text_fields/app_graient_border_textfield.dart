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
      this.keyboardType,
      this.initialValue,
      this.minLines,
      this.maxLines,
      this.expands});

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? minLines;
  final int? maxLines;
  final bool? expands;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      expands: expands ?? false,
      initialValue: initialValue,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      maxLines: (obscureText != null) ? 1 : maxLines,
      minLines: (obscureText != null) ? null : minLines,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
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
