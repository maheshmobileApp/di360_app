class FilterSuppliersRes {
  FilterSuppliersData? data;

  FilterSuppliersRes({this.data});

  FilterSuppliersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FilterSuppliersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FilterSuppliersData {
  List<DentalSuppliers>? dentalSuppliers;

  FilterSuppliersData({this.dentalSuppliers});

  FilterSuppliersData.fromJson(Map<String, dynamic> json) {
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
  String? professionType;
  List<Directories>? directories;
  String? sTypename;

  DentalSuppliers(
      {this.id,
      this.name,
      this.logo,
      this.businessName,
      this.professionType,
      this.directories,
      this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    professionType = json['profession_type'];
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
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
    data['profession_type'] = this.professionType;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
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

class Directories {
  String? name;
  String? sTypename;

  Directories({this.name, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
