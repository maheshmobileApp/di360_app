class GetTeamMembersRes {
  TeamMembersData? data;

  GetTeamMembersRes({this.data});

  GetTeamMembersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TeamMembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TeamMembersData {
  List<DirectoryTeamMember>? directoryTeamMembers;

  TeamMembersData({this.directoryTeamMembers});

  TeamMembersData.fromJson(Map<String, dynamic> json) {
    if (json['directory_team_members'] != null) {
      directoryTeamMembers = <DirectoryTeamMember>[];
      json['directory_team_members'].forEach((v) {
        directoryTeamMembers!.add(new DirectoryTeamMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoryTeamMembers != null) {
      data['directory_team_members'] =
          this.directoryTeamMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoryTeamMember {
  String? id;
  String? name;
  String? specialization;
  Images? image;
  String? phone;
  String? email;
  dynamic subrub;
  dynamic state;
  String? sTypename;

  DirectoryTeamMember(
      {this.id,
      this.name,
      this.specialization,
      this.image,
      this.phone,
      this.email,
      this.subrub,
      this.state,
      this.sTypename});

  DirectoryTeamMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialization = json['specialization'];
    image = json['image'] != null ? new Images.fromJson(json['image']) : null;
    phone = json['phone'];
    email = json['email'];
    subrub = json['subrub'];
    state = json['state'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['specialization'] = this.specialization;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['subrub'] = this.subrub;
    data['state'] = this.state;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Images {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Images(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Images.fromJson(Map<String, dynamic> json) {
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
