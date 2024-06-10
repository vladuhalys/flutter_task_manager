import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TaskController extends GetxController {
  final _isTaskValid = false.obs;
  final _errorText = ''.obs;
  final _taskName = ''.obs;

  bool get isTaskValid => _isTaskValid.value;
  String get errorText => _errorText.value;
  String get taskName => _taskName.value;

  void onTableNameChanged(String value) {
    value = value.trim();
    if (value.isEmpty) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.emptyProjectNameError;
    } else if (value.length < 3) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.projectShortError;
    } else if (value.length > 20) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.projectLengthError;
    } else {
      _taskName.value = value;
      _isTaskValid.value = true;
      _errorText.value = '';
    }
    update();
  }
}

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({super.key, required this.isEdit, this.task});

  final bool isEdit;
  final Task? task;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (controller) {
      return Drawer(
        width: context.width * 0.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                AppGradientBorderTextField(
                    hintText:
                        (isEdit) ? LangKeys.editTask.tr : LangKeys.taskName.tr,
                    prefixIcon: Icon(
                      HeroIcons.puzzle_piece,
                      size: 25,
                      color: context.theme.iconTheme.color,
                    ),
                    onChanged: (value) {}),
                AppErrorText(errorText: controller.errorText),
              ],
            )
          ],
        ),
      );
    });
  }
}
