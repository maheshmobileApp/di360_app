abstract class NotificationResposity {
  Future<dynamic> getNotification(int limit, int offset);
  Future<dynamic> getNotificationCount();
  Future<dynamic> getNewsFeedData(String id);
}
