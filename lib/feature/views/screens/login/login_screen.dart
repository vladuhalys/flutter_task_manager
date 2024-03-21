import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/views/screens/error/error_screen.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/cards/app_gradient_border_card.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LoginScreen extends GetResponsiveWidget<ThemeController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return GetBuilder<ValidationController>(
      builder: (validationController) {
        return (screen.isPhone || screen.isTablet || screen.height < 700)
            ? const ErrorScreen(
                errorText:
                    'Mobile View & Tablet View are not supported yet. Please use a desktop or laptop to view this page.',
              )
            : Scaffold(
                appBar: AppBar(
                    title: Text(
                  'Satoshi',
                  style: Theme.of(context).textTheme.titleMedium,
                )),
                body: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: screen.width * 0.5,
                        child: const ModelViewer(
                          alt: 'A 3D model of a shiba inu',
                          arModes: ['scene-viewer', 'webxr', 'quick-look'],
                          src: 'assets/3d/shiba.glb',
                        ),
                      ),
                      AppGradientBorderCard(
                        width: screen.width * 0.4,
                        height: 500,
                        gradients: [
                          AppColors.btnGradientStart,
                          AppColors.btnGradientEnd
                        ],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text('Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 35)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, bottom: 50.0),
                              child: Text('Welcome back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 25)),
                            ),
                            Column(
                              children: [
                                AppGradientBorderTextField(
                                    hintText: "Email",
                                    prefixIcon: Icon(
                                      EvaIcons.email,
                                      size: 30,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onChanged: (value) {
                                      validationController
                                          .onEmailChanged(value);
                                    }),
                                AppErrorText(
                                    errorText: validationController.emailError),
                                const SizedBox(height: 10),
                                AppGradientBorderTextField(
                                    hintText: "Password",
                                    obscureText: true,
                                    prefixIcon: Icon(
                                      EvaIcons.lock,
                                      size: 30,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onChanged: (value) {
                                      validationController
                                          .onPasswordChanged(value);
                                    }),
                                AppErrorText(
                                    errorText:
                                        validationController.passwordError),
                                const SizedBox(height: 10),
                                AppElevatedGradientButton(
                                  text: 'Login',
                                  onTap: () {
                                    validationController.validateAll();
                                    controller.changeTheme();
                                  },
                                  width: Get.mediaQuery.size.width,
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
