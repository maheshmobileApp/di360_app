class GetNewsFeedCommunityRes {
  NewsFeedCommunityData? data;

  GetNewsFeedCommunityRes({this.data});

  GetNewsFeedCommunityRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? NewsFeedCommunityData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
        if (data != null) 'data': data!.toJson(),
      };
}

class NewsFeedCommunityData {
  List<Newsfeeds>? newsfeeds;

  NewsFeedCommunityData({this.newsfeeds});

  NewsFeedCommunityData.fromJson(Map<String, dynamic> json) {
    if (json['newsfeeds'] != null) {
      newsfeeds =
          (json['newsfeeds'] as List).map((v) => Newsfeeds.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        if (newsfeeds != null)
          'newsfeeds': newsfeeds!.map((v) => v.toJson()).toList(),
      };
}

class Newsfeeds {
  String? id;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? postImage;
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

  dynamic dentalSupplier;
  DentalProfessional? dentalProfessional;
  dynamic dentalPractice;
  dynamic adminUser;

  List<dynamic>? courses;
  List<dynamic>? jobs;

  List<NewsfeedsLikes>? newsfeedsLikes;
  List<MyLike>? myLike;

  NewsfeedsLikesAggregate? newsfeedsLikesAggregate;

  List<NewsFeedsComments>? newsFeedsComments;
  NewsfeedsLikesAggregate? newsFeedsCommentsAggregate;

  String? sTypename;

  Newsfeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    postImage = json['post_image'];
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

    dentalSupplier = json['dental_supplier'];
    dentalPractice = json['dental_practice'];
    adminUser = json['admin_user'];

    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(json['dental_professional'])
        : null;

    courses = json['courses'];
    jobs = json['jobs'];

    if (json['newsfeeds_likes'] != null) {
      newsfeedsLikes = (json['newsfeeds_likes'] as List)
          .map((v) => NewsfeedsLikes.fromJson(v))
          .toList();
    }

    if (json['my_like'] != null) {
      myLike =
          (json['my_like'] as List).map((v) => MyLike.fromJson(v)).toList();
    }

    newsfeedsLikesAggregate = json['newsfeeds_likes_aggregate'] != null
        ? NewsfeedsLikesAggregate.fromJson(json['newsfeeds_likes_aggregate'])
        : null;

    if (json['news_feeds_comments'] != null) {
      newsFeedsComments = (json['news_feeds_comments'] as List)
          .map((v) => NewsFeedsComments.fromJson(v))
          .toList();
    }

    newsFeedsCommentsAggregate = json['news_feeds_comments_aggregate'] != null
        ? NewsfeedsLikesAggregate.fromJson(
            json['news_feeds_comments_aggregate'])
        : null;

    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'post_image': postImage,
        'community_id': communityId,
        'description': description,
        'category_type': categoryType,
        'attachments': attachments,
        'feed_type': feedType,
        'payload': payload,
        'user_role': userRole,
        'video_url': videoUrl,
        'web_url': webUrl,
        'user_id': userId,
        'status': status,
        'title': title,
        'dental_practice_id': dentalPracticeId,
        'dental_professional_id': dentalProfessionalId,
        'dental_supplier_id': dentalSupplierId,
        'dental_admin_id': dentalAdminId,
        if (dentalProfessional != null)
          'dental_professional': dentalProfessional!.toJson(),
        'newsfeeds_likes': newsfeedsLikes?.map((e) => e.toJson()).toList(),
        'my_like': myLike?.map((e) => e.toJson()).toList(),
        if (newsfeedsLikesAggregate != null)
          'newsfeeds_likes_aggregate': newsfeedsLikesAggregate!.toJson(),
        'news_feeds_comments':
            newsFeedsComments?.map((e) => e.toJson()).toList(),
        if (newsFeedsCommentsAggregate != null)
          'news_feeds_comments_aggregate':
              newsFeedsCommentsAggregate!.toJson(),
        '__typename': sTypename,
      };
}

class DentalProfessional {
  String? id;
  String? name;
  String? professionType;
  ProfileImage? profileImage;

