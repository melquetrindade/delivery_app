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
    gerDeviceFirebaseToken();
    _onMenssage();
  }

  gerDeviceFirebaseToken(){}

  _onMenssage(){}
}
