class GetFollowersRes {
  GetFollowersData? data;

  GetFollowersRes({this.data});

  GetFollowersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetFollowersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetFollowersData {
  ToWhomeIAmFollowingAggregate? toWhomeIAmFollowingAggregate;
  List<ToWhomeIAmFollowing>? toWhomeIAmFollowing;
  WhoIsFollowingAggregate? whoIsFollowingAggregate;
  List<Null>? whoIsFollowing;

  GetFollowersData(
      {this.toWhomeIAmFollowingAggregate,
      this.toWhomeIAmFollowing,
      this.whoIsFollowingAggregate,
      this.whoIsFollowing});

  GetFollowersData.fromJson(Map<String, dynamic> json) {
    toWhomeIAmFollowingAggregate =
        json['to_whome_i_am_following_aggregate'] != null
            ? new ToWhomeIAmFollowingAggregate.fromJson(
                json['to_whome_i_am_following_aggregate'])
            : null;
    if (json['to_whome_i_am_following'] != null) {
      toWhomeIAmFollowing = <ToWhomeIAmFollowing>[];
      json['to_whome_i_am_following'].forEach((v) {
        toWhomeIAmFollowing!.add(new ToWhomeIAmFollowing.fromJson(v));
      });
    }
    whoIsFollowingAggregate = json['who_is_following_aggregate'] != null
        ? new WhoIsFollowingAggregate.fromJson(
            json['who_is_following_aggregate'])
        : null;
    if (json['who_is_following'] != null) {
      whoIsFollowing = <dynamic>[].cast<Null>();
      json['who_is_following'].forEach((v) {
        whoIsFollowing!.add(v);
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.toWhomeIAmFollowingAggregate != null) {
      data['to_whome_i_am_following_aggregate'] =
          this.toWhomeIAmFollowingAggregate!.toJson();
    }
    if (this.toWhomeIAmFollowing != null) {
      data['to_whome_i_am_following'] =
          this.toWhomeIAmFollowing!.map((v) => null).toList();
    }
    if (this.whoIsFollowingAggregate != null) {
      data['who_is_following_aggregate'] =
          this.whoIsFollowingAggregate!.toJson();
    }
    if (this.whoIsFollowing != null) {
      data['who_is_following'] = this.whoIsFollowing!.map((v) => null).toList();
    }
    return data;
  }
}

class ToWhomeIAmFollowingAggregate {
  Aggregate? aggregate;
  String? sTypename;

  ToWhomeIAmFollowingAggregate({this.aggregate, this.sTypename});

  ToWhomeIAmFollowingAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}


class WhoIsFollowingAggregate {
  WhoIsFollowAggregate? aggregate;
  String? sTypename;

  WhoIsFollowingAggregate({this.aggregate, this.sTypename});

  WhoIsFollowingAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new WhoIsFollowAggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class WhoIsFollowAggregate {
  int? count;
  String? sTypename;

  WhoIsFollowAggregate({this.count, this.sTypename});

  WhoIsFollowAggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ToWhomeIAmFollowing {
  String? id;
  String? followingStatus;
  String? followerDentalProfessionalId;
  String? followerDentalSupplierId;
  String? followerDentalPracticeId;
  String? followerDentalProfessional;
  FollowerDentalSupplier? followerDentalSupplier;
  dynamic followerDentalPractice;
  DentalSupplier? dentalSupplier;
  dynamic dentalPractice;
  dynamic dentalProfessional;
  dynamic dentalAdmin;

  ToWhomeIAmFollowing(
      {this.id,
      this.followingStatus,
      this.followerDentalProfessionalId,
      this.followerDentalSupplierId,
      this.followerDentalPracticeId,
      this.followerDentalProfessional,
      this.followerDentalSupplier,
      this.followerDentalPractice,
      this.dentalSupplier,
      this.dentalPractice,
      this.dentalProfessional,
      this.dentalAdmin});

  ToWhomeIAmFollowing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    followingStatus = json['following_status'];
    followerDentalProfessionalId = json['follower_dental_professional_id'];
    followerDentalSupplierId = json['follower_dental_supplier_id'];
    followerDentalPracticeId = json['follower_dental_practice_id'];
    followerDentalProfessional = json['follower_dental_professional'];
    followerDentalSupplier = json['follower_dental_supplier'] != null
        ? new FollowerDentalSupplier.fromJson(json['follower_dental_supplier'])
        : null;
    followerDentalPractice = json['follower_dental_practice'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'];
    dentalProfessional = json['dental_professional'];
    dentalAdmin = json['dental_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['following_status'] = this.followingStatus;
    data['follower_dental_professional_id'] = this.followerDentalProfessionalId;
    data['follower_dental_supplier_id'] = this.followerDentalSupplierId;
    data['follower_dental_practice_id'] = this.followerDentalPracticeId;
    data['follower_dental_professional'] = this.followerDentalProfessional;
    if (this.followerDentalSupplier != null) {
      data['follower_dental_supplier'] = this.followerDentalSupplier!.toJson();
    }
    data['follower_dental_practice'] = this.followerDentalPractice;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional'] = this.dentalProfessional;
    data['dental_admin'] = this.dentalAdmin;
    return data;
  }
}

class FollowerDentalSupplier {
  String? id;
  String? name;
  Logo? logo;
  String? type;

  FollowerDentalSupplier({this.id, this.name, this.logo, this.type});

  FollowerDentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['type'] = this.type;
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

class DentalSupplier {
  String? id;
  String? name;

  DentalSupplier({this.id, this.name});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
