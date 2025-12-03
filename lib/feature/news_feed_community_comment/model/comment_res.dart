class CommentRes {
  CommentData? data;

  CommentRes({this.data});

  CommentRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommentData {
  InsertNewsFeedsCommentsOne? insertNewsFeedsCommentsOne;

  CommentData({this.insertNewsFeedsCommentsOne});

  CommentData.fromJson(Map<String, dynamic> json) {
    insertNewsFeedsCommentsOne = json['insert_news_feeds_comments_one'] != null
        ? new InsertNewsFeedsCommentsOne.fromJson(
            json['insert_news_feeds_comments_one'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertNewsFeedsCommentsOne != null) {
      data['insert_news_feeds_comments_one'] =
          this.insertNewsFeedsCommentsOne!.toJson();
    }
    return data;
  }
}

class InsertNewsFeedsCommentsOne {
  String? id;
  String? comments;
  String? createdAt;
  String? dentalAdminId;
  String? commentProImg;
  String? commenterName;
  List<Null>? commentsAttachments;
  List<Null>? commentReply;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  dynamic dentalPractice;
  dynamic dentalProfessional;
  dynamic adminUser;
  String? sTypename;

  InsertNewsFeedsCommentsOne(
      {this.id,
      this.comments,
      this.createdAt,
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
      this.sTypename});

  InsertNewsFeedsCommentsOne.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    createdAt = json['created_at'];
    dentalAdminId = json['dental_admin_id'];
    commentProImg = json['comment_Pro_Img'];
    commenterName = json['commenter_name'];
    if (json['comments_attachments'] != null) {
      commentsAttachments = <Null>[];
      json['comments_attachments'].forEach((v) {
        commentsAttachments!.add(null);
      });
    }
    if (json['comment_reply'] != null) {
      commentReply = <Null>[];
      json['comment_reply'].forEach((v) {
        commentReply!.add(null);
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
    sTypename = json['__typename'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['dental_admin_id'] = this.dentalAdminId;
    data['comment_Pro_Img'] = this.commentProImg;
    data['commenter_name'] = this.commenterName;
    // if (this.commentsAttachments != null) {
    //   data['comments_attachments'] =
    //       this.commentsAttachments!.map((v) => v.toJson()).toList();
    // }
    // if (this.commentReply != null) {
    //   data['comment_reply'] =
    //       this.commentReply!.map((v) => v.toJson()).toList();
    // }
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional'] = this.dentalProfessional;
    data['admin_user'] = this.adminUser;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? name;

  DentalSupplier({this.name});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
