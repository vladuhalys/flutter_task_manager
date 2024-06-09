import 'package:flutter/material.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:get/get.dart';

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({super.key, required this.isEdit, this.task});

  final bool isEdit;
  final Task? task;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(builder: (controller) {
      return Drawer(
        width: context.width * 0.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [],
        ),
      );
    });
  }
}
