import 'package:delivery_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  CustomNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _initializeNotifications();
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon2');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: initializationSettingsIOS,
      ),
      onDidReceiveNotificationResponse: _onSelectNotofication,
    );
  }

  void _onSelectNotofication(NotificationResponse response) {
    if (response.payload != null) {
      debugPrint('notification payload: ${response.payload!}');
      Navigator.of(Routes.navigatorKey!.currentContext!)
          .pushNamed(response.payload!);
    }
  }

  showNotification(CustomNotification notification) {
    androidDetails = const AndroidNotificationDetails(
        'lembre_notification_x', 'Lembretes',
        channelDescription: 'Este Canal é para lembretes',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true);
    print('id: ${notification.id}, title: ${notification.title}, body: ${notification.body}');
    localNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(
          android: androidDetails,
        ),
        payload: notification.payload);
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotofication(details.notificationResponse!);
    }
  }
}
