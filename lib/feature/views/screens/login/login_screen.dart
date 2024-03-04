import 'package:flutter/material.dart';

import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/cards/app_gradient_border_card.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends GetWidget<ThemeController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ValidationController>(builder: (validationController) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
          'Satoshi',
          style: Theme.of(context).textTheme.titleMedium,
        )),
        body: Center(
          child: AppGradientBorderCard(
            padding: const EdgeInsets.all(10),
            gradients: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
            width: Get.width * 0.5,
            height: Get.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 20),
                AppGradientBorderTextField(
                    hintText: "Email",
                    prefixIcon: Icon(
                      EvaIcons.email,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onChanged: (value) {
                      validationController.onEmailChanged(value);
                    }),
                AppErrorText(errorText: validationController.emailError),
                AppOutlineGradientButton(
                  text: 'Login',
                  onTap: () {
                    validationController.validateEmail();
                    controller.changeTheme();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
