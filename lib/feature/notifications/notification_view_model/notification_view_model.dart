import 'package:di360_flutter/feature/news_feed/model_class/get_notification_res.dart';
import 'package:di360_flutter/feature/news_feed/model_class/notification_count_res.dart';
import 'package:di360_flutter/feature/notifications/notification_resposity/notification_resposity_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationResposityImpl notificationResposityImpl =
      NotificationResposityImpl();

  List<Notifications> notificationsList = [];
  int? notificationCount = 0;
  int currentPage = 0;
  final int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  getNotifications(BuildContext context, {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 0;
      hasMoreData = true;
      notificationsList.clear();
    }

    if (!hasMoreData || isLoadingMore) return;

    if (currentPage == 0) {
      Loaders.circularShowLoader(context);
    } else {
      isLoadingMore = true;
      notifyListeners();
    }

    try {
      var response = await notificationResposityImpl.getNotification(
          pageSize, currentPage * pageSize);

      if (response != null) {
        final notificationData = NotificationData.fromJson(response);
        final newNotifications = notificationData.notifications ?? [];
        
        if (newNotifications.isEmpty) {
          hasMoreData = false;
        } else {
          notificationsList.addAll(newNotifications);
          currentPage++;
        }
      }

      if (currentPage == 1) {
        Loaders.circularHideLoader(context);
      }
      isLoadingMore = false;
    } catch (e) {
      if (currentPage == 1) {
        Loaders.circularHideLoader(context);
      }
      isLoadingMore = false;
      hasMoreData = false;
      print("Error loading notifications: $e");
    }
    notifyListeners();
  }

  getNotificationsCount() async {
    try {
      var response = await notificationResposityImpl.getNotificationCount();

      if (response != null) {
        final res = NotificationCountData.fromJson(response);
        notificationCount = res.notificationsAggregate?.aggregate?.count;
      }
    } catch (e) {
      print("Error loading notification count: $e");
    }
    notifyListeners();
  }

  /* updateMarkAsReadNotification(BuildContext context, String Id) async {
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
  }*/
}
