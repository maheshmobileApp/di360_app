class NotificationCount {
  NotificationCountData? data;

  NotificationCount({this.data});

  NotificationCount.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NotificationCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationCountData {
  NotificationsAggregate? notificationsAggregate;

  NotificationCountData({this.notificationsAggregate});

  NotificationCountData.fromJson(Map<String, dynamic> json) {
    notificationsAggregate = json['notifications_aggregate'] != null
        ? new NotificationsAggregate.fromJson(json['notifications_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationsAggregate != null) {
      data['notifications_aggregate'] = this.notificationsAggregate!.toJson();
    }
    return data;
  }
}

class NotificationsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  NotificationsAggregate({this.aggregate, this.sTypename});

  NotificationsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}
