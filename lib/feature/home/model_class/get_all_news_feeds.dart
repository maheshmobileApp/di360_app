import 'package:di360_flutter/feature/home/model_class/dental_professional_res.dart';
import 'package:di360_flutter/feature/home/model_class/dental_supplier_res.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_like_res.dart';

class GetAllNewsFeeds {
  AllNewsFeedData? data;

  GetAllNewsFeeds({this.data});

  GetAllNewsFeeds.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new AllNewsFeedData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AllNewsFeedData {
  List<Newsfeeds>? newsfeeds;

  AllNewsFeedData({this.newsfeeds});

  AllNewsFeedData.fromJson(Map<String, dynamic> json) {
    if (json['newsfeeds'] != null) {
      newsfeeds = <Newsfeeds>[];
      json['newsfeeds'].forEach((v) {
        newsfeeds!.add(new Newsfeeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newsfeeds != null) {
      data['newsfeeds'] = this.newsfeeds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newsfeeds {
  String? id;
  String? createdAt;
  String? updatedAt;
  List<PostImage>? postImage;
  String? communityId;
  String? description;
  String? categoryType;
  dynamic attachments;
  String? feedType;
  dynamic payload;
  String? userRole;
  String? videoUrl;
  String? webUrl;
  String? userId;
  String? status;
  String? title;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  String? dentalAdminId;
  DentalSupplier? dentalSupplier;
  DentalProfessional? dentalProfessional;
  DentalPractice? dentalPractice;
  AdminUser? adminUser;
  List<dynamic>? courses;
  List<dynamic>? jobs;
  List<NewsfeedsLikes>? newsfeedsLikes;
  List<MyLike>? myLike;
  NewsfeedsLikesAggregate? newsfeedsLikesAggregate;
  List<NewsFeedsComments>? newsFeedsComments;
  NewsfeedsCommentAggregate? newsFeedsCommentsAggregate;
  String? sTypename;

  Newsfeeds(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.postImage,
      this.communityId,
      this.description,
      this.categoryType,
      this.attachments,
      this.feedType,
      this.payload,
      this.userRole,
      this.videoUrl,
      this.webUrl,
      this.userId,
      this.status,
      this.title,
      this.dentalPracticeId,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.dentalAdminId,
      this.dentalSupplier,
      this.dentalProfessional,
      this.dentalPractice,
      this.adminUser,
      this.courses,
      this.jobs,
      this.newsfeedsLikes,
      this.myLike,
      this.newsfeedsLikesAggregate,
      this.newsFeedsComments,
      this.newsFeedsCommentsAggregate,
      this.sTypename});

  Newsfeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['post_image'] != null) {
      if (json['post_image'] is List) {
        postImage = (json['post_image'] as List)
            .map((item) => PostImage.fromJson(item))
            .toList();
      } else if (json['post_image'] is Map) {
        postImage = [PostImage.fromJson(json['post_image'])];
      }
    }
    communityId = json['community_id'];
    description = json['description'];
    categoryType = json['category_type'];
    attachments = json['attachments'];
    feedType = json['feed_type'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    userRole = json['user_role'];
    videoUrl = json['video_url'];
    webUrl = json['web_url'];
    userId = json['user_id'];
    status = json['status'];
    title = json['title'];
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalAdminId = json['dental_admin_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    dentalPractice = json['dental_practice'] != null
        ? new DentalPractice.fromJson(json['dental_practice'])
        : null;
    adminUser = json['admin_user'] != null
        ? new AdminUser.fromJson(json['admin_user'])
        : null;
    courses = json['courses']?.cast<dynamic>();
    jobs = json['jobs']?.cast<dynamic>();
    if (json['newsfeeds_likes'] != null) {
      newsfeedsLikes = <NewsfeedsLikes>[];
      json['newsfeeds_likes'].forEach((v) {
        newsfeedsLikes!.add(new NewsfeedsLikes.fromJson(v));
      });
    }
    if (json['my_like'] != null) {
      myLike = <MyLike>[];
      json['my_like'].forEach((v) {
        myLike!.add(new MyLike.fromJson(v));
      });
    }
    newsfeedsLikesAggregate = json['newsfeeds_likes_aggregate'] != null
        ? new NewsfeedsLikesAggregate.fromJson(
            json['newsfeeds_likes_aggregate'])
        : null;
    if (json['news_feeds_comments'] != null) {
      newsFeedsComments = <NewsFeedsComments>[];
      json['news_feeds_comments'].forEach((v) {
        newsFeedsComments!.add(new NewsFeedsComments.fromJson(v));
      });
    }
    newsFeedsCommentsAggregate = json['news_feeds_comments_aggregate'] != null
        ? new NewsfeedsCommentAggregate.fromJson(
            json['news_feeds_comments_aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.postImage != null) {
      data['post_image'] = this.postImage!.map((v) => v.toJson()).toList();
    }
    data['community_id'] = this.communityId;
    data['description'] = this.description;
    data['category_type'] = this.categoryType;
    data['attachments'] = this.attachments;
    data['feed_type'] = this.feedType;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['user_role'] = this.userRole;
    data['video_url'] = this.videoUrl;
    data['web_url'] = this.webUrl;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['title'] = this.title;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['dental_admin_id'] = this.dentalAdminId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.adminUser != null) {
      data['admin_user'] = this.adminUser!.toJson();
    }
    data['courses'] = this.courses;
    data['jobs'] = this.jobs;
    if (this.newsfeedsLikes != null) {
      data['newsfeeds_likes'] =
          this.newsfeedsLikes!.map((v) => v.toJson()).toList();
    }
    if (this.myLike != null) {
      data['my_like'] = this.myLike!.map((v) => v.toJson()).toList();
    }
    if (this.newsfeedsLikesAggregate != null) {
      data['newsfeeds_likes_aggregate'] =
          this.newsfeedsLikesAggregate!.toJson();
    }
    if (this.newsFeedsComments != null) {
      data['news_feeds_comments'] =
          this.newsFeedsComments!.map((v) => v.toJson()).toList();
    }
    if (this.newsFeedsCommentsAggregate != null) {
      data['news_feeds_comments_aggregate'] =
          this.newsFeedsCommentsAggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class MyLike {
  String? id;

  MyLike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {'id': id};
}

class PostImage {
  String? id;
  String? url;
  String? name;
  String? type;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  PostImage(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  PostImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['is_public'];
    directory = json['directory'];
    extension = json['extension'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['is_public'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    return data;
  }
}

class Payload {
  String? catalogueId;

  Payload({this.catalogueId});

  Payload.fromJson(Map<String, dynamic> json) {
    catalogueId = json['catalogue_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catalogue_id'] = this.catalogueId;
    return data;
  }
}

class AdminUser {
  String? id;
  String? phone;
  String? email;
  String? sTypename;

  AdminUser({this.id, this.phone, this.email, this.sTypename});

  AdminUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class NewsfeedsLikesAggregate {
  Aggregate? aggregate;
  String? sTypename;

  NewsfeedsLikesAggregate({this.aggregate, this.sTypename});

  NewsfeedsLikesAggregate.fromJson(Map<String, dynamic> json) {
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

class NewsfeedsCommentAggregate {
  CommentAggregate? aggregate;
  String? sTypename;

  NewsfeedsCommentAggregate({this.aggregate, this.sTypename});

  NewsfeedsCommentAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new CommentAggregate.fromJson(json['aggregate'])
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

class CommentAggregate {
  int? count;
  String? sTypename;

  CommentAggregate({this.count, this.sTypename});

  CommentAggregate.fromJson(Map<String, dynamic> json) {
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
