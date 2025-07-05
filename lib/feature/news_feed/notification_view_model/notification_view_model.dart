import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_notification_res.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

import '../model_class/notification_count_res.dart';

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

const String getProfessionalNotifications = r'''
query get_notifications($user_id: uuid!) {
  notifications:dental_professional_notifications(where: {
    dental_professional_id: {_eq: $user_id},
    mark_as_read: {_eq: false}
  },
  order_by:{
    created_at: desc
  }) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    payload
    read_at
    dental_professional_id
    created_at
    updated_at
  }
}
''';

const String updateProfessionalNotification = r'''
mutation update_dental_professional_notifications_by_pk($id: uuid!) {
  update_dental_professional_notifications_by_pk(
    pk_columns: {id: $id}
    _set: {mark_as_read: true}
  ) {
    id
    __typename
  }
}
''';

const String getSupplierNotifications = r'''
query get_notifications($user_id: uuid!) {
  notifications: dental_supplier_notifications(
    where: {dental_supplier_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    payload
    read_at
    dental_supplier_id
    created_at
    updated_at
    __typename
}
}
''';

const String getPracticeNotifications = r'''
query get_notifications($user_id: uuid!) {
  notifications: dental_practice_notifications(
    where: {dental_practice_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    payload
    read_at
    dental_practice_id
    created_at
    updated_at
    __typename
  }
}
''';

const String getAdminNotifications = r'''
query get_notifications($user_id: uuid!) {
  notifications: admin_user_notifications(
    where: {admin_user_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    payload
    read_at
    admin_user_id
    created_at
    updated_at
    __typename
  }
}
''';

const String professionNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate:dental_professional_notifications_aggregate(where: {
    dental_professional_id: {_eq: $user_id},
    mark_as_read: {_eq: false}
  }){
    aggregate {
      count
}
}
}
''';

const String supplierNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: dental_supplier_notifications_aggregate(
    where: {dental_supplier_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';

const String practiceNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: dental_practice_notifications_aggregate(
    where: {dental_practice_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';

const String adminNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: admin_user_notifications_aggregate(
    where: {admin_user_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';
