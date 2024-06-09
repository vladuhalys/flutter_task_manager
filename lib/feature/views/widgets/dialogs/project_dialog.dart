import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/project.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class ProjectDialogController extends GetxController {
  final _isProjectValid = false.obs;
  final _errorText = ''.obs;
  final _projectName = ''.obs;

  bool get isProjectValid => _isProjectValid.value;
  String get errorText => _errorText.value;
  String get projectName => _projectName.value;

  void onTableNameChanged(String value) {
    value = value.trim();
    if (value.isEmpty) {
      _isProjectValid.value = false;
      _errorText.value = LangKeys.emptyProjectNameError;
    } else if (value.length < 3) {
      _isProjectValid.value = false;
      _errorText.value = LangKeys.projectShortError;
    } else if (value.length > 20) {
      _isProjectValid.value = false;
      _errorText.value = LangKeys.projectLengthError;
    } else {
      _projectName.value = value;
      _isProjectValid.value = true;
      _errorText.value = '';
    }
    update();
  }
}

class AppProjectDialog extends StatefulWidget {
  const AppProjectDialog({super.key, this.project, required this.isEdit});

  final Project? project;
  final bool isEdit;

  @override
  State<AppProjectDialog> createState() => _AppProjectDialogState();
}

class _AppProjectDialogState extends State<AppProjectDialog> {
  @override
  void initState() {
    super.initState();
    Get.put(ProjectDialogController());
    if (widget.isEdit) {
      Get.find<ProjectDialogController>()._projectName.value =
          widget.project!.projectName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDialogController>(builder: (controller) {
      return AlertDialog(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          (widget.isEdit ? LangKeys.editProject : LangKeys.createNewProject).tr,
          style: context.theme.textTheme.headlineMedium!.copyWith(fontSize: 25),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: context.width * 0.5,
            height: 80,
            child: Column(
              children: [
                AppGradientBorderTextField(
                  hintText: LangKeys.projectName.tr,
                  initialValue:
                      (widget.isEdit) ? widget.project!.projectName : '',
                  keyboardType: TextInputType.text,
                  onChanged: controller.onTableNameChanged,
                  prefixIcon: Icon(
                    HeroIcons.folder,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                AppErrorText(errorText: controller.errorText.tr),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              LangKeys.cancel.tr,
              style:
                  context.theme.textTheme.labelMedium!.copyWith(fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              if (Get.find<SupabaseController>()
                  .checkExistTable(controller.projectName)) {
                controller._isProjectValid.value = false;
                controller._errorText.value = LangKeys.tableAlreadyExists.tr;
                controller.update();
              } else {
                if (!widget.isEdit) {
                  Get.find<SupabaseController>()
                      .createProject(controller.projectName);
                } else {
                  Get.find<SupabaseController>()
                      .editProject(widget.project!.id, controller.projectName);
                }
                Get.back();
              }
            },
            child: Text(
              LangKeys.ok.tr,
              style: context.theme.textTheme.headlineMedium!
                  .copyWith(fontSize: 20),
            ),
          ),
        ],
      );
    });
  }
}
