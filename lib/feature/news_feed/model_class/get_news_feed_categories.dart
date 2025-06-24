class GetNewsFeedsCategories {
  CategoriesData? data;

  GetNewsFeedsCategories({this.data});

  GetNewsFeedsCategories.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CategoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CategoriesData {
  List<NewsfeedCategories>? newsfeedCategories;

  CategoriesData({this.newsfeedCategories});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['newsfeed_categories'] != null) {
      newsfeedCategories = <NewsfeedCategories>[];
      json['newsfeed_categories'].forEach((v) {
        newsfeedCategories!.add(new NewsfeedCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsfeedCategories != null) {
      data['newsfeed_categories'] =
          this.newsfeedCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsfeedCategories {
  String? id;
  String? categoryName;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? createdByUserId;
  String? sTypename;

  NewsfeedCategories(
      {this.id,
      this.categoryName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.createdByUserId,
      this.sTypename});

  NewsfeedCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    createdByUserId = json['created_by_user_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['created_by_user_id'] = this.createdByUserId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
