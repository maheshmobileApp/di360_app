import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/notifications/notification_resposity/notification_resposity.dart';
import 'package:di360_flutter/feature/notifications/querys/get_news_feed_query.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_count_query.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_query.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class NotificationResposityImpl extends NotificationResposity {
  final HttpService _http = HttpService();

  @override
  Future<dynamic> getNotification(int limit, int offset) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final query = await basedOnTypeCallNotificationQuery();
    final response = await _http.query(query,
        variables: {"user_id": userId, "limit": limit, "offset": offset});
    return response;
  }

  Future<String> basedOnTypeCallNotificationQuery() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == UserRole.professional) {
      return getProfessionalNotifications;
    } else if (type == UserRole.supplier) {
      return getSupplierNotifications;
    } else if (type == UserRole.admin) {
      return getAdminNotifications;
    } else if (type == UserRole.practice) {
      return getPracticeNotifications;
    }
    return getProfessionalNotifications;
  }

  Future<String> basedOnTypeCallNotificationCount() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == UserRole.professional) {
      return professionNotificationCount;
    } else if (type == UserRole.supplier) {
      return supplierNotificationCount;
    } else if (type == UserRole.admin) {
      return adminNotificationCount;
    } else if (type == UserRole.practice) {
      return practiceNotificationCount;
    }
    return professionNotificationCount;
  }

  @override
  Future<dynamic> getNotificationCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final query = await basedOnTypeCallNotificationCount();
    final response = await _http.query(query, variables: {"user_id": userId});
    return response;
  }

  @override
  Future<dynamic> getNewsFeedData(String id) async {
    final res = await _http.query(getNewsFeedQuery, variables: {"id": id});
    return res;
  }
}
