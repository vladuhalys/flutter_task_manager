import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_icon_button.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TaskController extends GetxController {
  final _isTaskValid = false.obs;
  final _errorText = ''.obs;
  final _taskName = ''.obs;
  final listFiles = <File>[].obs;
  final filesIsNotEmpty = false.obs;

  bool get isTaskValid => _isTaskValid.value;
  String get errorText => _errorText.value;
  String get taskName => _taskName.value;

  Future<void> uploadFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      listFiles.value = result.paths.map((path) => File(path!)).toList();
      filesIsNotEmpty.value = true;
      update();
    } else {
      // User canceled the picker
    }
  }

  void onTaskNameChanged(String value) {
    value = value.trim();
    if (value.isEmpty) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.emptyTaskNameError;
    } else if (value.length < 3) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.taskShortError;
    } else if (value.length > 20) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.taskLengthError;
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
    return Drawer(
      width: context.width * 0.5,
      child: GetBuilder<TaskController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      (!isEdit) ? LangKeys.createTask.tr : LangKeys.editTask.tr,
                      style: context.theme.textTheme.headlineMedium!.copyWith(
                        fontSize: 30,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      (isEdit) ? LangKeys.editTask.tr : LangKeys.taskName.tr,
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  AppGradientBorderTextField(
                      prefixIcon: Icon(
                        HeroIcons.clipboard,
                        size: 25,
                        color: context.theme.iconTheme.color,
                      ),
                      onChanged: controller.onTaskNameChanged),
                  AppErrorText(errorText: controller.errorText.tr),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Text(
                      LangKeys.description.tr,
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.2,
                    child: AppGradientBorderTextField(
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        onChanged: controller.onTaskNameChanged),
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          LangKeys.uploadedFiles.tr,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: controller.listFiles
                            .map((file) => Chip(
                                  label: Text(
                                    file.path.split('/').last,
                                    style: context.theme.textTheme.labelMedium!
                                        .copyWith(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 16,
                                    ),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).iconTheme.color,
                                  deleteIcon: Icon(
                                    HeroIcons.x_circle,
                                    size: 20,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  onDeleted: () {
                                    controller.listFiles.remove(file);
                                    controller.update();
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  AppOutlineIconButton(
                    text: Text(
                      'UPLOAD FILE',
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      controller.uploadFiles();
                    },
                    icon: Icon(HeroIcons.arrow_down_circle,
                        size: 25, color: context.theme.iconTheme.color),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
