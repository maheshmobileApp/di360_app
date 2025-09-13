class GetDirectoryDetailsRes {
  DirectoryDetailsData? data;

  GetDirectoryDetailsRes({this.data});

  GetDirectoryDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new DirectoryDetailsData.fromJson(json['data'])
        : null;
  }
}

class DirectoryDetailsData {
  DirectoriesByPk? directoriesByPk;

  DirectoryDetailsData({this.directoriesByPk});

  DirectoryDetailsData.fromJson(Map<String, dynamic> json) {
    directoriesByPk = json['directories_by_pk'] != null
        ? new DirectoriesByPk.fromJson(json['directories_by_pk'])
        : null;
  }
}

class DirectoriesByPk {
  String? id;
  String? description;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? altPhone;
  dynamic hobbies;
  dynamic universitySchool;
  dynamic abnAcn;
  String? companyName;
  dynamic profession;
  String? type;
  dynamic education;
  String? professionType;
  dynamic designation;
  dynamic workingAt;
  BannerImage? bannerImage;
  Logo? logo;
  double? latitude;
  double? longitude;
  ProfileImage? profileImage;
  dynamic dentalPracticeId;
  dynamic dentalProfessionalId;
  String? dentalSupplierId;
  List<DirectoryDocuments>? directoryDocuments;
  List<DirectoryLocations>? directoryLocations;
  List<DirectoryServices>? directoryServices;
  List<DirectoryAchievements>? directoryAchievements;
  List<DirectoryCertification>? directoryCertifications;
  List<DirectoryAppointmentSlots>? directoryAppointmentSlots;
  List<DirectoryTeamMembers>? directoryTeamMembers;
  List<DirectoryGalleryPosts>? directoryGalleryPosts;
  List<DirectoryTestimonials>? directoryTestimonials;
  List<DirectoryFaqs>? directoryFaqs;
  String? sTypename;

  DirectoriesByPk(
      {this.id,
      this.description,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.altPhone,
      this.hobbies,
      this.universitySchool,
      this.abnAcn,
      this.companyName,
      this.profession,
      this.type,
      this.education,
      this.professionType,
      this.designation,
      this.workingAt,
      this.bannerImage,
      this.logo,
      this.latitude,
      this.longitude,
      this.profileImage,
      this.dentalPracticeId,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.directoryDocuments,
      this.directoryLocations,
      this.directoryServices,
      this.directoryAchievements,
      this.directoryCertifications,
      this.directoryAppointmentSlots,
      this.directoryTeamMembers,
      this.directoryGalleryPosts,
      this.directoryTestimonials,
      this.directoryFaqs,
      this.sTypename});

  DirectoriesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    altPhone = json['alt_phone'];
    hobbies = json['hobbies'];
    universitySchool = json['university_school'];
    abnAcn = json['abn_acn'];
    companyName = json['company_name'];
    profession = json['profession'];
    type = json['type'];
    education = json['education'];
    professionType = json['profession_type'];
    designation = json['designation'];
    workingAt = json['working_at'];
    bannerImage = json['banner_image'] != null
        ? new BannerImage.fromJson(json['banner_image'])
        : null;
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    if (json['directory_documents'] != null) {
      directoryDocuments = <DirectoryDocuments>[];
      json['directory_documents'].forEach((v) {
        directoryDocuments!.add(new DirectoryDocuments.fromJson(v));
      });
    }
    if (json['directory_locations'] != null) {
      directoryLocations = <DirectoryLocations>[];
      json['directory_locations'].forEach((v) {
        directoryLocations!.add(new DirectoryLocations.fromJson(v));
      });
    }
    if (json['directory_services'] != null) {
      directoryServices = <DirectoryServices>[];
      json['directory_services'].forEach((v) {
        directoryServices!.add(new DirectoryServices.fromJson(v));
      });
    }
    if (json['directory_achievements'] != null) {
      directoryAchievements = <DirectoryAchievements>[];
      json['directory_achievements'].forEach((v) {
        directoryAchievements!.add(new DirectoryAchievements.fromJson(v));
      });
    }
    if (json['directory_certifications'] != null) {
      directoryCertifications = <DirectoryCertification>[];
      json['directory_certifications'].forEach((v) {
        directoryCertifications!.add(new DirectoryCertification.fromJson(v));
      });
    }
    if (json['directory_appointment_slots'] != null) {
      directoryAppointmentSlots = <DirectoryAppointmentSlots>[];
      json['directory_appointment_slots'].forEach((v) {
        directoryAppointmentSlots!
            .add(new DirectoryAppointmentSlots.fromJson(v));
      });
    }
    if (json['directory_team_members'] != null) {
      directoryTeamMembers = <DirectoryTeamMembers>[];
      json['directory_team_members'].forEach((v) {
        directoryTeamMembers!.add(new DirectoryTeamMembers.fromJson(v));
      });
    }
    if (json['directory_gallery_posts'] != null) {
      directoryGalleryPosts = <DirectoryGalleryPosts>[];
      json['directory_gallery_posts'].forEach((v) {
        directoryGalleryPosts!.add(new DirectoryGalleryPosts.fromJson(v));
      });
    }
    if (json['directory_testimonials'] != null) {
      directoryTestimonials = <DirectoryTestimonials>[];
      json['directory_testimonials'].forEach((v) {
        directoryTestimonials!.add(new DirectoryTestimonials.fromJson(v));
      });
    }
    if (json['directory_faqs'] != null) {
      directoryFaqs = <DirectoryFaqs>[];
      json['directory_faqs'].forEach((v) {
        directoryFaqs!.add(new DirectoryFaqs.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }
}

class BannerImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  BannerImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  BannerImage.fromJson(Map<String, dynamic> json) {
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

  ProfileImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

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

class DocumentsBannerImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  DocumentsBannerImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  DocumentsBannerImage.fromJson(Map<String, dynamic> json) {
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

class DirectoryDocuments {
  String? id;
  String? name;
  DocumentsBannerImage? attachment;
  String? sTypename;

  DirectoryDocuments({this.id, this.name, this.attachment, this.sTypename});

  DirectoryDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attachment = json['attachment'] != null
        ? new DocumentsBannerImage.fromJson(json['attachment'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoryLocations {
  String? id;
  dynamic mediaName;
  dynamic mediaLink;
  String? status;
  String? weekName;
  String? clinicTime;
  String? sTypename;

  DirectoryLocations(
      {this.id,
      this.mediaName,
      this.mediaLink,
      this.status,
      this.weekName,
      this.clinicTime,
      this.sTypename});

  DirectoryLocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaName = json['media_name'];
    mediaLink = json['media_link'];
    status = json['status'];
    weekName = json['week_name'];
    clinicTime = json['clinic_time'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media_name'] = this.mediaName;
    data['media_link'] = this.mediaLink;
    data['status'] = this.status;
    data['week_name'] = this.weekName;
    data['clinic_time'] = this.clinicTime;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoryServices {
  String? id;
  String? name;
  ServicesImage? image;
  String? description;
  dynamic showInAppointments;
  String? sTypename;

  DirectoryServices(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.showInAppointments,
      this.sTypename});

  DirectoryServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null
        ? new ServicesImage.fromJson(json['image'])
        : null;
    description = json['description'];
    showInAppointments = json['show_in_appointments'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['show_in_appointments'] = this.showInAppointments;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ServicesImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ServicesImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ServicesImage.fromJson(Map<String, dynamic> json) {
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
}

class DirectoryAchievements {
  String? id;
  String? title;
  AttachmentImage? attachments;
  String? sTypename;

  DirectoryAchievements(
      {this.id, this.title, this.attachments, this.sTypename});

  DirectoryAchievements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    attachments = json['attachments'] != null
        ? new AttachmentImage.fromJson(json['attachments'])
        : null;
    sTypename = json['__typename'];
  }
}

class AttachmentImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  AttachmentImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  AttachmentImage.fromJson(Map<String, dynamic> json) {
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
    return {
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
}

class DirectoryCertification {
  String? id;
  String? title;
  CertificationImage? attachments;
  String? sTypename;

  DirectoryCertification(
      {this.id, this.title, this.attachments, this.sTypename});

  DirectoryCertification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    attachments = json['attachments'] != null
        ? new CertificationImage.fromJson(json['attachments'])
        : null;
    sTypename = json['__typename'];
  }
}

class CertificationImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  CertificationImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  CertificationImage.fromJson(Map<String, dynamic> json) {
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
    return {
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
}

class DirectoryAppointmentSlots {
  String? id;
  String? sTypename;

  DirectoryAppointmentSlots({this.id, this.sTypename});

  DirectoryAppointmentSlots.fromJson(Map<String, dynamic> json) {
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

class DirectoryTeamMembers {
  String? id;
  String? name;
  String? specialization;
  TeamMemberImage? image;
  String? phone;
  String? email;
  bool? showInOurTeam;
  bool? showInAppointments;
  String? location;
  String? sTypename;

  DirectoryTeamMembers(
      {this.id,
      this.name,
      this.specialization,
      this.image,
      this.phone,
      this.email,
      this.showInOurTeam,
      this.showInAppointments,
      this.location,
      this.sTypename});

  DirectoryTeamMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialization = json['specialization'];
    image = json['image'] != null
        ? new TeamMemberImage.fromJson(json['image'])
        : null;
    phone = json['phone'];
    email = json['email'];
    showInOurTeam = json['show_in_our_team'];
    showInAppointments = json['show_in_appointments'];
    location = json['location'];
    sTypename = json['__typename'];
  }
}

class TeamMemberImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  TeamMemberImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  TeamMemberImage.fromJson(Map<String, dynamic> json) {
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

class DirectoryGalleryPosts {
  String? id;
  List<Image>? image;
  dynamic beforeImage;
  dynamic afterImage;
  dynamic bannerImage;
  dynamic profileImage;
  dynamic logo;
  dynamic beforeAndAfter;
  String? sTypename;

  DirectoryGalleryPosts(
      {this.id,
      this.image,
      this.beforeImage,
      this.afterImage,
      this.bannerImage,
      this.profileImage,
      this.logo,
      this.beforeAndAfter,
      this.sTypename});

  DirectoryGalleryPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    beforeImage = json['before_image'];
    afterImage = json['after_image'];
    bannerImage = json['banner_image'];
    profileImage = json['profile_image'];
    logo = json['logo'];
    beforeAndAfter = json['before_and_after'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['before_image'] = this.beforeImage;
    data['after_image'] = this.afterImage;
    data['banner_image'] = this.bannerImage;
    data['profile_image'] = this.profileImage;
    data['logo'] = this.logo;
    data['before_and_after'] = this.beforeAndAfter;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Image {
  String? url;
  String? name;
  int? size;
  String? type;
  String? status;
  String? mimeType;

  Image(
      {this.url, this.name, this.size, this.type, this.status, this.mimeType});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
    status = json['status'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['type'] = this.type;
    data['status'] = this.status;
    data['mime_type'] = this.mimeType;
    return data;
  }
}

class DirectoryTestimonials {
  String? id;
  TestimonialsImage? profileImage;
  String? name;
  String? message;
  MsgPicImage? msgPic;
  String? role;
  String? sTypename;

  DirectoryTestimonials(
      {this.id,
      this.profileImage,
      this.name,
      this.message,
      this.msgPic,
      this.role,
      this.sTypename});

  DirectoryTestimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profile_image'] != null
        ? new TestimonialsImage.fromJson(json['profile_image'])
        : null;
    name = json['name'];
    message = json['message'];
    msgPic = json['msg_pic'] != null
        ? new MsgPicImage.fromJson(json['msg_pic'])
        : null;
    role = json['role'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    data['message'] = this.message;
    data['msg_pic'] = this.msgPic;
    data['role'] = this.role;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class TestimonialsImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  TestimonialsImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  TestimonialsImage.fromJson(Map<String, dynamic> json) {
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

class MsgPicImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  MsgPicImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  MsgPicImage.fromJson(Map<String, dynamic> json) {
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

class DirectoryFaqs {
  String? id;
  String? question;
  String? answer;
  String? sTypename;

  DirectoryFaqs({this.id, this.question, this.answer, this.sTypename});

  DirectoryFaqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['__typename'] = this.sTypename;
    return data;
  }
}
