class GetSubSupplierRes {
  SubSupplierData? data;

  GetSubSupplierRes({this.data});

  GetSubSupplierRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SubSupplierData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubSupplierData {
  ClientsByPk? clientsByPk;

  SubSupplierData({this.clientsByPk});

  SubSupplierData.fromJson(Map<String, dynamic> json) {
    clientsByPk = json['clients_by_pk'] != null
        ? ClientsByPk.fromJson(json['clients_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientsByPk != null) {
      data['clients_by_pk'] = this.clientsByPk!.toJson();
    }
    return data;
  }
}

class ClientsByPk {
  String? id;
  String? businessName;
  String? email;
  String? phone;
  String? password;
  Permissions? permissions;
  String? name;
  String? sTypename;

  ClientsByPk(
      {this.id,
      this.businessName,
      this.email,
      this.phone,
      this.password,
      this.permissions,
      this.name,
      this.sTypename});

  ClientsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.toJson();
    }
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Permissions {
  List<Modules>? modules;

  Permissions({this.modules});

  Permissions.fromJson(Map<String, dynamic> json) {
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modules != null) {
      data['modules'] = this.modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  String? name;
  int? count;
  bool? permission;

  Modules({this.name, this.count, this.permission});

  Modules.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['permission'] = this.permission;
    return data;
  }
}
