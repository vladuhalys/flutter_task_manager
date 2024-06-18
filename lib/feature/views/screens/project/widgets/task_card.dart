import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/theme/app_colors/app_colors.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
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
        color: Colors.blueAccent.withOpacity(0.5),
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
                Text(
                  task.taskName,
                  style: context.theme.textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    HeroIcons.pencil_square,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {},
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
            padding: const EdgeInsets.fromLTRB(10,0,10,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  task.endDate.toString(),
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}