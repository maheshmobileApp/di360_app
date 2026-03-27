import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/notificatoin_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /*await NotificationService.showNotification(
    title: message.notification?.title ?? '',
    body: message.notification?.body ?? '',
    payload: _buildPayload(message.data, message.notification?.title ?? ''),
  );*/
}

String? _buildPayload(Map<String, dynamic> data, String types) {
  final type = data['type'] as String? ?? types;
  final id = data['id'] as String?;
  if (type.isNotEmpty) return '$type|${id ?? ''}';
  return data['filePath'] as String?;
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
          _handlePayload(response.payload!);
        }
      },
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? filePath,
    String? payload,
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
      payload: payload ?? filePath,
    );
  }

  static void _handlePayload(String payload) {
    final parts = payload.split('|');
    if (parts.length == 2) {
      _handleNavigation(parts[0], parts[1]);
    } else {
      OpenFile.open(payload);
    }
  }

  /// Called from FCM background tap (no BuildContext available)
  static void _handleNavigation(String type, String id, {BuildContext? ctx}) {
    final navigator = navigatorKey.currentState;
    final context = ctx ?? navigatorKey.currentContext;
    print(
        '[FCM-NAV] _handleNavigation type=$type id=$id navigator=$navigator context=$context');
    if (navigator == null || context == null) return;

    final notificationType = NotificationType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => NotificationType.INFORMATIONAL,
    );

    switch (notificationType) {
      case NotificationType.JOB:
        Provider.of<NewsFeedViewModel>(context, listen: false)
            .getJobDetailsByIds(context, id);
        break;
      case NotificationType.NEWS_FEED:
        Provider.of<NotificationViewModel>(context, listen: false)
            .getNewsFeedData(context, id);
        break;
      case NotificationType.TALENT:
        () async {
          final talentEnqVM =
              Provider.of<TalentEnquiryViewModel>(context, listen: false);
          await talentEnqVM.getTalentEnqPreviewData(context, id);
          if (talentEnqVM.talentEnqPreviewData.isNotEmpty) {
            navigationService.navigateToWithParams(RouteList.talentPreview,
                params: talentEnqVM.talentEnqPreviewData.first);
          }
        }();
        break;
      case NotificationType.CATALOGUE:
        () async {
          final catalogueVM =
              Provider.of<CatalogueViewModel>(context, listen: false);
          await catalogueVM.getCatalogDetails(context, id);
          final catId =
              catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
          await catalogueVM.getReletedCatalog(context, catId);
          navigationService.navigateTo(RouteList.catalogueDetails);
        }();
        break;
      case NotificationType.COURSE:
        () async {
          final courseVM =
              Provider.of<CourseListingViewModel>(context, listen: false);
          await courseVM.getCourseDetails(context, id);
          navigationService.navigateTo(RouteList.courseDetailScreen);
        }();
        break;
      case NotificationType.COMMUNITY:
        navigator.pushNamed(RouteList.newsFeedCommunityView);
        break;
      case NotificationType.APPOINTMENT:
        navigator.pushNamed(RouteList.myAppointment);
        break;
      case NotificationType.SUPPORT_REQUEST:
        navigator.pushNamed(RouteList.supportScreen);
        break;
      case NotificationType.INFORMATIONAL:
        navigator.pushNamed(RouteList.notificationScreen);
        break;
    }
  }

  // Stores the terminated-state message until the app is ready to navigate
  static RemoteMessage? _pendingInitialMessage;
  static bool _pendingHandled = false;

  static Future<void> captureInitialMessage() async {
    _pendingInitialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    _pendingHandled = false;
    print('[FCM-KILLED] captureInitialMessage: $_pendingInitialMessage');
    if (_pendingInitialMessage != null) {
      print('[FCM-KILLED] data: ${_pendingInitialMessage!.data}');
      print(
          '[FCM-KILLED] title: ${_pendingInitialMessage!.notification?.title}');
    }
  }

  /// Call this from dashboard (after login/splash) to handle terminated-state tap
  static void handlePendingInitialMessage(BuildContext context) {
    if (_pendingHandled) return;
    final message = _pendingInitialMessage;
    print('[FCM-KILLED] handlePendingInitialMessage called, message: $message');
    if (message == null) return;
    _pendingHandled = true;
    _pendingInitialMessage = null;
    final type = message.data['type'] as String? ?? message.notification?.title;
    final id = message.data['id'] as String? ?? '';
    print('[FCM-KILLED] type=$type id=$id');
    if (type != null) {
      _handleNavigation(type, id, ctx: context);
    } else if (message.data['filePath'] != null) {
      OpenFile.open(message.data['filePath']);
    }
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
        payload: _buildPayload(message.data, message.notification?.title ?? ''),
      );
    });

    // App opened from background (recent apps / background state)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final type =
          message.data['type'] as String? ?? message.notification?.title;
      final id = message.data['id'] as String? ?? '';
      if (type != null) {
        // Delay to ensure navigator is ready after app resumes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNavigation(type, id);
        });
      } else if (message.data['filePath'] != null) {
        OpenFile.open(message.data['filePath']);
      }
    });
  }
}
