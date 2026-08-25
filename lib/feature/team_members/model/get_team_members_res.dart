class GetTeamMembersRes {
  TeamMembersData? data;

  GetTeamMembersRes({this.data});

  GetTeamMembersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TeamMembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TeamMembersData {
  List<SupplierAccess>? supplierAccess;
  SupplierAccessAggregate? supplierAccessAggregate;

  TeamMembersData({this.supplierAccess, this.supplierAccessAggregate});

  TeamMembersData.fromJson(Map<String, dynamic> json) {
    if (json['supplier_access'] != null) {
      supplierAccess = <SupplierAccess>[];
      json['supplier_access'].forEach((v) {
        supplierAccess!.add(new SupplierAccess.fromJson(v));
      });
    }
    supplierAccessAggregate = json['supplier_access_aggregate'] != null
        ? new SupplierAccessAggregate.fromJson(
            json['supplier_access_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplierAccess != null) {
      data['supplier_access'] =
          this.supplierAccess!.map((v) => v.toJson()).toList();
    }
    if (this.supplierAccessAggregate != null) {
      data['supplier_access_aggregate'] =
          this.supplierAccessAggregate!.toJson();
    }
    return data;
  }
}

class SupplierAccess {
  String? id;
  String? name;
  String? phone;
  String? createdAt;
  Clients? clients;
  String? sTypename;

  SupplierAccess(
      {this.id,
      this.name,
      this.phone,
      this.createdAt,
      this.clients,
      this.sTypename});

  SupplierAccess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    if (this.clients != null) {
      data['clients'] = this.clients!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Clients {
  String? email;
  String? type;
  String? status;
  String? sTypename;

  Clients({this.email, this.type, this.status, this.sTypename});

  Clients.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    type = json['type'];
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['type'] = this.type;
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplierAccessAggregate {
  Aggregate? aggregate;
  String? sTypename;

  SupplierAccessAggregate({this.aggregate, this.sTypename});

  SupplierAccessAggregate.fromJson(Map<String, dynamic> json) {
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
