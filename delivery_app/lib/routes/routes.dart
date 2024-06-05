import 'package:delivery_app/pages/authCheck.dart';
import 'package:delivery_app/pages/notificationPage.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => const AuthCheck(),
    '/notificacao': (_) => const NotificationPage(),
  };
  static String initial = '/home';
  
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}