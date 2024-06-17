import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/date_picker.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_icon_button.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TaskController extends GetxController {
  final _isTaskValid = false.obs;
  final _errorText = ''.obs;
  final _taskName = ''.obs;
  final _description = ''.obs;
  final selectedTableId = 0.obs;
  final listFiles = <File>[].obs;
  final filesIsNotEmpty = false.obs;

  bool get isTaskValid => _isTaskValid.value;
  String get errorText => _errorText.value;
  String get taskName => _taskName.value;
  String get description => _description.value;

  Future<void> uploadFiles() async {
    if (taskName.isEmpty) {
      _isTaskValid.value = false;
      _errorText.value = LangKeys.emptyTaskNameError;
    } else {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        filesIsNotEmpty.value = true;
        await Get.find<SupabaseController>().uploadFile(taskName, result);
      } else {
        // User canceled the picker
      }
    }
    update();
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

  void onDescriptionChanged(String value) {
    _description.value = value.trim();
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
        return GetBuilder<SupabaseController>(builder: (supabaseController) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        (!isEdit)
                            ? LangKeys.createTask.tr
                            : LangKeys.editTask.tr,
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
                          onChanged: controller.onDescriptionChanged),
                    ),
                    const SizedBox(height: 10.0),
                    const DatePicker(),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            LangKeys.uploadedFiles.tr,
                            style:
                                context.theme.textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        (supabaseController.filesUrl.isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: supabaseController.filesUrl.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      supabaseController.filesUrl[index],
                                      style: context
                                          .theme.textTheme.labelMedium!
                                          .copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontSize: 16,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        HeroIcons.x_circle,
                                        size: 25,
                                        color: context.theme.iconTheme.color,
                                      ),
                                      onPressed: () {
                                        supabaseController.files
                                            .removeAt(index);
                                        controller.listFiles.removeAt(index);
                                        if (supabaseController.files.isEmpty) {
                                          controller.filesIsNotEmpty.value =
                                              false;
                                        }
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    AppOutlineIconButton(
                      text: Text(
                        LangKeys.uploadedFiles.tr,
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
                    const SizedBox(height: 20.0),
                    AppElevatedGradientButton(
                        text: LangKeys.createTask.tr,
                        onTap: () {
                          if (controller.isTaskValid) {
                            if (isEdit) {
                              supabaseController.updateTask(
                                task!.id,
                                controller.taskName,
                                controller.description,
                                controller.selectedTableId.value,
                              );
                            } else {
                              supabaseController.createTask(
                                  controller.taskName,
                                  controller.description,
                                  controller.selectedTableId.value);
                            }
                            Get.back();
                          }
                        },
                        width: double.maxFinite,
                        height: 50.0),
                  ],
                ),
              )
            ],
          );
        });
      }),
    );
  }
}
