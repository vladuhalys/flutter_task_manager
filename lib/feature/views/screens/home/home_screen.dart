import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/router/router.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/views/widgets/buttons/app_elevated_gradient_btn.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppElevatedGradientButton(
          text: "Sign Out",
          onTap: () async {
            await Get.find<SupabaseController>().signOut();
            Get.offAllNamed(AppRouter.authRout);
          },
          width: 200,
          height: 50,
        ),
      ),
    );
  }
}
