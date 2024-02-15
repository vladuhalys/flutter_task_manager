import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxService {
  Rx<SupabaseClient> supabase = Supabase.instance.client.obs;
  bool get isAuth => supabase.value.auth.currentUser != null;

  Future<void> signIn() async {}
  Future<void> signInWithGoogle() async {}
  Future<void> logOut() async {}

  Future<void> signUp() async {}
}
