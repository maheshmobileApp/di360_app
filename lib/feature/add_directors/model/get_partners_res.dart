class GetDirectoriesPartnersRes {
  PartnersData? data;

  GetDirectoriesPartnersRes({this.data});

  GetDirectoriesPartnersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PartnersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PartnersData {
  List<DirectoriesPartnersMembers>? directoriesPartnersMembers;

  PartnersData({this.directoriesPartnersMembers});

  PartnersData.fromJson(Map<String, dynamic> json) {
    if (json['directories_partners_members'] != null) {
      directoriesPartnersMembers = <DirectoriesPartnersMembers>[];
      json['directories_partners_members'].forEach((v) {
        directoriesPartnersMembers!
            .add(new DirectoriesPartnersMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoriesPartnersMembers != null) {
      data['directories_partners_members'] =
          this.directoriesPartnersMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoriesPartnersMembers {
  String? id;
  String? name;
  Image? image;
  List<Attachments>? attachments;
  String? description;
  bool? showCommunityUser;
  String? directoryId;
  String? sTypename;

  DirectoriesPartnersMembers(
      {this.id,
      this.name,
      this.image,
      this.attachments,
      this.description,
      this.showCommunityUser,
      this.directoryId,
      this.sTypename});

  DirectoriesPartnersMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    description = json['description'];
    showCommunityUser = json['show_community_user'];
    directoryId = json['directory_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['show_community_user'] = this.showCommunityUser;
    data['directory_id'] = this.directoryId;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Image {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Image(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Image.fromJson(Map<String, dynamic> json) {
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

class Attachments {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Attachments(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Attachments.fromJson(Map<String, dynamic> json) {
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
