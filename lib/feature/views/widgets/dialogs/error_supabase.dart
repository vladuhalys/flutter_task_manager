import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Widget supabaseErrorDialog(PostgrestException error) {
  return AlertDialog(
    title: Text(
      LangKeys.errorFromSupabase.tr,
      style: Get.context!.textTheme.headlineMedium!.copyWith(fontSize: 35),
    ),
    content: Text(error.message,
        style: Get.context!.textTheme.titleMedium!.copyWith(fontSize: 25)),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(LangKeys.ok.tr,
            style: Get.context!.textTheme.titleMedium!.copyWith(fontSize: 25)),
      ),
    ],
  );
}
