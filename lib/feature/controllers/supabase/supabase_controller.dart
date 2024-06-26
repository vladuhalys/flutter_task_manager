import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/core/const/const.dart';
import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:flutter_task_manager/core/router/router.dart';
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
  final tasksForProject = <Task>[].obs;
  final filesUrl = <String, List<dynamic>>{}.obs;
  final comments = <dynamic>[].obs;
  final selectedDate = List<DateTime?>.empty().obs;
  final isLoadProject = false.obs;
  final isLoadTable = false.obs;
  final isLoadTask = false.obs;

  String getTableNameById(int id) {
    String result = '';
    for (var element in tablesForProject) {
      if (element.id == id) {
        result = element.tableName;
      }
    }
    return result;
  }

  ModelTable getTableById(int id) {
    ModelTable result = const ModelTable.empty();
    for (var element in tablesForProject) {
      if (element.id == id) {
        result = element;
      }
    }
    return result;
  }

  void clearAllTaskValues() {
    filesUrl.clear();
    selectedDate.clear();
    isLoadTask.value = false;
    update();
  }

  void onDateChanged(List<DateTime?> date) {
    selectedDate.value = date;
    update();
  }

  Future<void> createTask(
      String taskName, String description, int tableId) async {
    try {
      //check exist task
      final response = await supabase.value
          .from('tasks')
          .select()
          .eq('task_name', taskName)
          .eq('table_id', tableId);
      if(response.isEmpty)
      {
        await supabase.value.from('tasks').insert({
        'task_name': taskName,
        'description': description,
        'start_date': selectedDate[0].toString(),
        'end_date': selectedDate[1].toString(),
        'comments': comments,
        'table_id': tableId,
      });
      await getAllTask();
      }
      
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> updateTask(int id, String taskName, String description, int tableId) async {
    try {
      await supabase.value.from('tasks').update({
        'task_name': taskName,
        'description': description,
        'start_date': selectedDate[0].toString(),
        'end_date': selectedDate[1].toString(),
        'comments': comments,
        'table_id': tableId,
      }).eq('id', id);
       await getAllTask();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> createBucket(String name) async {
    try {
      if (!await checkExistBucket(name)) {
        await supabase.value.storage
            .createBucket(name, const BucketOptions(public: true));
      }
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<bool> checkExistBucket(String name) async {
    bool result = false;
    final List<Bucket> buckets = await supabase.value.storage.listBuckets();
    for (var element in buckets) {
      if (element.name == name) {
        result = true;
      }
    }
    return result;
  }

  Future<void> deleteBucket(String name) async {
    try {
      await supabase.value.storage.emptyBucket(name);
      await supabase.value.storage.deleteBucket(name);
      filesUrl.remove(name);
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> uploadFile(String bucketName, FilePickerResult? result) async {
    try {
      await createBucket(bucketName);
      if (result != null) {
        for (final file in result.files) {
          final fileBytes = file.bytes;
          if (fileBytes != null) {
            await supabase.value.storage
                .from(bucketName)
                .uploadBinary(file.name, fileBytes);
          }
        }
      }
      await getAllFiles();
    } on PostgrestException catch (error) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> deleteFile(String bucketName, String fileName) async {
    try {
      await supabase.value.storage.from(bucketName).remove([fileName]);
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<void> getAllFiles() async {
    try {
      final response = await supabase.value.storage.listBuckets();
      for (var element in response) {
        filesUrl[element.name]?.clear();
        filesUrl[element.name] = [];
        await getAllFilesByUrl(element.name);
      }
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<void> getAllFilesByUrl(String bucketName) async {
    try {
      final response = await supabase.value.storage.from(bucketName).list();
      final List<dynamic> files = [];
      for (var element in response) {
        String url = supabase.value.storage.from(bucketName).getPublicUrl(element.name);
        files.add(url);
      }
      filesUrl[bucketName]?.addAll(files);
      update();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
  }

  Future<void> getAllTask() async {
    try {
      final response = await supabase.value.from('tasks').select();
      tasksForProject.value = response.map((e) => Task.fromJson(e)).toList();
      await getAllFiles();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  Future<void> deleteTask(int id) async {
    try {
      await supabase.value.from('tasks').delete().eq('id', id);
      await getAllTask();
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    }
    update();
  }

  bool checkExistProject(String name) {
    bool result = false;
    for (var element in projects) {
      if (element.projectName == name) {
        result = true;
      }
    }
    return result;
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
      isLoadTable.value = true;
      update();
      final response = await supabase.value
          .from('tables')
          .select()
          .eq('project_id', currentProject.value.id).order('id', ascending: true);

      tablesForProject.value =
          response.map((e) => ModelTable.fromJson(e)).toList();
      isLoadTable.value = false;
      await getAllTask();
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

  Future<void> getCurrentUser() async{
    final response = await supabase.value
          .from('users')
          .select()
          .eq('user_name', supabase.value.auth.currentUser!.email!);
      currentUser.value = ModelUser(
          id: response[0]['id'],
          userName: response[0]['user_name'],
          roleId: response[0]['role_id']);
    update();
  }

  //Get all projects
  Future<void> getProjects() async {
    try {
      isLoadProject.value = true;
      await getCurrentUser();
      update();
      final response = await supabase.value
          .from('projects')
          .select().eq('owner_id', currentUser.value.id)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw const PostgrestException(
          message: 'Timeout request',
        );
      }).whenComplete(() {
        isLoadTable.value = false;
        update();
      });
      //await Future.delayed(const Duration(seconds: 2));
      projects.value = response.map((e) => Project.fromJson(e)).toList();
      isLoadProject.value = false;
      update();
    } on PostgrestException catch (error) {
      isLoadProject.value = false;
      update();
      Get.dialog(supabaseErrorDialog(error));
    } catch (e) {
      isLoadProject.value = false;
      update();
      Get.dialog(supabaseErrorDialog(
          PostgrestException(message: LangKeys.somethingWentWrong.tr)));
    }
    update();
  }

  Future<void> deleteTableByProjectId(int id) async {
    try {
      await supabase.value.from('tables').delete().eq('project_id', id);
    } on PostgrestException catch (error) {
      Get.dialog(supabaseErrorDialog(error));
    } catch (e) {
      isLoadProject.value = false;
      update();
      Get.dialog(supabaseErrorDialog(
          PostgrestException(message: LangKeys.somethingWentWrong.tr)));
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
    } catch (e) {
      isLoadProject.value = false;
      update();
      Get.dialog(supabaseErrorDialog(
          PostgrestException(message: LangKeys.somethingWentWrong.tr)));
    }
    update();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.value.auth
          .signInWithPassword(email: email, password: password);
          if(supabase.value.auth.currentUser != null)
          {
            Get.offAndToNamed(AppRouter.home);
          }
      //check auth
      if (supabase.value.auth.currentUser != null) {
         
      }
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
    supabase.value.auth.refreshSession();
    update();
    Get.offAndToNamed(AppRouter.login);
  }

  Future<void> signUp(String email, String password) async {
    await supabase.value.auth.signUp(email: email, password: password);
    if (supabase.value.auth.currentUser != null) {
      await setUserToTableUsers(email);
    }
    update();
    Get.dialog(
      AlertDialog(
        backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
        title: Text(
          LangKeys.success.tr,
          style: Get.context!.textTheme.headlineMedium!.copyWith(fontSize: 35),
        ),
        content: Text(LangKeys.thankYouForRegistering.tr,
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
  }

  Future<void> setUserToTableUsers(String email) async
  {
     final response = await supabase.value
          .from('users')
          .select()
          .eq('user_name', email);
      if (response.isEmpty) {
        await supabase.value.from('users').insert({
          'user_name': email,
          'role_id': 1,
        });
      }
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
    } catch (e) {
      isLoadProject.value = false;
      update();
      Get.dialog(supabaseErrorDialog(
          PostgrestException(message: LangKeys.somethingWentWrong.tr)));
    }
    update();
  }
}
