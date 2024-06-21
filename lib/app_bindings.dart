import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/core/theme/theme_controller.dart';
import 'package:flutter_task_manager/feature/controllers/logger/logger_controller.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:get/get.dart';

class AppBindins extends Bindings {
  @override
  void dependencies() {
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<LoggerController>(LoggerController(), permanent: true);
    Get.put<ValidationController>(ValidationController(), permanent: true);
    Get.put<LocalizationController>(LocalizationController(), permanent: true);
    Get.put<SupabaseController>(SupabaseController(), permanent: true);
  }
}
