class GetAccountSectionsModel {
  List<AccountSection>? data;

  GetAccountSectionsModel({this.data});

  factory GetAccountSectionsModel.fromJson(Map<String, dynamic> json) {
    return GetAccountSectionsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AccountSection.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class AccountSection {
  String? title;
  List<String>? subTitle;

  AccountSection({this.title, this.subTitle});

  factory AccountSection.fromJson(Map<String, dynamic> json) {
    return AccountSection(
      title: json['title'],
      subTitle: (json['subTitle'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subTitle': subTitle,
      };
}