// ignore_for_file: unused_element

import 'package:flutter/material.dart';

extension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ShowDate on DateTime {
  String showDate(bool isUkr) {
    return '$day ${(isUkr) ? month.formatMonthUkr() : month.formatMonthEng()} $year';
  }

  String showTime() {
    toLocal().timeZoneOffset;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

extension MonthName on int {
  static const Map<int, List<String>> monthNames = {
    1: ['January', 'Січень'],
    2: ['February', 'Лютий'],
    3: ['March', 'Березень'],
    4: ['April', 'Квітень'],
    5: ['May', 'Травень'],
    6: ['June', 'Червень'],
    7: ['July', 'Липень'],
    8: ['August', 'Серпень'],
    9: ['September', 'Вересень'],
    10: ['October', 'Жовтень'],
    11: ['November', 'Листопад'],
    12: ['December', 'Грудень']
  };
  String formatMonthEng() {
    return monthNames[this]![0];
  }

  String formatMonthUkr() {
    return monthNames[this]![1];
  }
}
