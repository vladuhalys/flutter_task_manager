import 'package:flutter/widgets.dart';
import 'package:flutter_task_manager/feature/controllers/supabase/supabase_controller.dart';
import 'package:flutter_task_manager/feature/views/screens/home/home_screen.dart';
import 'package:flutter_task_manager/feature/views/screens/login/login_screen.dart';
import 'package:get/get.dart';

class AuthRoutScreen extends StatelessWidget {
  const AuthRoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      builder: (supabaseController) {
        return supabaseController.isAuth ? const HomeScreen() : LoginScreen();
      },
    );
  }
}
