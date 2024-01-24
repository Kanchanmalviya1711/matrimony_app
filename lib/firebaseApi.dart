import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:matrimony_app/main.dart';
import 'package:matrimony_app/routes/app_routes.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("paload: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed(AppRoutes.friendRequestScreen, arguments: message.data);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    initPushNotification();
  }
}
