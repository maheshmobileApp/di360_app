class CheckMailRes {
  CheckMailData? data;

  CheckMailRes({this.data});

  CheckMailRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? CheckMailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class CheckMailData {
  List<Clients>? clients;

  CheckMailData({this.clients});

  CheckMailData.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Clients>[];

      json['clients'].forEach((v) {
        clients!.add(Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Clients {
  String? id;
  String? email;
  String? sTypename;

  Clients({
    this.id,
    this.email,
    this.sTypename,
  });

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      '__typename': sTypename,
    };
  }
}