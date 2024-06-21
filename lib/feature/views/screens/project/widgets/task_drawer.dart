import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/date_picker.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/drop_dawn.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_outline_icon_button.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class TaskController extends GetxController {
  final isTaskValid = false.obs;
  final _errorText = ''.obs;
  final taskName = ''.obs;
  final description = ''.obs;
  final selectedTableId = 0.obs;
  final listFiles = <File>[].obs;
  final filesIsNotEmpty = false.obs;
  final selectedTask = Task.empty().obs;
  final isEdit = false.obs;
  final commentText = ''.obs;
  final isEditOrCreateDone = false.obs;

  void clear() {
    taskName.value = '';
    description.value = '';
    selectedTask.value = Task.empty();
    listFiles.clear();
    filesIsNotEmpty.value = false;
    selectedTask.value = Task.empty();
    isEdit.value = false;
    commentText.value = '';
    isEditOrCreateDone.value = false;

    Get.find<SupabaseController>().selectedDate.value = [];
    Get.find<SupabaseController>().comments.clear();
    update();
  }

  String get errorText => _errorText.value;

  Future<void> uploadFiles() async {
    if (taskName.value.isEmpty) {
      isTaskValid.value = false;
      _errorText.value = LangKeys.emptyTaskNameError;
    } else {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        filesIsNotEmpty.value = true;
        await Get.find<SupabaseController>().uploadFile(taskName.value, result);
      }
    }
    update();
  }

  void onTaskNameChanged(String value) {
    value = value.trim();
    if (value.isEmpty) {
      isTaskValid.value = false;
      _errorText.value = LangKeys.emptyTaskNameError;
    } else if (value.length < 3) {
      isTaskValid.value = false;
      _errorText.value = LangKeys.taskShortError;
    } else if (value.length > 200) {
      isTaskValid.value = false;
      _errorText.value = LangKeys.taskLengthError;
    } else if (Get.find<SupabaseController>()
        .tasksForProject
        .any((element) => element.taskName == value)) {
      isTaskValid.value = false;
      _errorText.value = LangKeys.taskNameAlreadyExists;
    } else {
      taskName.value = value;
      isTaskValid.value = true;
      _errorText.value = '';
    }
    update();
  }

  void onDescriptionChanged(String value) {
    description.value = value.trim();
    update();
  }
}

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({super.key});
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
                      child: Row(
                        children: [
                          Text(
                            (!controller.isEdit.value)
                                ? LangKeys.createTask.tr
                                : LangKeys.editTaskForTable.tr,
                            style: context.theme.textTheme.headlineMedium!
                                .copyWith(
                              fontSize: 30,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          (controller.isEdit.value)
                              ? const Expanded(child: AppDropDawn())
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                      child: Text(
                        (controller.isEdit.value)
                            ? LangKeys.editTask.tr
                            : LangKeys.taskName.tr,
                        style: context.theme.textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    AppGradientBorderTextField(
                        readOnly: controller.isEdit.value,
                        initialValue: (controller.isEdit.value)
                            ? controller.selectedTask.value.taskName
                            : null,
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
                          initialValue: (controller.isEdit.value)
                              ? controller.selectedTask.value.description
                              : null,
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
                        (supabaseController.filesUrl.isNotEmpty &&
                                supabaseController
                                        .filesUrl[controller.taskName.value] !=
                                    null &&
                                supabaseController
                                    .filesUrl[controller.taskName.value]!
                                    .isNotEmpty &&
                                controller.isTaskValid.value)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: supabaseController
                                        .filesUrl[controller.taskName.value]
                                        ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () => js.context.callMethod('open', [
                                      supabaseController.filesUrl[
                                          controller.taskName.value]?[index]
                                    ]),
                                    child: ListTile(
                                      title: Text(
                                        supabaseController.filesUrl[
                                            controller.taskName.value]?[index],
                                        style: context
                                            .theme.textTheme.labelMedium!
                                            .copyWith(
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          fontSize: 16,
                                        ),
                                      ),
                                      leading: IconButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text: supabaseController.filesUrl[
                                                      controller.taskName.value]
                                                  ?[index]));
                                        },
                                        icon: Icon(
                                          HeroIcons.clipboard_document_check,
                                          size: 25,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          HeroIcons.x_circle,
                                          size: 25,
                                          color: AppColors.textError,
                                        ),
                                        onPressed: () {
                                          String file =
                                              supabaseController.filesUrl[
                                                      controller.taskName.value]
                                                  ?[index];
                                          final RegExp regex =
                                              RegExp(r'/([^/\\]+)$');
                                          final match = regex.firstMatch(file);
                                          String fileNameWithPattern = "";
                                          if (match != null) {
                                            fileNameWithPattern =
                                                match.group(1)!;
                                          }
                                          supabaseController.deleteFile(
                                              controller.taskName.value,
                                              fileNameWithPattern);
                                          supabaseController.filesUrl[
                                                  controller.taskName.value]
                                              ?.removeAt(index);
                                          controller.isEditOrCreateDone.value =
                                              true;
                                          supabaseController.update();
                                        },
                                      ),
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
                        if (controller.taskName.value.isNotEmpty) {
                          controller.uploadFiles();
                        } else {
                          controller.isTaskValid.value = false;
                          controller._errorText.value =
                              LangKeys.emptyTaskNameError;
                          controller.update();
                        }
                      },
                      icon: Icon(HeroIcons.arrow_down_circle,
                          size: 25, color: context.theme.iconTheme.color),
                    ),
                    const SizedBox(height: 20.0),
                    (supabaseController.comments.isEmpty)
                        ? Center(
                            child: Text(
                              LangKeys.noComments.tr,
                              style:
                                  context.theme.textTheme.labelMedium!.copyWith(
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: supabaseController.comments.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: supabaseController
                                            .comments[index]));
                                  },
                                  icon: Icon(
                                    HeroIcons.chat_bubble_left,
                                    size: 25,
                                    color: context.theme.iconTheme.color,
                                  ),
                                ),
                                title: Text(
                                  supabaseController.comments[index],
                                  style: context.theme.textTheme.labelMedium!
                                      .copyWith(
                                    color: Theme.of(context).iconTheme.color,
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    HeroIcons.x_circle,
                                    size: 25,
                                    color: AppColors.textError,
                                  ),
                                  onPressed: () {
                                    supabaseController.comments.removeAt(index);
                                    supabaseController.update();
                                  },
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: AppGradientBorderTextField(
                            initialValue: controller.commentText.value,
                            prefixIcon: Icon(
                              HeroIcons.chat_bubble_left_right,
                              size: 25,
                              color: context.theme.iconTheme.color,
                            ),
                            onChanged: (value) {
                              controller.commentText.value = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        AppOutlineIconButton(
                          text: Text(
                            LangKeys.addComment.tr,
                            style:
                                context.theme.textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            if (controller.commentText.value.isNotEmpty) {
                              supabaseController.comments
                                  .add(controller.commentText.value);
                              supabaseController.update();
                              controller.commentText.value = '';
                              controller.update();
                              supabaseController.update();
                            }
                          },
                          icon: Icon(HeroIcons.plus_small,
                              size: 25, color: context.theme.iconTheme.color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    AppElevatedGradientButton(
                        text: (controller.isEdit.value)
                            ? LangKeys.editTask.tr
                            : LangKeys.createTask.tr,
                        onTap: () {
                          if (controller.isTaskValid.value) {
                            if (controller.isEdit.value) {
                              controller.selectedTableId.value =
                                  Get.find<DropDawnController>()
                                      .getSelectedTableId;
                              supabaseController.updateTask(
                                controller.selectedTask.value.id,
                                controller.taskName.value,
                                controller.description.value,
                                controller.selectedTableId.value,
                              );
                            } else {
                              supabaseController.createTask(
                                  controller.taskName.value,
                                  controller.description.value,
                                  controller.selectedTableId.value);
                            }
                            controller.isEditOrCreateDone.value = true;
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
