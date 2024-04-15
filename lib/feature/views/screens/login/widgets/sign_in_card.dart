import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/cards/app_gradient_border_card.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInCard extends GetResponsiveWidget<ThemeController> {
  SignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return GetBuilder<ValidationController>(builder: (validationController) {
      return AppGradientBorderCard(
        width: screen.width * 0.4,
        height: 500,
        gradients: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(LangKeys.login.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 35)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 50.0),
              child: Text(LangKeys.welcomeBack.tr,
                  style: context.textTheme.titleMedium!.copyWith(fontSize: 25)),
            ),
            Column(
              children: [
                AppGradientBorderTextField(
                    hintText: LangKeys.email.tr,
                    prefixIcon: Icon(
                      EvaIcons.email,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onChanged: (value) {
                      validationController.onEmailChanged(value);
                    }),
                AppErrorText(errorText: validationController.emailError),
                const SizedBox(height: 10),
                AppGradientBorderTextField(
                    hintText: LangKeys.password.tr,
                    obscureText: true,
                    prefixIcon: Icon(
                      EvaIcons.lock,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onChanged: (value) {
                      validationController.onPasswordChanged(value);
                    }),
                AppErrorText(errorText: validationController.passwordError),
                const SizedBox(height: 10),
                AppElevatedGradientButton(
                  text: LangKeys.login.tr,
                  onTap: () {
                    validationController.validateAll();
                  },
                  width: Get.mediaQuery.size.width,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
