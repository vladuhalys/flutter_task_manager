import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/theme.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:get/get.dart';

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
              ElevatedButton(
                  onPressed: () {
                    themeController.changeTheme();
                  },
                  child: const Text('Click')),
            ],
          ),
        ),
      );
    });
  }
}
