import 'package:daytask/auth/login_screen.dart';
import 'package:daytask/auth/signup_screen.dart';
import 'package:daytask/theme/Apptheme.dart';
import 'package:daytask/theme/ThemeController.dart';
import 'package:daytask/theme/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'auth/splash_screen.dart';
import 'auth/custom_signin_screen.dart';
import 'auth/custom_signup_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'auth/auth_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Supabase.initialize(
    url: 'https://iuwqewehybweoykudajy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1d3Fld2VoeWJ3ZW95a3VkYWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwNjE3MTIsImV4cCI6MjA2MDYzNzcxMn0.5nahvKkg2FxbfMLtgg45PCt2NyLRcZ3mK0SiWX3I5yQ',
  );

  // Initialize controllers
  Get.put(AuthController(), permanent: true);
  Get.put(ThemeController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: 'Mini TaskHub',
      debugShowCheckedModeBanner: false,

      // Light theme
      theme: AppTheme.lightTheme,


      darkTheme: AppTheme.darkTheme,


      themeMode: themeController.themeMode.value,


      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
      ],
    ));
  }
}