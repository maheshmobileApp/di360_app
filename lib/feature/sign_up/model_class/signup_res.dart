class SignUpRes {
  SignUpData? data;

  SignUpRes({this.data});

  SignUpRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SignUpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SignUpData {
  InsertClientsOne? insertClientsOne;

  SignUpData({this.insertClientsOne});

  SignUpData.fromJson(Map<String, dynamic> json) {
    insertClientsOne = json['insert_clients_one'] != null
        ? new InsertClientsOne.fromJson(json['insert_clients_one'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertClientsOne != null) {
      data['insert_clients_one'] = this.insertClientsOne!.toJson();
    }
    return data;
  }
}

class InsertClientsOne {
  String? id;
  String? email;
  String? phone;
  String? type;
  String? name;
  String? sTypename;

  InsertClientsOne(
      {this.id, this.email, this.phone, this.type, this.name, this.sTypename});

  InsertClientsOne.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
