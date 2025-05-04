import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsRequiredScreen extends StatefulWidget {
  const PermissionsRequiredScreen({super.key});

  @override
  State<PermissionsRequiredScreen> createState() => _PermissionsRequiredScreenState();
}


class _PermissionsRequiredScreenState extends State<PermissionsRequiredScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Для работы приложения требуется доступ к фото и видео.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: openAppSettings,
                child: const Text("Открыть настройки"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
