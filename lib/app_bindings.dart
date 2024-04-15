import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/logger/logger_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:get/get.dart';

class AppBindins extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LoggerController>(() => LoggerController());
    Get.lazyPut<ValidationController>(() => ValidationController());
    Get.lazyPut<LocalizationController>(() => LocalizationController());
  }
}
