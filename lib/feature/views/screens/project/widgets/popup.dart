import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/views/widgets/dialogs/table_dialog.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TablePopUp extends StatelessWidget {
  const TablePopUp({super.key, required this.table});

  final ModelTable table;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          context.theme.scaffoldBackgroundColor,
        ),
      ),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Icon(
            Icons.more_horiz,
            color: context.theme.iconTheme.color,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
            child: Row(
              children: [
                Icon(
                  HeroIcons.pencil,
                  color: context.theme.iconTheme.color,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(LangKeys.editTable.tr,
                    style: context.theme.textTheme.bodyMedium!
                        .copyWith(color: context.theme.iconTheme.color)),
              ],
            ),
            onPressed: () {
              Get.dialog(AppTableDialog(table: table, isEdit: true));
            }),
        MenuItemButton(
            child: Row(
              children: [
                Icon(
                  HeroIcons.trash,
                  color: AppColors.textError,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(LangKeys.deleteTable.tr,
                    style: context.theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.textError)),
              ],
            ),
            onPressed: () {
              Get.find<SupabaseController>().deleteTable(table.id);
            }),
      ],
    );
  }
}
