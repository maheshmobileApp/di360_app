class NewsFeedsComments {
  String? id;
  String? comments;
  String? createdAt;
  String? dentalAdminId;
  String? commentProImg;
  String? commenterName;
  List<CommentsAttachments>? commentsAttachments;
  List<CommentReply>? commentReply;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  CommentDentalSupplier? dentalSupplier;
  CommentDentalPartice? dentalPractice;
  CommentDentalprofessional? dentalProfessional;
  CommentAdminUser? adminUser;
  String? sTypename;

  NewsFeedsComments(
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

  NewsFeedsComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    createdAt = json['created_at'];
    dentalAdminId = json['dental_admin_id'];
    commentProImg = json['comment_Pro_Img'];
    commenterName = json['commenter_name'];
    if (json['comments_attachments'] != null) {
      commentsAttachments = <CommentsAttachments>[];
      json['comments_attachments'].forEach((v) {
        commentsAttachments!.add(new CommentsAttachments.fromJson(v));
      });
    }
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
        ? new CommentDentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'] != null
        ? new CommentDentalPartice.fromJson(json['dental_practice'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new CommentDentalprofessional.fromJson(json['dental_professional'])
        : null;
    adminUser = json['admin_user'] != null
        ? new CommentAdminUser.fromJson(json['admin_user'])
        : null;
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
    if (this.commentsAttachments != null) {
      data['comments_attachments'] =
          this.commentsAttachments!.map((v) => null).toList();
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
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    if (this.adminUser != null) {
      data['admin_user'] = this.adminUser!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentReply {
  String? id;
  String? replyText;
  String? commentId;
  String? replyId;
  List<ReplyAttachments>? replyAttachments;
  String? dentalAdminId;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  CommentReplyDentalSupplier? dentalSupplier;
  CommentReplyDentalPartice? dentalPractice;
  CommentReplyDentalProfessional? dentalProfessional;
  AdminUser? adminUser;
  String? sTypename;

  CommentReply(
      {this.id,
      this.replyText,
      this.commentId,
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
      this.sTypename});

  CommentReply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    replyText = json['reply_text'];
    commentId = json['comment_id'];
    replyId = json['reply_id'];
    if (json['reply_attachments'] != null) {
      replyAttachments = <ReplyAttachments>[];
      json['reply_attachments'].forEach((v) {
        replyAttachments!.add(new ReplyAttachments.fromJson(v));
      });
    }
    dentalAdminId = json['dental_admin_id'];
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new CommentReplyDentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'] != null
        ? new CommentReplyDentalPartice.fromJson(json['dental_practice'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new CommentReplyDentalProfessional.fromJson(
            json['dental_professional'])
        : null;
    adminUser = json['admin_user'] != null
        ? new AdminUser.fromJson(json['admin_user'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reply_text'] = this.replyText;
    data['comment_id'] = this.commentId;
    data['reply_id'] = this.replyId;
    if (this.replyAttachments != null) {
      data['reply_attachments'] = this.replyAttachments!;
    }
    data['dental_admin_id'] = this.dentalAdminId;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    if (this.adminUser != null) {
      data['admin_user'] = this.adminUser!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentDentalSupplier {
  String? name;
  CommentSupplierLogo? logo;
//  List<Directories>? directories;
  String? sTypename;

  CommentDentalSupplier({this.name, this.logo, this.sTypename});

  CommentDentalSupplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'] != null
        ? new CommentSupplierLogo.fromJson(json['logo'])
        : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentSupplierLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  CommentSupplierLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  CommentSupplierLogo.fromJson(Map<String, dynamic> json) {
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

class CommentDentalPartice {
  String? name;
  CommentParticeLogo? logo;
//  List<Directories>? directories;
  String? sTypename;

  CommentDentalPartice({this.name, this.logo, this.sTypename});

  CommentDentalPartice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'] != null
        ? new CommentParticeLogo.fromJson(json['logo'])
        : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentParticeLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  CommentParticeLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  CommentParticeLogo.fromJson(Map<String, dynamic> json) {
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

class CommentDentalprofessional {
  String? name;
  CommentProfessionalLogo? profileImage;
  // List<Directories>? directories;
  String? sTypename;

  CommentDentalprofessional({this.name, this.profileImage, this.sTypename});

  CommentDentalprofessional.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'] != null
        ? new CommentProfessionalLogo.fromJson(json['profile_image'])
        : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentProfessionalLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  CommentProfessionalLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  CommentProfessionalLogo.fromJson(Map<String, dynamic> json) {
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

class CommentReplyDentalSupplier {
  String? name;
  SupplierLogo? logo;
//  List<Directories>? directories;
  String? sTypename;

  CommentReplyDentalSupplier({this.name, this.logo, this.sTypename});

  CommentReplyDentalSupplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo =
        json['logo'] != null ? new SupplierLogo.fromJson(json['logo']) : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplierLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  SupplierLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  SupplierLogo.fromJson(Map<String, dynamic> json) {
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

class Directories {
  String? id;
  String? sTypename;

  Directories({this.id, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentReplyDentalPartice {
  String? name;
  ParticesLogo? logo;
//  List<Directories>? directories;
  String? sTypename;

  CommentReplyDentalPartice({this.name, this.logo, this.sTypename});

  CommentReplyDentalPartice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo =
        json['logo'] != null ? new ParticesLogo.fromJson(json['logo']) : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ParticesLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ParticesLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ParticesLogo.fromJson(Map<String, dynamic> json) {
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

class CommentReplyDentalProfessional {
  String? name;
  ProfessionalLogo? profileImage;
//  List<Directories>? directories;
  String? sTypename;

  CommentReplyDentalProfessional(
      {this.name, this.profileImage, this.sTypename});

  CommentReplyDentalProfessional.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'] != null
        ? new ProfessionalLogo.fromJson(json['profile_image'])
        : null;
    // if (json['directories'] != null) {
    //   directories = <Directories>[];
    //   json['directories'].forEach((v) {
    //     directories!.add(new Directories.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    // if (this.directories != null) {
    //   data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProfessionalLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ProfessionalLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ProfessionalLogo.fromJson(Map<String, dynamic> json) {
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

class AdminUser {
  String? name;
  String? profileImage;
  String? sTypename;

  AdminUser({this.name, this.profileImage, this.sTypename});

  AdminUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentAdminUser {
  String? id;
  String? name;
  String? profileImage;
  String? sTypename;

  CommentAdminUser({this.id, this.name, this.profileImage, this.sTypename});

  CommentAdminUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CommentsAttachments {
  String? url;
  String? name;
  String? type;

  CommentsAttachments({this.url, this.name, this.type});

  CommentsAttachments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class ReplyAttachments {
  String? url;
  String? name;
  String? type;

  ReplyAttachments({this.url, this.name, this.type});

  ReplyAttachments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}