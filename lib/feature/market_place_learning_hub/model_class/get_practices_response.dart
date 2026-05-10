class PracticesResponse {
  PracticesData? data;

  PracticesResponse({this.data});

  PracticesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PracticesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PracticesData {
  DentalPracticesByPk? dentalPracticesByPk;

  PracticesData({this.dentalPracticesByPk});

  PracticesData.fromJson(Map<String, dynamic> json) {
    dentalPracticesByPk = json['dental_practices_by_pk'] != null
        ? new DentalPracticesByPk.fromJson(json['dental_practices_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalPracticesByPk != null) {
      data['dental_practices_by_pk'] = this.dentalPracticesByPk!.toJson();
    }
    return data;
  }
}

class DentalPracticesByPk {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? firstName;
  String? lastName;
  String? sTypename;

  DentalPracticesByPk(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.firstName,
      this.lastName,
      this.sTypename});

  DentalPracticesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
