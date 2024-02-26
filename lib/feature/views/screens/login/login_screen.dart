import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_gradient_btn.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
          'Satoshi',
          style: Theme.of(context).textTheme.titleMedium,
        )),
        body: Center(
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [
                      AppColors.btnGradientStart,
                      AppColors.btnGradientEnd
                    ]),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(20),
              width: Get.width * 0.5,
              height: Get.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 20),
                  AppOutlineGradientButton(
                    text: 'Login',
                    onTap: () {
                      themeController.changeTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
