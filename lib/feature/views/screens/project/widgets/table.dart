import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/popup.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/task_card.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/task_drawer.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.table});

  final ModelTable table;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      builder: (controller) {
        final tasks = controller.tasksForProject
            .where((element) => element.tableId == table.id)
            .toList();
        return Container(
          width: context.width * 0.25,
          height: context.height * 0.8,
          decoration: BoxDecoration(
            color: context.theme.iconTheme.color!.withOpacity(0.05),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            // border: Border.all(
            //   color: Colors.blueAccent.withOpacity(0.5),
            //   width: 2,
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      table.tableName,
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 16,
                      ),
                    ),
                    TablePopUp(table: table),
                  ],
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    Get.find<TaskController>().selectedTableId.value = table.id;
                    Get.find<TaskController>().isEdit.value = false;
                    Get.find<TaskController>().isEditOrCreateDone.value = false;
                    Get.find<TaskController>().clear();
                    Scaffold.of(context).openEndDrawer();
                  },
                  label: Text(LangKeys.createTask.tr,
                      style: context.theme.textTheme.labelMedium!
                          .copyWith(fontSize: 16.0)),
                  icon: Icon(HeroIcons.plus_small,
                      size: 20.0, color: context.textTheme.labelMedium!.color)),
              if (tasks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        tasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TaskCard(task: tasks[index]),
                      );
                    },
                  ),
                ), 
            ],
          ),
        );
      },
    );
  }
}
