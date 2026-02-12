import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_notification_res.dart';
import 'package:di360_flutter/feature/news_feed/model_class/notification_count_res.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_count_query.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_query.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  NotificationViewModel() {
    getNotifications();
  }

  List<Notifications>? notificationsList;
  int? notificationCount = 0;

  getNotifications() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    try {
      final query = await basedOnTypeCallNotificationQuery();
      var response = await _http.query(query, variables: {"user_id": userId});

      if (response != null) {
        final notificationData = NotificationData.fromJson(response);
        notificationsList = notificationData.notifications;
      }
    } catch (e) {
      print("Error loading notifications: $e");
    }
    notifyListeners();
  }

  getNotificationsCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    try {
      final query = await basedOnTypeCallNotificationCount();
      var response = await _http.query(query, variables: {"user_id": userId});

      if (response != null) {
        final res = NotificationCountData.fromJson(response);
        notificationCount = res.notificationsAggregate?.aggregate?.count;
      }
    } catch (e) {
      print("Error loading notification count: $e");
    }
    notifyListeners();
  }

  Future<String> basedOnTypeCallNotificationQuery() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == "PROFESSIONAL") {
      return getProfessionalNotifications;
    } else if (type == 'SUPPLIER') {
      return getSupplierNotifications;
    } else if (type == 'ADMIN') {
      return getAdminNotifications;
    } else if (type == 'PRACTICE') {
      return getPracticeNotifications;
    }
    return getProfessionalNotifications;
  }

  Future<String> basedOnTypeCallNotificationCount() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == "PROFESSIONAL") {
      return professionNotificationCount;
    } else if (type == 'SUPPLIER') {
      return supplierNotificationCount;
    } else if (type == 'ADMIN') {
      return adminNotificationCount;
    } else if (type == 'PRACTICE') {
      return practiceNotificationCount;
    }
    return professionNotificationCount;
  }

  updateMarkAsReadNotification(BuildContext context, String Id) async {
    Loaders.circularShowLoader(context);
    try {
      var response =
          await _http.mutation(updateProfessionalNotification, {"id": Id});

      if (response.isEmpty) {
        Loaders.circularHideLoader(context);
        scaffoldMessenger('Unable to Mark as Read');
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger(e.toString());
      print("Error removing like: $e");
    }

    notifyListeners();
  }
}
