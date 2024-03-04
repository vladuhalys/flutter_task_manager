import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';

class AppErrorText extends StatelessWidget {
  const AppErrorText(
      {super.key, required this.errorText, this.alignment, this.padding});

  final String errorText;
  final AlignmentGeometry? alignment;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.only(start: 20, top: 5),
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: Text(
          errorText,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.textError,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
