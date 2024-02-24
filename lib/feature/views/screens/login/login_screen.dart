import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_gradient_btn.dart';
import 'package:get/get.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Satoshi',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Text('Satoshi', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              Text('Satoshi', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 20),
              Text('Satoshi', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              AppElevatedGradientButton(
                text: 'Change theme',
                onTap: () {
                  themeController.changeTheme();
                },
                width: 200,
                height: 50,
              ),
            ],
          ),
        ),
      );
    });
  }
}
