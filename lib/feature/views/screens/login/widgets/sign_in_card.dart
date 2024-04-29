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
        height: context.height * 0.8,
        gradients: [AppColors.btnGradientStart, AppColors.btnGradientEnd],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                  (validationController.isRegistrForm)
                      ? LangKeys.register.tr
                      : LangKeys.login.tr,
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
                const SizedBox(height: 20),
                AppGradientBorderTextField(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          validationController.changeShowPassword();
                        },
                        icon: (validationController.obscurePassword.value)
                            ? Icon(
                                EvaIcons.eye_off,
                                size: 30,
                                color: Theme.of(context).iconTheme.color,
                              )
                            : Icon(
                                EvaIcons.eye,
                                size: 30,
                                color: Theme.of(context).iconTheme.color,
                              ),
                      ),
                    ),
                    hintText: LangKeys.password.tr,
                    obscureText: validationController.obscurePassword.value,
                    prefixIcon: Icon(
                      EvaIcons.lock,
                      size: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onChanged: (value) {
                      validationController.onPasswordChanged(value);
                    }),
                AppErrorText(errorText: validationController.passwordError.tr),
                const SizedBox(height: 20),
                (validationController.isRegistrForm)
                    ? Column(
                        children: [
                          AppGradientBorderTextField(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  onPressed: () {
                                    validationController
                                        .changeShowConfirmPassword();
                                  },
                                  icon: (validationController
                                          .obscureConfirmPassword.value)
                                      ? Icon(
                                          EvaIcons.eye_off,
                                          size: 30,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        )
                                      : Icon(
                                          EvaIcons.eye,
                                          size: 30,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                ),
                              ),
                              obscureText: validationController
                                  .obscureConfirmPassword.value,
                              hintText: LangKeys.confirmPass.tr,
                              prefixIcon: Icon(
                                EvaIcons.lock_outline,
                                size: 30,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onChanged: (value) {
                                validationController
                                    .onConfirmPasswordChanged(value);
                              }),
                          AppErrorText(
                              errorText:
                                  validationController.confirmPasswordError.tr),
                          const SizedBox(height: 20),
                        ],
                      )
                    : Container(),
                AppElevatedGradientButton(
                  text: (validationController.isRegistrForm)
                      ? LangKeys.register.tr
                      : LangKeys.login.tr,
                  onTap: () {
                    validationController.validateAll();
                    if (validationController.isEmailValid &&
                        validationController.isPasswordValid) {
                      (validationController.isRegistrForm)
                          ? Get.find<SupabaseController>().signUp(
                              validationController.email,
                              validationController.password)
                          : Get.find<SupabaseController>().signIn(
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
                            await Get.find<SupabaseController>()
                                .signInWithGoogle();
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
                const SizedBox(height: 20),
                Text(
                    (validationController.isRegistrForm)
                        ? LangKeys.haveAccount.tr
                        : LangKeys.haveNotAccount.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () => validationController.changeForm(),
                    child: Text(
                        (validationController.isRegistrForm)
                            ? LangKeys.login.tr
                            : LangKeys.register.tr,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 20,
                                  color: Theme.of(context).iconTheme.color,
                                ))),
              ],
            ),
          ],
        ),
      );
    });
  }
}
