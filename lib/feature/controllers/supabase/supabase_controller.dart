import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/const/const.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/models/project.dart';
import 'package:flutter_task_manager/feature/models/user.dart';
import 'package:flutter_task_manager/feature/views/widgets/dialogs/error_supabase.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxController {
  Rx<SupabaseClient> supabase = Supabase.instance.client.obs;
  bool get isAuth => supabase.value.auth.currentUser != null;
  final currentUser = const ModelUser(id: 0, userName: '', roleId: 0).obs;

  final projects = <Project>[].obs;

  //Get all projects
  Future<void> getProjects() async {
    try {
      final response = await supabase.value.from('projects').select();
      projects.value = response.map((e) => Project.fromJson(e)).toList();
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    update();
  }

  //delete project
  Future<void> deleteProject(int id) async {
    try {
      await supabase.value.from('projects').delete().eq('id', id);
      await getProjects();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.value.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    update();
  }

  Future<void> signInWithGoogle() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
    update();
  }

  Future<void> signInWithGitHub() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.github,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
    update();
  }

  Future<void> signInWithGitLab() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.gitlab,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
    update();
  }

  Future<void> signOut() async {
    await supabase.value.auth.signOut();
    update();
  }

  Future<void> signUp(String email, String password) async {
    await supabase.value.auth.signUp(email: email, password: password);
    Get.dialog(
      AlertDialog(
        title: Text(
          LangKeys.success.tr,
          style: Get.context!.textTheme.headlineMedium!.copyWith(fontSize: 35),
        ),
        content: Text(LangKeys.checkEmailForConfirmation.tr,
            style: Get.context!.textTheme.titleMedium!.copyWith(fontSize: 25)),
        actions: [
          TextButton(
            onPressed: () {
              Get.find<ValidationController>().changeForm();
              Get.back();
            },
            child: Text(LangKeys.ok.tr,
                style:
                    Get.context!.textTheme.titleMedium!.copyWith(fontSize: 25)),
          ),
        ],
      ),
    );
    update();
  }

  Future<void> setCurrentAuthToTableUser() async {
    try {
      if (supabase.value.auth.currentUser == null) return;
      //Check if user already exists in the table
      final response = await supabase.value
          .from('users')
          .select()
          .eq('user_name', supabase.value.auth.currentUser!.email!);
      currentUser.value = ModelUser(
          id: response[0]['id'],
          userName: response[0]['user_name'],
          roleId: response[0]['role_id']);
      if (response.isNotEmpty) {
        // throw const PostgrestException(
        //   message: 'User already exists',
        // );
      } else {
        await supabase.value.from('users').insert({
          'user_name': supabase.value.auth.currentUser!.email,
          'role_id': 1,
        });
      }
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> createProject(String name) async {
    try {
      await supabase.value.from('projects').insert({
        'project_name': name,
        'owner_id': currentUser.value.id,
      });
      await getProjects();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }
}
