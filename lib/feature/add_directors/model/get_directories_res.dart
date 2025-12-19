import '../../directors/model_class/get_directories_details_res.dart';

class GetDirectoriesRes {
  GetDirectoriesData? data;

  GetDirectoriesRes({this.data});

  GetDirectoriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetDirectoriesData.fromJson(json['data'])
        : null;
  }
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
  String? designation;
  String? altPhone;
  String? type;
  String? abnAcn;
  String? companyName;
  String? professionType;
  String? directoryCategoryId;
  Logo? logo;
  BannerLogo? bannerImage;
  ProfileImage? profileImage;
  List<WorkingAt>? workingAt;
  List<Education>? education;
  List<UniversitySchool>? universitySchool;
  List<Hobbies>? hobbies;
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
      this.designation,
      this.altPhone,
      this.type,
      this.abnAcn,
      this.companyName,
      this.professionType,
      this.directoryCategoryId,
      this.workingAt,
      this.education,
      this.universitySchool,
      this.hobbies,
      this.logo,
      this.bannerImage,
      this.profileImage,
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
    designation = json['designation'];
    altPhone = json['alt_phone'];
    type = json['type'];
    abnAcn = json['abn_acn'];
    companyName = json['company_name'];
    professionType = json['profession_type'];
    directoryCategoryId = json['directory_category_id'];
    if (json['working_at'] != null) {
      workingAt = <WorkingAt>[];
      json['working_at'].forEach((v) {
        if (v is Map<String, dynamic>) {
          workingAt!.add(new WorkingAt.fromJson(v));
        }
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        if (v is Map<String, dynamic>) {
          education!.add(new Education.fromJson(v));
        }
      });
    }
    if (json['university_school'] != null) {
      universitySchool = <UniversitySchool>[];
      json['university_school'].forEach((v) {
        if (v is Map<String, dynamic>) {
          universitySchool!.add(new UniversitySchool.fromJson(v));
        }
      });
    }
    if (json['hobbies'] != null) {
      hobbies = <Hobbies>[];
      json['hobbies'].forEach((v) {
        if (v is Map<String, dynamic>) {
          hobbies!.add(new Hobbies.fromJson(v));
        }
      });
    }
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    bannerImage = json['banner_image'] != null
        ? new BannerLogo.fromJson(json['banner_image'])
        : null;
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    if (json['directory_documents'] != null) {
      directoryDocuments = <DirectoryDocuments>[];
      json['directory_documents'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryDocuments!.add(new DirectoryDocuments.fromJson(v));
        }
      });
    }
    if (json['directory_locations'] != null) {
      directoryLocations = <DirectoryLocations>[];
      json['directory_locations'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryLocations!.add(new DirectoryLocations.fromJson(v));
        }
      });
    }
    if (json['directory_services'] != null) {
      directoryServices = <DirectoryServices>[];
      json['directory_services'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryServices!.add(new DirectoryServices.fromJson(v));
        }
      });
    }
    if (json['directory_certifications'] != null) {
      directoryCertifications = <DirectoryCertification>[];
      json['directory_certifications'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryCertifications!.add(new DirectoryCertification.fromJson(v));
        }
      });
    }
    if (json['directory_achievements'] != null) {
      directoryAchievements = <DirectoryAchievements>[];
      json['directory_achievements'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryAchievements!.add(new DirectoryAchievements.fromJson(v));
        }
      });
    }
    if (json['directory_appointments'] != null) {
      directoryAppointments = <DirectoryAppointment>[];
      json['directory_appointments'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryAppointments!.add(new DirectoryAppointment.fromJson(v));
        }
      });
    }
    if (json['directory_team_members'] != null) {
      directoryTeamMembers = <DirectoryTeamMembers>[];
      json['directory_team_members'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryTeamMembers!.add(new DirectoryTeamMembers.fromJson(v));
        }
      });
    }
    if (json['directory_gallery_posts'] != null) {
      directoryGalleryPosts = <DirectoryGalleryPosts>[];
      json['directory_gallery_posts'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryGalleryPosts!.add(new DirectoryGalleryPosts.fromJson(v));
        }
      });
    }
    if (json['directory_testimonials'] != null) {
      directoryTestimonials = <DirectoryTestimonials>[];
      json['directory_testimonials'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryTestimonials!.add(new DirectoryTestimonials.fromJson(v));
        }
      });
    }
    if (json['directory_faqs'] != null) {
      directoryFaqs = <DirectoryFaqs>[];
      json['directory_faqs'].forEach((v) {
        if (v is Map<String, dynamic>) {
          directoryFaqs!.add(new DirectoryFaqs.fromJson(v));
        }
      });
    }
    sTypename = json['__typename'];
  }
}

class WorkingAt {
  String? name;

  WorkingAt({this.name});

  WorkingAt.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
/*
class Education {
  String? name;

  Education({this.name});

  Education.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}*/

class Education {
  late final String? qualification;
  final String? institution;
  final String? finishDate;
  final String? expectedFinishDate;
  final String? selectedQualification;
  final String? courseHighlights;
  final bool? qualificationFinished;

  Education({
     this.qualification,
     this.institution,
    this.finishDate,
    this.expectedFinishDate,
     this.selectedQualification,
     this.courseHighlights,
    this.qualificationFinished,
  });
  factory Education.fromJson(Map<String, dynamic> json) {
    bool? qualificationFinished;
    if (json['qualificationFinished'] is bool) {
      qualificationFinished = json['qualificationFinished'];
    } else if (json['qualificationFinished'] is String) {
      qualificationFinished =
          json['qualificationFinished'].toLowerCase() == 'true';
    }
    return Education(
      finishDate: json['finishDate'],
      institution: json['institution'],
      qualification: json['qualification'],
      courseHighlights: json['courseHighlights'],
      qualificationFinished: qualificationFinished,
      selectedQualification: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'finishDate': finishDate,
        'institution': institution,
        'qualification': qualification,
        'courseHighlights': courseHighlights,
        'qualificationFinished': qualificationFinished,
      };
}


class UniversitySchool {
  String? name;

  UniversitySchool({this.name});

  UniversitySchool.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Hobbies {
  String? name;

  Hobbies({this.name});

  Hobbies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
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
