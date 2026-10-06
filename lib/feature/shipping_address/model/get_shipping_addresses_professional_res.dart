class getShippingAddressProfessionalRes {
  ShippingAddressesProfessionalData? data;

  getShippingAddressProfessionalRes({this.data});

  getShippingAddressProfessionalRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ShippingAddressesProfessionalData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ShippingAddressesProfessionalData {
  List<DentalProfessionalAddresses>? dentalProfessionalAddresses;

  ShippingAddressesProfessionalData({this.dentalProfessionalAddresses});

  ShippingAddressesProfessionalData.fromJson(Map<String, dynamic> json) {
    if (json['dental_professional_addresses'] != null) {
      dentalProfessionalAddresses = <DentalProfessionalAddresses>[];
      json['dental_professional_addresses'].forEach((v) {
        dentalProfessionalAddresses!
            .add(new DentalProfessionalAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalProfessionalAddresses != null) {
      data['dental_professional_addresses'] =
          this.dentalProfessionalAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DentalProfessionalAddresses {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? dentalProfessionalId;
  String? email;
  String? shortName;
  String? line1;
  String? line2;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  dynamic latitude;
  dynamic longitude;
  String? googlePlaceId;
  bool? makeDefault;
  String? type;
  String? otherTypeName;
  String? sTypename;

  DentalProfessionalAddresses(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.dentalProfessionalId,
      this.email,
      this.shortName,
      this.line1,
      this.line2,
      this.landmark,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.googlePlaceId,
      this.makeDefault,
      this.type,
      this.otherTypeName,
      this.sTypename});

  DentalProfessionalAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dentalProfessionalId = json['dental_professional_id'];
    email = json['email'];
    shortName = json['short_name'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    googlePlaceId = json['google_place_id'];
    makeDefault = json['make_default'];
    type = json['type'];
    otherTypeName = json['other_type_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['email'] = this.email;
    data['short_name'] = this.shortName;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['google_place_id'] = this.googlePlaceId;
    data['make_default'] = this.makeDefault;
    data['type'] = this.type;
    data['other_type_name'] = this.otherTypeName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
