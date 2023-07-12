import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('reminder');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(int? id, int year, int month, int day, int hour,
      int min, String ampm, String title, String body) async {
    if (ampm == 'PM' && hour < 12) {
      hour += 12;
    }
    var dateTime = DateTime(
      year,
      month,
      day,
      hour,
      min,
      0,
    );

    tz.initializeTimeZones();

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // show(
    //   0,
    //   title,
    //   body,
    //   notificationDetails,
    // );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id!,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // void scheduledNotification(String title, String body) async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'channelId',
  //     'channelName',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     title,
  //     body,
  //     RepeatInterval.hourly,
  //     notificationDetails,
  //   );
  // }
  //
  void stopNotifications(int id) async {
    _flutterLocalNotificationsPlugin.cancel(id);
  }
}
