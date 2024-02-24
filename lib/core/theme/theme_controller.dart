import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (ThemeMode.system == ThemeMode.dark) {
      isDark.value = true;
    } else {
      isDark.value = false;
    }
  }

  void changeTheme() {
    isDark.value = !isDark.value;
    if (isDark.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    update();
  }
}
