import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await _requestPermission();

    FirebaseMessaging.onBackgroundMessage(_onMessageHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageHandler);

    log('Notification has been initiated');
  }

  static Future<String?> getToken() => _messaging.getToken();

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    log('New notification: ${message.messageId}');

    RemoteNotification? notification = message.notification;

    print(notification);
  }

  static Future<NotificationSettings> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User authorized permission');
    }

    return settings;
  }
}
