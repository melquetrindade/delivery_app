import 'package:delivery_app/routes/routes.dart';
import 'package:delivery_app/services/notificationsLocal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMenssage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('============================');
    print('token: ${token}');
    print('============================');
  }

  _onMenssage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationService.showNotification(CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? ''));
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}
