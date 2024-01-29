import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const androidNotificationDetails = AndroidNotificationDetails(
      'schedule',
      'schedule time.on',
      channelDescription: 'repeating description',
      importance: Importance.max,
      playSound: true,
    );

    const darwinNotificationDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    return notificationDetails;
  }

  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required TimeOfDay reminderTime,
  }) async {
    final details = await _notificationDetails();
    final reminderDuration = Duration(
      hours: reminderTime.hour,
      minutes: reminderTime.minute,
    );

    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(
              scheduledTime.subtract(reminderDuration), tz.local),
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print(e);
    }
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
    }
  }

  Future<void> updateScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required TimeOfDay reminderTime,
  }) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(id);

      showScheduledNotification(
        body: body,
        title: title,
        scheduledTime: scheduledTime,
        reminderTime: reminderTime,
        id: id,
      );
    } catch (e) {
      print(e);
    }
  }
}
