class DentalSuppliersRes {
  DentalSuppliersData? data;

  DentalSuppliersRes({this.data});

  DentalSuppliersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DentalSuppliersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DentalSuppliersData {
  List<DentalSuppliers>? dentalSuppliers;

  DentalSuppliersData({this.dentalSuppliers});

  DentalSuppliersData.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Logo? logo;
  String? businessName;
  String? sTypename;

  DentalSuppliers(
      {this.id, this.name, this.logo, this.businessName, this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Logo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Logo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    directory = json['directory'];
    extension = json['extension'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    return data;
  }
}
