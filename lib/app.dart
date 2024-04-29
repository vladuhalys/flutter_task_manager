import 'package:flutter/material.dart';
import 'package:flutter_task_manager/app_bindings.dart';
import 'package:flutter_task_manager/core/localization/localization.dart';
import 'package:flutter_task_manager/core/router/router.dart';
import 'package:flutter_task_manager/core/theme/theme.dart';
import 'package:flutter_task_manager/feature/views/screens/error/error_screen.dart';
import 'package:flutter_task_manager/feature/views/screens/export_screen.dart';
import 'package:flutter_task_manager/feature/views/screens/screen.dart';

import 'package:get/get.dart';

class Application extends GetWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.authRout,
        initialBinding: AppBindins(),
        translations: AppLocalization(), // your translations
        locale:
            Get.deviceLocale, // translations will be displayed in that locale
        fallbackLocale: const Locale('en', 'US'),
        title: 'Task Manager',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        getPages: [
          GetPage(name: AppRouter.home, page: () => const HomeScreen()),
          GetPage(name: AppRouter.login, page: () => LoginScreen()),
          GetPage(name: AppRouter.authRout, page: () => const AuthRoutScreen()),
          GetPage(
              name: AppRouter.error,
              page: () => const ErrorScreen(errorText: '')),
        ]);
  }
}
