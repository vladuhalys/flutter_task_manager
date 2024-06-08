import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/views/widgets/text/app_text_error.dart';
import 'package:flutter_task_manager/feature/views/widgets/text_fields/app_graient_border_textfield.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TableDialogController extends GetxController {
  final _isTableValid = false.obs;
  final _errorText = ''.obs;
  final _tableName = ''.obs;

  bool get isTableValid => _isTableValid.value;
  String get errorText => _errorText.value;
  String get tableName => _tableName.value;

  void onTableNameChanged(String value) {
    value = value.trim();
    if (value.isEmpty) {
      _isTableValid.value = false;
      _errorText.value = LangKeys.emptyTableNameError;
    } else if (value.length < 3) {
      _isTableValid.value = false;
      _errorText.value = LangKeys.tableShortError;
    } else if (value.length > 20) {
      _isTableValid.value = false;
      _errorText.value = LangKeys.tableLengthError;
    } else {
      _tableName.value = value;
      _isTableValid.value = true;
      _errorText.value = '';
    }
    update();
  }
}

class AppTableDialog extends StatefulWidget {
  const AppTableDialog({super.key, this.table, required this.isEdit});

  final ModelTable? table;
  final bool isEdit;

  @override
  State<AppTableDialog> createState() => _AppTableDialogState();
}

class _AppTableDialogState extends State<AppTableDialog> {
  @override
  void initState() {
    super.initState();
    Get.put(TableDialogController());
    if (widget.isEdit) {
      Get.find<TableDialogController>()._tableName.value =
          widget.table!.tableName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableDialogController>(builder: (controller) {
      return AlertDialog(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          (widget.isEdit ? LangKeys.editTable : LangKeys.createTable).tr,
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
                  hintText: LangKeys.tableName.tr,
                  initialValue: (widget.isEdit) ? widget.table!.tableName : '',
                  keyboardType: TextInputType.text,
                  onChanged: controller.onTableNameChanged,
                  prefixIcon: Icon(
                    HeroIcons.table_cells,
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
                  .checkExistTable(controller.tableName)) {
                controller._isTableValid.value = false;
                controller._errorText.value = LangKeys.tableAlreadyExists.tr;
                controller.update();
              } else {
                if (!widget.isEdit) {
                  Get.find<SupabaseController>()
                      .createTable(controller.tableName);
                } else {
                  Get.find<SupabaseController>()
                      .editTable(widget.table!.id, controller.tableName);
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
