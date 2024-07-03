import 'package:flutter/material.dart';
import 'package:flutter_application_1/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => NotificationService.showInstantNotification("Instant Notification", "This shows an instant notification"),
                child: const Text("Show Notification"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  DateTime scheduledTime = DateTime.now().add(const Duration(seconds: 5));
                  NotificationService.scheduleNotification("Scheduled Notification", "This notification is a scheduled notification", scheduledTime);
                },
                child: const Text("Schedule Notification"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
