import '../../directors/model_class/get_directories_details_res.dart';

class GetDirectoriesRes {
  GetDirectoriesData? data;

  GetDirectoriesRes({this.data});

  GetDirectoriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetDirectoriesData.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class GetDirectoriesData {
  List<GetDirectories>? directories;

  GetDirectoriesData({this.directories});

  GetDirectoriesData.fromJson(Map<String, dynamic> json) {
    if (json['directories'] != null) {
      directories = <GetDirectories>[];
      json['directories'].forEach((v) {
        directories!.add(new GetDirectories.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.directories != null) {
  //     data['directories'] = this.directories!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class GetDirectories {
  String? id;
  String? description;
  String? name;
  String? email;
  String? phone;
  String? address;
  double? latitude;
  double? longitude;
  String? altPhone;
  String? type;
  String? abnAcn;
  String? companyName;
  String? professionType;
  String? directoryCategoryId;
  Logo? logo;
  BannerLogo? bannerImage;
  List<DirectoryDocuments>? directoryDocuments;
  List<DirectoryLocations>? directoryLocations;
  List<DirectoryServices>? directoryServices;
  List<DirectoryCertification>? directoryCertifications;
  List<DirectoryAchievements>? directoryAchievements;
  List<DirectoryAppointment>? directoryAppointments;
  List<DirectoryTeamMembers>? directoryTeamMembers;
  List<DirectoryGalleryPosts>? directoryGalleryPosts;
  List<DirectoryTestimonials>? directoryTestimonials;
  List<DirectoryFaqs>? directoryFaqs;
  String? sTypename;

  GetDirectories(
      {this.id,
      this.description,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.latitude,
      this.longitude,
      this.altPhone,
      this.type,
      this.abnAcn,
      this.companyName,
      this.professionType,
      this.directoryCategoryId,
      this.logo,
      this.bannerImage,
      this.directoryDocuments,
      this.directoryLocations,
      this.directoryServices,
      this.directoryCertifications,
      this.directoryAchievements,
      this.directoryAppointments,
      this.directoryTeamMembers,
      this.directoryGalleryPosts,
      this.directoryTestimonials,
      this.directoryFaqs,
      this.sTypename});

  GetDirectories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altPhone = json['alt_phone'];
    type = json['type'];
    abnAcn = json['abn_acn'];
    companyName = json['company_name'];
    professionType = json['profession_type'];
    directoryCategoryId = json['directory_category_id'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    bannerImage = json['banner_image'] != null
        ? new BannerLogo.fromJson(json['banner_image'])
        : null;
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
    if (json['directory_certifications'] != null) {
      directoryCertifications = <DirectoryCertification>[];
      json['directory_certifications'].forEach((v) {
        directoryCertifications!.add(new DirectoryCertification.fromJson(v));
      });
    }
    if (json['directory_achievements'] != null) {
      directoryAchievements = <DirectoryAchievements>[];
      json['directory_achievements'].forEach((v) {
        directoryAchievements!.add(new DirectoryAchievements.fromJson(v));
      });
    }
    if (json['directory_appointments'] != null) {
      directoryAppointments = <DirectoryAppointment>[];
      json['directory_appointments'].forEach((v) {
        directoryAppointments!.add(new DirectoryAppointment.fromJson(v));
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['description'] = this.description;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['address'] = this.address;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = this.longitude;
  //   data['alt_phone'] = this.altPhone;
  //   data['type'] = this.type;
  //   data['abn_acn'] = this.abnAcn;
  //   data['company_name'] = this.companyName;
  //   data['profession_type'] = this.professionType;
  //   data['directory_category_id'] = this.directoryCategoryId;
  //   if (this.logo != null) {
  //     data['logo'] = this.logo!.toJson();
  //   }
  //   if (this.bannerImage != null) {
  //     data['banner_image'] = this.bannerImage!.toJson();
  //   }
  //   if (this.directoryDocuments != null) {
  //     data['directory_documents'] =
  //         this.directoryDocuments!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryLocations != null) {
  //     data['directory_locations'] =
  //         this.directoryLocations!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryServices != null) {
  //     data['directory_services'] =
  //         this.directoryServices!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryCertifications != null) {
  //     data['directory_certifications'] =
  //         this.directoryCertifications!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryAchievements != null) {
  //     data['directory_achievements'] =
  //         this.directoryAchievements!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryAppointments != null) {
  //     data['directory_appointments'] =
  //         this.directoryAppointments!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryTeamMembers != null) {
  //     data['directory_team_members'] =
  //         this.directoryTeamMembers!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryGalleryPosts != null) {
  //     data['directory_gallery_posts'] =
  //         this.directoryGalleryPosts!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryTestimonials != null) {
  //     data['directory_testimonials'] =
  //         this.directoryTestimonials!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.directoryFaqs != null) {
  //     data['directory_faqs'] =
  //         this.directoryFaqs!.map((v) => v.toJson()).toList();
  //   }
  //   data['__typename'] = this.sTypename;
  //   return data;
  // }
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

class BannerLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  BannerLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  BannerLogo.fromJson(Map<String, dynamic> json) {
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

class DirectoryAppointment {
  String? id;
  String? sTypename;

  DirectoryAppointment({this.id, this.sTypename});

  DirectoryAppointment.fromJson(Map<String, dynamic> json) {
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