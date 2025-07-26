class DirectoriesCatagoryRes {
  DirectoriesCatagoryData? data;

  DirectoriesCatagoryRes({this.data});

  DirectoriesCatagoryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DirectoriesCatagoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DirectoriesCatagoryData {
  List<DirectoryBusinessTypes>? directoryBusinessTypes;

  DirectoriesCatagoryData({this.directoryBusinessTypes});

  DirectoriesCatagoryData.fromJson(Map<String, dynamic> json) {
    if (json['directory_business_types'] != null) {
      directoryBusinessTypes = <DirectoryBusinessTypes>[];
      json['directory_business_types'].forEach((v) {
        directoryBusinessTypes!.add(new DirectoryBusinessTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoryBusinessTypes != null) {
      data['directory_business_types'] =
          this.directoryBusinessTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoryBusinessTypes {
  String? id;
  String? name;
  List<DirectoryCategories>? directoryCategories;
  String? sTypename;

  DirectoryBusinessTypes(
      {this.id, this.name, this.directoryCategories, this.sTypename});

  DirectoryBusinessTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['directory_categories'] != null) {
      directoryCategories = <DirectoryCategories>[];
      json['directory_categories'].forEach((v) {
        directoryCategories!.add(new DirectoryCategories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.directoryCategories != null) {
      data['directory_categories'] =
          this.directoryCategories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoryCategories {
  String? id;
  String? name;
  String? sTypename;

  DirectoryCategories({this.id, this.name, this.sTypename});

  DirectoryCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