  String? email;
  String? phone;
  String? type;

  String? sTypename;

  DentalProfessional({
    this.id,
    this.name,
    this.professionType,
    this.profileImage,
    this.email,
    this.phone,
    this.type,
    this.sTypename,
  });

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    professionType = json['profession_type'];

    profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null;

    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profession_type': professionType,
        if (profileImage != null) 'profile_image': profileImage!.toJson(),
        'email': email,
        'phone': phone,
        'type': type,
        '__typename': sTypename,
      };
}

class ProfileImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ProfileImage({
    this.url,
    this.name,
    this.size,
    this.status,
    this.fileId,
    this.isPublic,
    this.directory,
    this.extension,
    this.mimeType,
  });

  ProfileImage.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'size': size,
        'status': status,
        'file_id': fileId,
        'isPublic': isPublic,
        'directory': directory,
        'extension': extension,
        'mime_type': mimeType,
      };
}

class NewsfeedsLikes {
  String? id;
  DentalSupplier? dentalSupplier;
  DentalProfessional? dentalProfessional;

  String? sTypename;

  NewsfeedsLikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    dentalSupplier = json['dental_supplier'] != null
        ? DentalSupplier.fromJson(json['dental_supplier'])
        : null;

    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(json['dental_professional'])
        : null;

    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        if (dentalSupplier != null)
          'dental_supplier': dentalSupplier!.toJson(),
        if (dentalProfessional != null)
          'dental_professional': dentalProfessional!.toJson(),
        '__typename': sTypename,
      };
}

class DentalSupplier {
  String? businessName;
  List<Directory>? directories;
  String? sTypename;

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    directories = json['directories'] != null
        ? (json['directories'] as List)
            .map((v) => Directory.fromJson(v))
            .toList()
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'business_name': businessName,
        if (directories != null)
          'directories': directories!.map((v) => v.toJson()).toList(),
        '__typename': sTypename,
      };
}

class Directory {
  String? id;
  ProfileImage? profileImage;
  String? sTypename;

  Directory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        if (profileImage != null) 'profile_image': profileImage!.toJson(),
        '__typename': sTypename,
      };
}

class MyLike {
  String? id;

  MyLike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {'id': id};
}

class NewsfeedsLikesAggregate {
  Aggregate? aggregate;
  String? sTypename;

  NewsfeedsLikesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate =
        json['aggregate'] != null ? Aggregate.fromJson(json['aggregate']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() =>
      {'aggregate': aggregate?.toJson(), '__typename': sTypename};
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() =>
      {'count': count, '__typename': sTypename};
}

class NewsFeedsComments {
  String? id;
  String? comments;
  String? createdAt;
  String? updatedAt;

  String? commenterName;

  List<dynamic>? commentsAttachments;
  List<dynamic>? commentReply;

  String? dentalProfessionalId;

  DentalProfessional? dentalProfessional;

  Directory? newsfeed;
  String? sTypename;

  NewsFeedsComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commenterName = json['commenter_name'];

    commentsAttachments = json['comments_attachments'];
    commentReply = json['comment_reply'];

    dentalProfessionalId = json['dental_professional_id'];

    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(json['dental_professional'])
        : null;

    newsfeed =
        json['newsfeed'] != null ? Directory.fromJson(json['newsfeed']) : null;

    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'comments': comments,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'commenter_name': commenterName,
        'comments_attachments': commentsAttachments,
        'comment_reply': commentReply,
        'dental_professional_id': dentalProfessionalId,
        if (dentalProfessional != null)
          'dental_professional': dentalProfessional!.toJson(),
        if (newsfeed != null) 'newsfeed': newsfeed!.toJson(),
        '__typename': sTypename,
      };
}
