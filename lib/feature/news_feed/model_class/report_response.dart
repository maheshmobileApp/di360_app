class ReportResponse {
  ReportData? data;

  ReportResponse({this.data});

  ReportResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ReportData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReportData {
  UpdateNewsfeeds? updateNewsfeeds;

  ReportData({this.updateNewsfeeds});

  ReportData.fromJson(Map<String, dynamic> json) {
    updateNewsfeeds = json['update_newsfeeds'] != null
        ? new UpdateNewsfeeds.fromJson(json['update_newsfeeds'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.updateNewsfeeds != null) {
      data['update_newsfeeds'] = this.updateNewsfeeds!.toJson();
    }
    return data;
  }
}

class UpdateNewsfeeds {
  int? affectedRows;
  List<Returning>? returning;

  UpdateNewsfeeds({this.affectedRows, this.returning});

  UpdateNewsfeeds.fromJson(Map<String, dynamic> json) {
    affectedRows = json['affected_rows'];
    if (json['returning'] != null) {
      returning = <Returning>[];
      json['returning'].forEach((v) {
        returning!.add(new Returning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affected_rows'] = this.affectedRows;
    if (this.returning != null) {
      data['returning'] = this.returning!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Returning {
  String? id;
  bool? feedBlock;

  Returning({this.id, this.feedBlock});

  Returning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedBlock = json['feed_block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['feed_block'] = this.feedBlock;
    return data;
  }
}
