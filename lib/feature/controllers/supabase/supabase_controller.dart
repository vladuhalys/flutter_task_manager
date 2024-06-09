import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/const/const.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/feature/controllers/validation/validation_controller.dart';
import 'package:flutter_task_manager/feature/models/project.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:flutter_task_manager/feature/models/task.dart';
import 'package:flutter_task_manager/feature/models/user.dart';
import 'package:flutter_task_manager/feature/views/widgets/dialogs/error_supabase.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxController {
  Rx<SupabaseClient> supabase = Supabase.instance.client.obs;
  bool get isAuth => supabase.value.auth.currentUser != null;
  final currentUser = const ModelUser(id: 0, userName: '', roleId: 0).obs;
  final projects = <Project>[].obs;
  final currentProject = const Project(id: 0, projectName: '', ownerId: 0).obs;
  final tablesForProject = <ModelTable>[].obs;
  final tasksForProject = <int, List<Task>>{}.obs;

  Future<void> getTasksByTableId(int id) async {
    try {
      final response = await supabase.value
          .from('tasks')
          .select()
          .eq('table_id', id)
          .order('id', ascending: false);
      tasksForProject[id] = response.map((e) => Task.fromJson(e)).toList();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  bool checkExistTable(String name) {
    bool result = false;
    for (var element in tablesForProject) {
      if (element.tableName == name) {
        result = true;
      }
    }
    return result;
  }

  Future<void> editTable(int id, String name) async {
    try {
      await supabase.value
          .from('tables')
          .update({'table_name': name}).eq('id', id);
      await getTables();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> deleteTable(int id) async {
    try {
      await supabase.value.from('tables').delete().eq('id', id);
      await getTables();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> getTables() async {
    try {
      final response = await supabase.value
          .from('tables')
          .select()
          .eq('project_id', currentProject.value.id);
      tablesForProject.value =
          response.map((e) => ModelTable.fromJson(e)).toList();
      update();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<void> setCurrentProject(int id) async {
    final response =
        await supabase.value.from('projects').select().eq('id', id);
    currentProject.value = Project.fromJson(response[0]);
    update();
  }

  Future<void> createTable(String name) async {
    try {
      final response = await supabase.value
          .from('tables')
          .select()
          .eq('project_id', currentProject.value.id)
          .eq('table_name', name);
      if (response.isEmpty) {
        await supabase.value.from('tables').insert({
          'table_name': name,
          'project_id': currentProject.value.id,
        });
        update();
        await getTables();
      } else {
        Get.dialog(
          AlertDialog(
            backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
            title: Text(
              LangKeys.errorTable.tr,
              style:
                  Get.context!.textTheme.headlineMedium!.copyWith(fontSize: 35),
            ),
            content: Text(LangKeys.tableAlreadyExists.tr,
                style:
                    Get.context!.textTheme.titleMedium!.copyWith(fontSize: 25)),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(LangKeys.ok.tr,
                    style: Get.context!.textTheme.titleMedium!
                        .copyWith(fontSize: 25)),
              ),
            ],
          ),
        );
      }
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<void> editProject(int id, String name) async {
    try {
      await supabase.value
          .from('projects')
          .update({'project_name': name}).eq('id', id);
      await getProjects();
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

  //Get all projects
  Future<void> getProjects() async {
    try {
      final response = await supabase.value.from('projects').select();
      projects.value = response.map((e) => Project.fromJson(e)).toList();
    } catch (e) {
      Get.dialog(
        AlertDialog(
          backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
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

  Future<void> deleteTableByProjectId(int id) async {
    try {
      await supabase.value.from('tables').delete().eq('project_id', id);
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  //delete project
  Future<void> deleteProject(int id) async {
    try {
      await deleteTableByProjectId(id);
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
          backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
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
        backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
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
}
