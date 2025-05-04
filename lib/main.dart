import 'package:flutter/material.dart';
import 'package:photo_clould/screens/main/main_screen.dart';
import 'package:photo_clould/screens/permissions-required/permission_required_screen.dart';
import 'package:photo_clould/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),      
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const SplashScreen(),
        '/permission_required': (context) => const PermissionsRequiredScreen(),
        '/main': (context) => const MainScreen()
      },
  
    );
  }
}
