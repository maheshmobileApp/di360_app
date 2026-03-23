import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.showNotification(
    title: message.notification?.title ?? '',
    body: message.notification?.body ?? '',
    filePath: message.data['filePath'],
  );
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _openFile(response.payload!);
        }
      },
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? filePath,
  }) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'dentalinterface360',
      'dentalinterface360',
      importance: Importance.high,
      priority: Priority.high,
      icon: filePath,
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

     NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      platformDetails,
      payload: filePath,
    );
  }

  static void _openFile(String filePath) {
    OpenFile.open(filePath);
  }

  static Future<void> initFirebaseMessaging() async {
    final messaging = FirebaseMessaging.instance;

    // Permission
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('Notification permission denied');
      return;
    }

    // Token
    final token = await messaging.getToken();
    print('FCM Token: $token');

    // Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        filePath: message.data['filePath'],
      );
    });

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['filePath'] != null) {
        _openFile(message.data['filePath']);
      }
    });
  }
}
