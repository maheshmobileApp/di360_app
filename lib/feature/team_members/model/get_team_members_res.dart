class GetTeamMembersRes {
  TeamMembersData? data;

  GetTeamMembersRes({this.data});

  GetTeamMembersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? TeamMembersData.fromJson(json['data']) : null;
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
  List<Clients>? clients;
  ClientsAggregate? clientsAggregate;

  TeamMembersData({this.clients, this.clientsAggregate});

  TeamMembersData.fromJson(Map<String, dynamic> json) {
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(Clients.fromJson(v));
      });
    }
    clientsAggregate = json['clients_aggregate'] != null
        ? ClientsAggregate.fromJson(json['clients_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    if (this.clientsAggregate != null) {
      data['clients_aggregate'] = this.clientsAggregate!.toJson();
    }
    return data;
  }
}

class Clients {
  String? id;
  String? name;
  String? email;
  String? type;
  String? status;
  String? createdAt;
  String? subType;
  String? supplierAccessId;
  String? businessName;
  String? sTypename;

  Clients(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.status,
      this.createdAt,
      this.subType,
      this.supplierAccessId,
      this.businessName,
      this.sTypename});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    subType = json['sub_type'];
    supplierAccessId = json['supplier_access_id'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['sub_type'] = this.subType;
    data['supplier_access_id'] = this.supplierAccessId;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ClientsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  ClientsAggregate({this.aggregate, this.sTypename});

  ClientsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
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
