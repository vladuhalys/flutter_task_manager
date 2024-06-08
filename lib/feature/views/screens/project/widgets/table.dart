import 'package:flutter/material.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/views/screens/project/widgets/popup.dart';
import 'package:get/get.dart';

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
                padding: const EdgeInsets.all(10),
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
            ],
          ),
        );
      },
    );
  }
}
