import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final Rxn<User> user = Rxn<User>();
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void onInit() {
    user.value = supabase.auth.currentUser;
    supabase.auth.onAuthStateChange.listen((data) {
      user.value = data.session?.user;
      if (user.value != null) {
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
    });
    super.onInit();
  }

  Future<void> signUp(String email, String password) async {
    try {
      final res = await supabase.auth.signUp(email: email, password: password);
      if (res.user != null) {
        Get.snackbar('Success', 'Account created!');
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      Get.snackbar('Signup Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(email: email, password: password);
      if (res.user != null) {
        Get.snackbar('Success', 'Logged in!');
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    user.value = null;
    Get.offAllNamed('/login');
  }
}
