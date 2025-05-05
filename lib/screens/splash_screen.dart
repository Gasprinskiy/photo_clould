import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    bool granted = false;

    final prefs = await SharedPreferences.getInstance();
    final alreadyAsked = prefs.getBool('asked_photos_permission') ?? false;

    if (alreadyAsked) {
      granted = await Permission.photos.isGranted && await Permission.videos.isGranted;
    } else {
      await prefs.setBool('asked_photos_permission', true);
      granted = await Permission.photos.request().isGranted && await Permission.videos.request().isGranted;
    }

    if (granted) {
      Navigator.pushReplacementNamed(context, "/gallery");
    } else {
      Navigator.pushReplacementNamed(context, "/permission_required");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
          backgroundColor: colorScheme.primaryContainer,
        ),
      ),
    );
  }
}