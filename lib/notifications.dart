import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
class NotificationService {
  //Initialize the FlutterLocalNotificationPlugin Instance
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotificationResponse(NotificationResponse) async {}

  //Initialize the notification plugin
  static Future<void> init() async {
    //Define the Android Initialization Settings
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    //Define the iOS Initialization Settings
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings();

    //Combine Android and iOS Initialization Settings
    const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iOSInitializationSettings);

    //Initialize the plugin with the specified settings
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse, 
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  //Show instant notification
  static Future<void> showInstantNotification(String title, String body) async {
    //Define Notification Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId_1", 
        "Instant Notification",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  //Show a Schedule Notification
  static Future<void> scheduleNotification(String title, String body, DateTime scheduledTime) async {
    //Define Notification Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId", 
        "Scheduled Notification",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true)
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      10, 
      title, 
      body, 
      tz.TZDateTime.from(scheduledTime, tz.local), 
      platformChannelSpecifics, 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}