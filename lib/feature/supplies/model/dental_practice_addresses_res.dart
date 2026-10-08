import 'package:di360_flutter/feature/shipping_address/model/get_shipping_addresses_professional_res.dart';

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
  List<DentalProfessionalAddresses>? dentalPracticeAddresses;

  DentalPracticeAddressesData({this.dentalPracticeAddresses});

  DentalPracticeAddressesData.fromJson(Map<String, dynamic> json) {
    if (json['dental_practice_addresses'] != null) {
      dentalPracticeAddresses = <DentalProfessionalAddresses>[];
      json['dental_practice_addresses'].forEach((v) {
        dentalPracticeAddresses!.add(new DentalProfessionalAddresses.fromJson(v));
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