import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/extension/extension.dart';
import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:get/get.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  static const List<String> ukrDays = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Нд'
  ];
  static const List<String> engDays = [
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su'
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(builder: (supabaseController) {
      return CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          controlsTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
          ),
          monthBuilder: (
              {decoration,
              isCurrentMonth,
              isDisabled,
              isSelected,
              required month,
              textStyle}) {
            return Center(
              child: Text(
                Get.find<LocalizationController>().isUkrLocale
                    ? month.formatMonthUkr()
                    : month.formatMonthEng(),
                style: textStyle,
              ),
            );
          },
          weekdayLabelTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          weekdayLabels: Get.find<LocalizationController>().isUkrLocale
              ? ukrDays
              : engDays,
          disabledDayTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
          ),
          dayTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
          ),
          yearTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
          ),
          monthTextStyle: context.theme.textTheme.labelMedium!.copyWith(
            color: Theme.of(context).iconTheme.color,
            fontSize: 14,
          ),
          useAbbrLabelForMonthModePicker: true,
          selectedDayHighlightColor: Colors.blue,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          calendarType: CalendarDatePicker2Type.range,
        ),
        value: supabaseController.selectedDate,
        onValueChanged: (date) => supabaseController.onDateChanged(date),
      );
    });
  }
}
