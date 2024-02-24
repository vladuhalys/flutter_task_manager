import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/logger/logger_controller.dart';
import 'package:get/get.dart';

class AppBindins extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LoggerController>(() => LoggerController());
  }
}
