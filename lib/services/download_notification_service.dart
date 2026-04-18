import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class DownloadNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// ✅ Initialize notifications
  static Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),

      /// Foreground / Background tap
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null && response.payload!.isNotEmpty) {
          _openFile(response.payload!);
        }
      },

      /// Terminated state tap
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  /// ✅ Show download notification
  static Future<void> showDownloadNotification({
    required String fileName,
    required String filePath,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'di360_downloads',
      'Downloads',
      channelDescription: 'Download completed notifications',
      importance: Importance.high,
      priority: Priority.high,
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      "Download Complete",
      "$fileName downloaded",
      notificationDetails,
      payload: filePath, // 🔥 important
    );
  }

  /// ✅ Open file safely
  static Future<void> _openFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return;
      }
      await OpenFile.open(filePath);
    } catch (e) {
    }
  }

  /// ✅ Background handler (MUST be top-level or static)
  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    if (response.payload != null && response.payload!.isNotEmpty) {
      OpenFile.open(response.payload!);
    }
  }
}