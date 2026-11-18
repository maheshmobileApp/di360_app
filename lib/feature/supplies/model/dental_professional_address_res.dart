class DentalProfessionalAddressesRes {
  DentalProfessionalAddressesData? data;

  DentalProfessionalAddressesRes({this.data});

  DentalProfessionalAddressesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DentalProfessionalAddressesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class DentalProfessionalAddressesData {
  List<DentalProfessionalAddresses>? dentalProfessionalAddresses;

  DentalProfessionalAddressesData({this.dentalProfessionalAddresses});

  DentalProfessionalAddressesData.fromJson(Map<String, dynamic> json) {
    if (json['dental_professional_addresses'] != null) {
      dentalProfessionalAddresses = [];
      json['dental_professional_addresses'].forEach((v) {
        dentalProfessionalAddresses
            ?.add(new DentalProfessionalAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalProfessionalAddresses != null) {
      data['dental_professional_addresses'] =
          this.dentalProfessionalAddresses?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DentalProfessionalAddresses {
  String? id;
  String? city;
  String? country;
  String? createdAt;
  String? dentalProfessionalId;
  String? googlePlaceId;
  String? landmark;
  dynamic latitude;
  String? line1;
  String? line2;
  dynamic longitude;
  bool? makeDefault;
  String? otherTypeName;
  String? postalCode;
  String? shortName;
  String? state;
  String? type;
  String? updatedAt;
  String? sTypename;

  DentalProfessionalAddresses(
      {this.id,
      this.city,
      this.country,
      this.createdAt,
      this.dentalProfessionalId,
      this.googlePlaceId,
      this.landmark,
      this.latitude,
      this.line1,
      this.line2,
      this.longitude,
      this.makeDefault,
      this.otherTypeName,
      this.postalCode,
      this.shortName,
      this.state,
      this.type,
      this.updatedAt,
      this.sTypename});

  DentalProfessionalAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    country = json['country'];
    createdAt = json['created_at'];
    dentalProfessionalId = json['dental_professional_id'];
    googlePlaceId = json['google_place_id'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    longitude = json['longitude'];
    makeDefault = json['make_default'];
    otherTypeName = json['other_type_name'];
    postalCode = json['postal_code'];
    shortName = json['short_name'];
    state = json['state'];
    type = json['type'];
    updatedAt = json['updated_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['google_place_id'] = this.googlePlaceId;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['longitude'] = this.longitude;
    data['make_default'] = this.makeDefault;
    data['other_type_name'] = this.otherTypeName;
    data['postal_code'] = this.postalCode;
    data['short_name'] = this.shortName;
    data['state'] = this.state;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}
