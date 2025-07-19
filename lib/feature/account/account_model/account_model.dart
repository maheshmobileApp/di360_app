class ProfileSection {
  final Map<String, RoleData> roles;

  ProfileSection({required this.roles});

  factory ProfileSection.fromJson(Map<String, dynamic> json) {
    final rolesJson = json['roles'] as Map<String, dynamic>;
    final roles = rolesJson.map((key, value) =>
      MapEntry(key.toString(), RoleData.fromJson(value)));
    return ProfileSection(roles: roles);
  }

  Map<String, dynamic> toJson() {
    return {
      'roles': roles.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}


class RoleData {
  final List<ProfileCategory> data;

  RoleData({required this.data});

  factory RoleData.fromJson(Map<String, dynamic> json) {
    return RoleData(
      data: List<ProfileCategory>.from(
        json['data'].map((item) => ProfileCategory.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class ProfileCategory {
  final String title;
  final List<SubTitle> subTitle;

  ProfileCategory({required this.title, required this.subTitle});

  factory ProfileCategory.fromJson(Map<String, dynamic> json) {
    return ProfileCategory(
      title: json['title'],
      subTitle: List<SubTitle>.from(
        json['subTitle'].map((item) => SubTitle.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle.map((item) => item.toJson()).toList(),
    };
  }
}

class SubTitle {
  final String title;
  final String asset;

  SubTitle({required this.title, required this.asset});

  factory SubTitle.fromJson(Map<String, dynamic> json) {
    return SubTitle(
      title: json['title'],
      asset: json['asset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'asset': asset,
    };
  }
}
