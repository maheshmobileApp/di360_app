class GetBusinessProfessionalDetailsRes {
  GetBusinessProfDetailsData? data;

  GetBusinessProfessionalDetailsRes({this.data});

  GetBusinessProfessionalDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetBusinessProfDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetBusinessProfDetailsData {
  DentalProfessionalsByPk? dentalProfessionalsByPk;

  GetBusinessProfDetailsData({this.dentalProfessionalsByPk});

  GetBusinessProfDetailsData.fromJson(Map<String, dynamic> json) {
    dentalProfessionalsByPk = json['dental_professionals_by_pk'] != null
        ? new DentalProfessionalsByPk.fromJson(
            json['dental_professionals_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalProfessionalsByPk != null) {
      data['dental_professionals_by_pk'] =
          this.dentalProfessionalsByPk!.toJson();
    }
    return data;
  }
}

class DentalProfessionalsByPk {
  String? firstName;
  String? lastName;
  String? name;
  String? sTypename;

  DentalProfessionalsByPk(
      {this.firstName, this.lastName, this.name, this.sTypename});

  DentalProfessionalsByPk.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
