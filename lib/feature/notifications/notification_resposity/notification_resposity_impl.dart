import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/notifications/notification_resposity/notification_resposity.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_count_query.dart';
import 'package:di360_flutter/feature/notifications/querys/get_notification_query.dart';

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

  @override
  Future<dynamic> getNotificationCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final query = await basedOnTypeCallNotificationCount();
    final response = await _http.query(query, variables: {"user_id": userId});
    return response;
  }
}
