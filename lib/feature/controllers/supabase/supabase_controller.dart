import 'package:flutter_task_manager/core/const/const.dart';
import 'package:flutter_task_manager/core/router/router.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxController {
  Rx<SupabaseClient> supabase = Supabase.instance.client.obs;
  bool get isAuth => supabase.value.auth.currentUser != null;

  Future<void> signIn(String email, String password) async {
    await supabase.value.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
  }

  Future<void> signInWithGitHub() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.github,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
  }

  Future<void> signInWithGitLab() async {
    await supabase.value.auth.signInWithOAuth(
      OAuthProvider.gitlab,
      authScreenLaunchMode: LaunchMode.inAppWebView,
      redirectTo: AppConst.redirectedUrl,
    );
  }

  Future<void> signOut() async {
    await supabase.value.auth.signOut();
  }

  Future<void> signUp(String email, String password) async {
    await supabase.value.auth.signUp(email: email, password: password);
    if (supabase.value.auth.currentUser == null) {
      Get.snackbar('Error', 'Sign in failed');
    } else {
      Get.offNamed(AppRouter.home);
    }
  }
}
