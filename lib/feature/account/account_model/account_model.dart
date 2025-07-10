class ProfileSection {
  final String title;
  final List<SubTitleItem> subTitle;

  ProfileSection({required this.title, required this.subTitle});

  factory ProfileSection.fromJson(Map<String, dynamic> json) {
    return ProfileSection(
      title: json['title'],
      subTitle: (json['subTitle'] as List)
          .map((item) => SubTitleItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle.map((item) => item.toJson()).toList(),
    };
  }
}

class SubTitleItem {
  final String title;
  final String asset;

  SubTitleItem({required this.title, required this.asset});

  factory SubTitleItem.fromJson(Map<String, dynamic> json) {
    return SubTitleItem(
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
