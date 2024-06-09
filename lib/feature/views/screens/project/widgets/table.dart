import 'package:flutter/material.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/popup.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.table});

  final ModelTable table;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      builder: (controller) {
        return Container(
          width: context.width * 0.25,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.5),
              width: 2,
            ),
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
              if (controller.tasksForProject[table.id]?.isNotEmpty ?? false)
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        controller.tasksForProject[table.id]?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            color: Colors.blueAccent.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          controller.tasksForProject[table.id]![index].taskName,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              TextButton.icon(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  label: Text('Add Task',
                      style: context.theme.textTheme.labelMedium!
                          .copyWith(fontSize: 16.0)),
                  icon: Icon(HeroIcons.plus_circle,
                      size: 20.0, color: context.textTheme.labelMedium!.color)),
            ],
          ),
        );
      },
    );
  }
}
