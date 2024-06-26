import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/extension/extension.dart';
import 'package:flutter_task_manager/core/localization/controller/localization_controller.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/drop_dawn.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/task_drawer.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10,10,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${LangKeys.task.tr} #${task.id}: ${task.taskName}',
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    HeroIcons.pencil_square,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    Get.find<TaskController>().taskName.value = task.taskName;
                    Get.find<TaskController>().description.value = task.description;
                    Get.find<TaskController>().selectedTask.value = task;
                    Get.find<TaskController>().isEdit.value = true;
                    Get.find<TaskController>().isTaskValid.value = true;
                    Get.find<TaskController>().selectedTableId.value = task.tableId;
                    Get.find<SupabaseController>().selectedDate.value = [task.startDate, task.endDate];
                    Get.find<SupabaseController>().comments.value = task.comments;
                    Get.find<DropDawnController>().setItems(Get.find<SupabaseController>().tablesForProject);
                    Get.find<DropDawnController>().setSelectedItemText(Get.find<SupabaseController>().getTableNameById(task.tableId));
                    Get.find<DropDawnController>().setSelectedItem(Get.find<SupabaseController>().getTableById(task.tableId));
                    Get.find<DropDawnController>().setSelectedTableId(task.tableId);
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ],
            ),
          ),
          Divider(color: Colors.blueAccent.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              (task.description.isNotEmpty) ? task.description : LangKeys.emptyDescription.tr,
              style: context.theme.textTheme.labelMedium!.copyWith(
                color: Theme.of(context).iconTheme.color,
                fontSize: 14,
              ),
            ),
          ),
          Divider(color: Colors.blueAccent.withOpacity(0.5)),
           Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 25, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LangKeys.comments.tr}: ${task.comments.length}',
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                  ),
                ),
                 Text(
                  '${LangKeys.files.tr}: ${Get.find<SupabaseController>().filesUrl[task.taskName]?.length ?? 0}',
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.blueAccent.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${task.startDate.toLocal().showDate(Get.find<LocalizationController>().isUkrLocale)}  -  ${task.endDate.toLocal().showDate(Get.find<LocalizationController>().isUkrLocale)}",
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    HeroIcons.trash,
                    color: AppColors.textError,
                  ),
                  onPressed: () {
                    Get.find<SupabaseController>().deleteBucket(task.taskName);
                    Get.find<SupabaseController>().deleteTask(task.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}