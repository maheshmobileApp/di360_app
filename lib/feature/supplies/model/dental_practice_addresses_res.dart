class DentalPracticeAddressesRes {
  DentalPracticeAddressesData? data;

  DentalPracticeAddressesRes({this.data});

  DentalPracticeAddressesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DentalPracticeAddressesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DentalPracticeAddressesData {
  List<DentalPracticeAddresses>? dentalPracticeAddresses;

  DentalPracticeAddressesData({this.dentalPracticeAddresses});

  DentalPracticeAddressesData.fromJson(Map<String, dynamic> json) {
    if (json['dental_practice_addresses'] != null) {
      dentalPracticeAddresses = <DentalPracticeAddresses>[];
      json['dental_practice_addresses'].forEach((v) {
        dentalPracticeAddresses!.add(new DentalPracticeAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalPracticeAddresses != null) {
      data['dental_practice_addresses'] =
          this.dentalPracticeAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DentalPracticeAddresses {
  String? id;
  String? city;
  String? country;
  String? createdAt;
  String? dentalPracticeId;
  String? googlePlaceId;
  String? landmark;
  double? latitude;
  String? line1;
  Null? line2;
  double? longitude;
  bool? makeDefault;
  Null? otherTypeName;
  String? postalCode;
  String? shortName;
  String? state;
  String? type;
  String? updatedAt;
  String? sTypename;

  DentalPracticeAddresses(
      {this.id,
      this.city,
      this.country,
      this.createdAt,
      this.dentalPracticeId,
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

  DentalPracticeAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    country = json['country'];
    createdAt = json['created_at'];
    dentalPracticeId = json['dental_practice_id'];
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
    data['dental_practice_id'] = this.dentalPracticeId;
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
