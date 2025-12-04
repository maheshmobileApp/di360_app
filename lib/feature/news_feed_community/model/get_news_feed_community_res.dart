import '../../home/model_class/get_all_news_feeds.dart';

class GetNewsFeedCommunityRes {
  NewsFeedCommunityData? data;

  GetNewsFeedCommunityRes({this.data});

  GetNewsFeedCommunityRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NewsFeedCommunityData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NewsFeedCommunityData {
  List<Newsfeeds>? newsfeeds;

  NewsFeedCommunityData({this.newsfeeds});

  NewsFeedCommunityData.fromJson(Map<String, dynamic> json) {
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
/*
class Newsfeeds {
  String? id;
  String? createdAt;
  String? updatedAt;
  List<PostImage>? postImage;
  String? communityId;
  String? description;
  String? categoryType;
  Null? attachments;
  String? feedType;
  Null? payload;
  String? userRole;
  String? videoUrl;
  String? webUrl;
  String? userId;
  String? status;
  Null? title;
  Null? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  Null? dentalAdminId;
  DentalSupplier? dentalSupplier;
  DentalProfessional? dentalProfessional;
  Null? dentalPractice;
  Null? adminUser;
  List<Null>? courses;
  List<Null>? jobs;
  List<NewsfeedsLikes>? newsfeedsLikes;
  List<MyLike>? myLike;
  NewsfeedsLikesAggregate? newsfeedsLikesAggregate;
  List<NewsFeedsComments>? newsFeedsComments;
  NewsfeedsLikesAggregate? newsFeedsCommentsAggregate;
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
      postImage = <PostImage>[];
      json['post_image'].forEach((v) {
        postImage!.add(new PostImage.fromJson(v));
      });
    }
    communityId = json['community_id'];
    description = json['description'];
    categoryType = json['category_type'];
    attachments = json['attachments'];
    feedType = json['feed_type'];
    payload = json['payload'];
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
    dentalPractice = json['dental_practice'];
    adminUser = json['admin_user'];
    // courses = json['courses']; // Handle as needed
    // jobs = json['jobs']; // Handle as needed
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
        ? new NewsfeedsLikesAggregate.fromJson(
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
    data['payload'] = this.payload;
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
    data['dental_practice'] = this.dentalPractice;
    data['admin_user'] = this.adminUser;
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
}*/

class PostImage {
  String? url;
  String? name;
  int? size;
  String? type;

  PostImage({this.url, this.name, this.size, this.type});

  PostImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
  }

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['type'] = this.type;
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

class DentalSupplier {
  String? id;
  Logo? logo;
  String? businessName;
  String? professionType;
  String? email;
  String? phone;
  String? name;
  String? type;
  List<Directories>? directories;
  String? sTypename;

  DentalSupplier(
      {this.id,
      this.logo,
      this.businessName,
      this.professionType,
      this.email,
      this.phone,
      this.name,
      this.type,
      this.directories,
      this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'] != null ? Logo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    professionType = json['profession_type'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    type = json['type'];
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
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['business_name'] = this.businessName;
    data['profession_type'] = this.professionType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Directories {
  String? id;
  String? companyName;
  Logo? logo;
  String? description;
  Logo? bannerImage;
  String? sTypename;

  Directories(
      {this.id,
      this.companyName,
      this.logo,
      this.description,
      this.bannerImage,
      this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    description = json['description'];
    bannerImage = json['banner_image'] != null
        ? new Logo.fromJson(json['banner_image'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['description'] = this.description;
    if (this.bannerImage != null) {
      data['banner_image'] = this.bannerImage!.toJson();
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

class DentalProfessional {
  String? id;
  String? name;
  String? professionType;
  Logo? profileImage;
  String? email;
  String? phone;
  String? type;
  String? sTypename;

  DentalProfessional(
      {this.id,
      this.name,
      this.professionType,
      this.profileImage,
      this.email,
      this.phone,
      this.type,
      this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    professionType = json['profession_type'];
    profileImage = json['profile_image'] != null
        ? new Logo.fromJson(json['profile_image'])
        : null;
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profession_type'] = this.professionType;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class NewsfeedsLikes {
  String? id;
  String? dentalAdminId;
  dynamic adminUser;
  dynamic dentalPractice;
  DentalSupplier? dentalSupplier;
  DentalProfessional? dentalProfessional;
  String? sTypename;

  NewsfeedsLikes(
      {this.id,
      this.dentalAdminId,
      this.adminUser,
      this.dentalPractice,
      this.dentalSupplier,
      this.dentalProfessional,
      this.sTypename});

  NewsfeedsLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentalAdminId = json['dental_admin_id'];
    adminUser = json['admin_user'];
    dentalPractice = json['dental_practice'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dental_admin_id'] = this.dentalAdminId;
    data['admin_user'] = this.adminUser;
    data['dental_practice'] = this.dentalPractice;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
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


class CommentReply {
  String? id;
  String? replyText;
  String? commentId;
  String? createdAt;
  String? replyId;
  List<dynamic>? replyAttachments;
  String? dentalAdminId;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  dynamic dentalPractice;
  dynamic dentalProfessional;
  dynamic adminUser;
  dynamic newsfeeds;
  dynamic jobs;
  dynamic courses;
  String? sTypename;

  CommentReply(
      {this.id,
      this.replyText,
      this.commentId,
      this.createdAt,
      this.replyId,
      this.replyAttachments,
      this.dentalAdminId,
      this.dentalPracticeId,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.dentalPractice,
      this.dentalProfessional,
      this.adminUser,
      this.newsfeeds,
      this.jobs,
      this.courses,
      this.sTypename});

  CommentReply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    replyText = json['reply_text'];
    commentId = json['comment_id'];
    createdAt = json['created_at'];
    replyId = json['reply_id'];
    // replyAttachments = json['reply_attachments']; // Handle as needed
    dentalAdminId = json['dental_admin_id'];
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'];
    dentalProfessional = json['dental_professional'];
    adminUser = json['admin_user'];
    newsfeeds = json['newsfeeds'];
    jobs = json['jobs'];
    courses = json['courses'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reply_text'] = this.replyText;
    data['comment_id'] = this.commentId;
    data['created_at'] = this.createdAt;
    data['reply_id'] = this.replyId;
    data['reply_attachments'] = this.replyAttachments;
    data['dental_admin_id'] = this.dentalAdminId;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional'] = this.dentalProfessional;
    data['admin_user'] = this.adminUser;
    data['newsfeeds'] = this.newsfeeds;
    data['jobs'] = this.jobs;
    data['courses'] = this.courses;
    data['__typename'] = this.sTypename;
    return data;
  }
}


class NewsFeedsComments {
  String? id;
  String? comments;
  String? createdAt;
  String? updatedAt;
  String? dentalAdminId;
  String? commentProImg;
  String? commenterName;
  List<dynamic>? commentsAttachments;
  List<CommentReply>? commentReply;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  dynamic dentalPractice;
  dynamic dentalProfessional;
  dynamic adminUser;
  Directories? newsfeed;
  dynamic jobs;
  dynamic courses;
  String? sTypename;

  NewsFeedsComments(
      {this.id,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.dentalAdminId,
      this.commentProImg,
      this.commenterName,
      this.commentsAttachments,
      this.commentReply,
      this.dentalPracticeId,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.dentalPractice,
      this.dentalProfessional,
      this.adminUser,
      this.newsfeed,
      this.jobs,
      this.courses,
      this.sTypename});

  NewsFeedsComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dentalAdminId = json['dental_admin_id'];
    commentProImg = json['comment_Pro_Img'];
    commenterName = json['commenter_name'];
    // commentsAttachments = json['comments_attachments']; // Handle as needed
    if (json['comment_reply'] != null) {
      commentReply = <CommentReply>[];
      json['comment_reply'].forEach((v) {
        commentReply!.add(new CommentReply.fromJson(v));
      });
    }
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'];
    dentalProfessional = json['dental_professional'];
    adminUser = json['admin_user'];
    newsfeed = json['newsfeed'] != null
        ? new Directories.fromJson(json['newsfeed'])
        : null;
    jobs = json['jobs'];
    courses = json['courses'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dental_admin_id'] = this.dentalAdminId;
    data['comment_Pro_Img'] = this.commentProImg;
    data['commenter_name'] = this.commenterName;
    if (this.commentsAttachments != null) {
      data['comments_attachments'] = this.commentsAttachments;
    }
    if (this.commentReply != null) {
      data['comment_reply'] =
          this.commentReply!.map((v) => v.toJson()).toList();
    }
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional'] = this.dentalProfessional;
    data['admin_user'] = this.adminUser;
    if (this.newsfeed != null) {
      data['newsfeed'] = this.newsfeed!.toJson();
    }
    data['jobs'] = this.jobs;
    data['courses'] = this.courses;
    data['__typename'] = this.sTypename;
    return data;
  }
}



