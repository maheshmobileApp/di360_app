class ProfessionalResponse {
  ProfileData? data;

  ProfessionalResponse({this.data});

  ProfessionalResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  DentalProfessionalsByPk? dentalProfessionalsByPk;

  ProfileData({this.dentalProfessionalsByPk});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? email;
  String? name;
  String? phone;
  String? firstName;
  String? lastName;
  dynamic profileImage;
  String? sTypename;

  DentalProfessionalsByPk(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.sTypename});

  DentalProfessionalsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
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
    data['profile_image'] = this.profileImage;
    data['__typename'] = this.sTypename;
    return data;
  }
}
