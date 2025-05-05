import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_clould/screens/gallery/gallery_screen.dart';
import 'package:photo_clould/screens/permissions-required/permission_required_screen.dart';
import 'package:photo_clould/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setSystemUIStyle(); // Установить при запуске
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _setSystemUIStyle(); // Обновить, если тема изменилась
  }

  void _setSystemUIStyle() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final isDark = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, 
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, 
      routes: {
        '/': (context) => const SplashScreen(),
        '/permission_required': (context) => const PermissionsRequiredScreen(),
        '/gallery': (context) => const GalleryScreen()
      },
    );
  }
}
