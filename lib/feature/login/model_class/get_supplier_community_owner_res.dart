class GetSupplierCommunityOwnerRes {
  GetSupplierCommunityOwnerData? data;

  GetSupplierCommunityOwnerRes({this.data});

  GetSupplierCommunityOwnerRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetSupplierCommunityOwnerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSupplierCommunityOwnerData {
  List<DentalSuppliers>? dentalSuppliers;

  GetSupplierCommunityOwnerData({this.dentalSuppliers});

  GetSupplierCommunityOwnerData.fromJson(Map<String, dynamic> json) {
    if (json['dental_suppliers'] != null) {
      dentalSuppliers = <DentalSuppliers>[];
      json['dental_suppliers'].forEach((v) {
        dentalSuppliers!.add(new DentalSuppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] =
          this.dentalSuppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DentalSuppliers {
  String? id;
  String? communityId;
  String? communityStatus;
  String? businessName;
  String? sTypename;

  DentalSuppliers(
      {this.id,
      this.communityId,
      this.communityStatus,
      this.businessName,
      this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    communityId = json['community_id'];
    communityStatus = json['community_status'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['community_id'] = this.communityId;
    data['community_status'] = this.communityStatus;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
