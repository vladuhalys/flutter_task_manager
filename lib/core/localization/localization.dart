import 'package:flutter_task_manager/core/localization/english/eng.dart';
import 'package:flutter_task_manager/core/localization/ukrainian/ukr.dart';
import 'package:get/get.dart';

class AppLocalization extends Translations {
  static const List<String> languages = ['en_US', 'uk_UK'];
  @override
  Map<String, Map<String, String>> get keys => {
        languages[0]: English.values,
        languages[1]: Ukrainian.values,
      };
}
