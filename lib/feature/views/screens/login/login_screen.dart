import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/views/screens/error/error_screen.dart';
import 'package:flutter_task_manager/feature/views/screens/login/widgets/sign_in_card.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LoginScreen extends GetResponsiveWidget<ThemeController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screen.context = context;
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return (screen.isPhone || screen.isTablet || screen.height < 700)
            ? ErrorScreen(
                errorText: LangKeys.errorViewScale.tr,
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    LangKeys.appTitle,
                    style: context.theme.textTheme.headlineMedium!.copyWith(
                      fontSize: 30,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextButton(
                        child: Text(
                          LangKeys.lang.tr,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          localizationController.changeLocale();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        icon: Icon(
                          controller.isDark.value
                              ? EvaIcons.sun
                              : EvaIcons.moon,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                          controller.changeTheme();
                        },
                      ),
                    ),
                  ],
                ),
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
                      const SignInCard(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
