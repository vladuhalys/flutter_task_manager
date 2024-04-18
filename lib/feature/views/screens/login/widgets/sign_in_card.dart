import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_icon_button.dart';
import 'package:flutter_task_manager/feature/views/widgets/cards/app_gradient_border_card.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInCard extends GetWidget<ThemeController> {
  const SignInCard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ValidationController>();
    return GetBuilder<ValidationController>(builder: (validationController) {
      return AppGradientBorderCard(
        width: context.width * 0.4,
        height: context.height * 0.7,
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
                AppErrorText(errorText: validationController.emailError.tr),
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
                AppErrorText(errorText: validationController.passwordError.tr),
                const SizedBox(height: 10),
                AppElevatedGradientButton(
                  text: LangKeys.login.tr,
                  onTap: () {
                    validationController.validateAll();
                    if (validationController.isEmailValid &&
                        validationController.isPasswordValid) {
                      Get.find<SupabaseController>().signIn(
                          validationController.email,
                          validationController.password);
                    }
                  },
                  width: Get.mediaQuery.size.width,
                  height: 50,
                ),
                const SizedBox(height: 20),
                Text(LangKeys.loginWithSocialMedia.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AppOutlineIconButton(
                          icon: const Icon(Bootstrap.google),
                          text: Text(
                            'Google',
                            style: Get.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () async {
                            await Get.find<SupabaseController>().signInWithGoogle();
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppOutlineIconButton(
                          icon: const Icon(Bootstrap.github),
                          text: Text(
                            'GitHub',
                            style: Get.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () {
                            Get.find<SupabaseController>().signInWithGitHub();
                          }),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AppOutlineIconButton(
                          icon: const Icon(Bootstrap.gitlab),
                          text: Text(
                            'GitLab',
                            style: Get.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () {
                            Get.find<SupabaseController>().signInWithGitLab();
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
