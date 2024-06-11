import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/databases/db_firestore.dart';
import 'package:delivery_app/routes/routes.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:delivery_app/services/notificationsLocal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;
  late AuthService auth;
  late FirebaseFirestore db;
  bool jaCarregou = false;

  FirebaseMessagingService(this._notificationService, this.auth);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    await _startFirestore();
    getDeviceFirebaseToken();
    _onMenssage();
    _onMessageOpenedApp();
    jaCarregou = true;
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  getDeviceFirebaseToken() async {
    print('entrou no get token');
    final token = await FirebaseMessaging.instance.getToken();
    final snapshot = await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/device').get();
    if (snapshot.docs.length == 1) {
      print('entrou no 1º if do get token');
      if (token != snapshot.docs[0]['token']) {
        print('entrou no 2º if do get token');
        await db
            .collection('loja/usuarios/clientes/${auth.usuario!.uid}/device')
            .doc('tokenDevice')
            .update({'token': token});
      }
    } else {
      print('entrou no else do get token');
      await db
          .collection('loja/usuarios/clientes/${auth.usuario!.uid}/device')
          .doc('tokenDevice')
          .set({'token': token});
    }
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
