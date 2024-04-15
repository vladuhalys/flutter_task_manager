import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  static const Locale _ukrLocale = Locale('uk', 'UK');
  static const Locale _engLocale = Locale('en', 'US');
  static const Locale _defaultLocale = Locale('uk', 'UK');
  static const Locale _fallbackLocale = Locale('en', 'US');

  final _locale = Get.locale?.obs ?? const Locale('uk', 'UK').obs;

  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _locale.value = _defaultLocale;
  }

  void setLocale(Locale locale) {
    _locale.value = locale;
  }

  Locale getLocale() {
    return _locale.value;
  }

  Locale getFallbackLocale() {
    return _fallbackLocale;
  }

  Locale getUkrLocale() {
    return _ukrLocale;
  }

  Locale getEngLocale() {
    return _engLocale;
  }

  void setUkrLocale() {
    _locale.value = _ukrLocale;
    update();
  }

  void setEngLocale() {
    _locale.value = _engLocale;
    update();
  }

  void setDefaultLocale() {
    _locale.value = _defaultLocale;
    update();
  }

  void changeLocale() {
    _locale.value == _ukrLocale ? setEngLocale() : setUkrLocale();
    Get.updateLocale(_locale.value);
    update();
  }
}
