class GetDirectoryRes {
  GetDirectoryData? data;

  GetDirectoryRes({this.data});

  GetDirectoryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetDirectoryData.fromJson(json['data'])
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

class GetDirectoryData {
  DirectoriesById? directoriesByPk;
  List<Null>? loggedInSupplier;
  List<LoggedInProfessional>? loggedInProfessional;

  GetDirectoryData({this.directoriesByPk, this.loggedInSupplier, this.loggedInProfessional});

  GetDirectoryData.fromJson(Map<String, dynamic> json) {
    directoriesByPk = json['directories_by_pk'] != null
        ? new DirectoriesById.fromJson(json['directories_by_pk'])
        : null;
    if (json['loggedInProfessional'] != null) {
      loggedInProfessional = (json['loggedInProfessional'] as List)
          .map((v) => LoggedInProfessional.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoriesByPk != null) {
      data['directories_by_pk'] = this.directoriesByPk!.toJson();
    }
    if (this.loggedInProfessional != null) {
      data['loggedInProfessional'] =
          this.loggedInProfessional!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DirectoriesById {
  String? id;
  String? description;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? website;
  String? altPhone;
  String? hobbies;
  String? universitySchool;
  String? abnAcn;
  String? status;
  String? companyName;
  String? profession;
  String? membershipLink;
  String? partnershipLink;
  String? businessName;
  String? communityStatus;
  String? communityId;
  String? type;
  String? education;
  DirectoryCategories? professionType;
  String? designation;
  String? workingAt;
  BannerImage? bannerImage;
  BannerImage? logo;
  double? latitude;
  double? longitude;
  BannerImage? profileImage;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  DentalSupplier? dentalSupplier;
  dynamic dentalPractice;
  dynamic dentalProfessional;
  List<dynamic>? directoryDocuments;
  List<dynamic>? directoryLocations;
  List<dynamic>? directoryServices;
  List<dynamic>? directoryAchievements;
  List<dynamic>? directoryCertifications;
  List<dynamic>? directoryAppointmentSlots;
  List<dynamic>? directoryTeamMembers;
  List<dynamic>? directoryPartners;
  List<dynamic>? directoryGalleryPosts;
  List<dynamic>? directoryTestimonials;
  List<dynamic>? directoryFaqs;

  DirectoriesById(
      {this.id,
      this.description,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.website,
      this.altPhone,
      this.hobbies,
      this.universitySchool,
      this.abnAcn,
      this.status,
      this.companyName,
      this.profession,
      this.membershipLink,
      this.partnershipLink,
      this.businessName,
      this.communityStatus,
      this.communityId,
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
      this.dentalSupplier,
      this.dentalPractice,
      this.dentalProfessional,
      this.directoryDocuments,
      this.directoryLocations,
      this.directoryServices,
      this.directoryAchievements,
      this.directoryCertifications,
      this.directoryAppointmentSlots,
      this.directoryTeamMembers,
      this.directoryPartners,
      this.directoryGalleryPosts,
      this.directoryTestimonials,
      this.directoryFaqs});

  DirectoriesById.fromJson(Map<String, dynamic> json) {
    id = json['id'] is List
        ? (json['id'] as List).isEmpty
            ? null
            : (json['id'] as List).join(', ')
        : json['id']?.toString();
    description = json['description'] is List
        ? (json['description'] as List).isEmpty
            ? null
            : (json['description'] as List).join(', ')
        : json['description']?.toString();
    name = json['name'] is List
        ? (json['name'] as List).isEmpty
            ? null
            : (json['name'] as List).join(', ')
        : json['name']?.toString();
    email = json['email'] is List
        ? (json['email'] as List).isEmpty
            ? null
            : (json['email'] as List).join(', ')
        : json['email']?.toString();
    phone = json['phone'] is List
        ? (json['phone'] as List).isEmpty
            ? null
            : (json['phone'] as List).join(', ')
        : json['phone']?.toString();
    address = json['address'] is List
        ? (json['address'] as List).isEmpty
            ? null
            : (json['address'] as List).join(', ')
        : json['address']?.toString();
    website = json['website'] is List
        ? (json['website'] as List).isEmpty
            ? null
            : (json['website'] as List).join(', ')
        : json['website']?.toString();
    altPhone = json['alt_phone'] is List
        ? (json['alt_phone'] as List).isEmpty
            ? null
            : (json['alt_phone'] as List).join(', ')
        : json['alt_phone']?.toString();
    hobbies = json['hobbies'] is List
        ? (json['hobbies'] as List).isEmpty
            ? null
            : (json['hobbies'] as List).join(', ')
        : json['hobbies']?.toString();
    universitySchool = json['university_school'] is List
        ? (json['university_school'] as List).isEmpty
            ? null
            : (json['university_school'] as List).join(', ')
        : json['university_school']?.toString();
    abnAcn = json['abn_acn'] is List
        ? (json['abn_acn'] as List).isEmpty
            ? null
            : (json['abn_acn'] as List).join(', ')
        : json['abn_acn']?.toString();
    status = json['status'] is List
        ? (json['status'] as List).isEmpty
            ? null
            : (json['status'] as List).join(', ')
        : json['status']?.toString();
    companyName = json['company_name'] is List
        ? (json['company_name'] as List).isEmpty
            ? null
            : (json['company_name'] as List).join(', ')
        : json['company_name']?.toString();
    profession = json['profession'] is List
        ? (json['profession'] as List).isEmpty
            ? null
            : (json['profession'] as List).join(', ')
        : json['profession']?.toString();
    membershipLink = json['membership_link'] is List
        ? (json['membership_link'] as List).isEmpty
            ? null
            : (json['membership_link'] as List).join(', ')
        : json['membership_link']?.toString();
    partnershipLink = json['partnership_link'] is List
        ? (json['partnership_link'] as List).isEmpty
            ? null
            : (json['partnership_link'] as List).join(', ')
        : json['partnership_link']?.toString();
    businessName = json['business_name'] is List
        ? (json['business_name'] as List).isEmpty
            ? null
            : (json['business_name'] as List).join(', ')
        : json['business_name']?.toString();
    communityStatus = json['community_status'] is List
        ? (json['community_status'] as List).isEmpty
            ? null
            : (json['community_status'] as List).join(', ')
        : json['community_status']?.toString();
    communityId = json['community_id'] is List
        ? (json['community_id'] as List).isEmpty
            ? null
            : (json['community_id'] as List).join(', ')
        : json['community_id']?.toString();
    type = json['type'] is List
        ? (json['type'] as List).isEmpty
            ? null
            : (json['type'] as List).join(', ')
        : json['type']?.toString();
    education = json['education'] is List
        ? (json['education'] as List).isEmpty
            ? null
            : (json['education'] as List).join(', ')
        : json['education']?.toString();
    professionType = json['professionType'] != null
        ? new DirectoryCategories.fromJson(json['professionType'])
        : null;

    designation = json['designation'] is List
        ? (json['designation'] as List).isEmpty
            ? null
            : (json['designation'] as List).join(', ')
        : json['designation']?.toString();
    workingAt = json['working_at'] is List
        ? (json['working_at'] as List).isEmpty
            ? null
            : (json['working_at'] as List).join(', ')
        : json['working_at']?.toString();
    bannerImage = json['banner_image'] != null
        ? new BannerImage.fromJson(json['banner_image'])
        : null;
    logo = json['logo'] != null ? new BannerImage.fromJson(json['logo']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileImage = json['profile_image'] != null
        ? BannerImage.fromJson(json['profile_image'])
        : null;
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'];
    dentalProfessional = json['dental_professional'];
    directoryDocuments = json['directory_documents']?.cast<dynamic>();
    directoryLocations = json['directory_locations']?.cast<dynamic>();
    directoryServices = json['directory_services']?.cast<dynamic>();
    directoryAchievements = json['directory_achievements']?.cast<dynamic>();
    directoryCertifications = json['directory_certifications']?.cast<dynamic>();
    directoryAppointmentSlots =
        json['directory_appointment_slots']?.cast<dynamic>();
    directoryTeamMembers = json['directory_team_members']?.cast<dynamic>();
    directoryPartners = json['directory_partners']?.cast<dynamic>();
    directoryGalleryPosts = json['directory_gallery_posts']?.cast<dynamic>();
    directoryTestimonials = json['directory_testimonials']?.cast<dynamic>();
    directoryFaqs = json['directory_faqs']?.cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['website'] = this.website;
    data['alt_phone'] = this.altPhone;
    data['hobbies'] = this.hobbies;
    data['university_school'] = this.universitySchool;
    data['abn_acn'] = this.abnAcn;
    data['status'] = this.status;
    data['company_name'] = this.companyName;
    data['profession'] = this.profession;
    data['membership_link'] = this.membershipLink;
    data['partnership_link'] = this.partnershipLink;
    data['business_name'] = this.businessName;
    data['community_status'] = this.communityStatus;
    data['community_id'] = this.communityId;
    data['type'] = this.type;
    data['education'] = this.education;
    if (this.professionType != null) {
      data['professionType'] = this.professionType!.toJson();
    }

    data['designation'] = this.designation;
    data['working_at'] = this.workingAt;
    if (this.bannerImage != null) {
      data['banner_image'] = this.bannerImage!.toJson();
    }
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional'] = this.dentalProfessional;
    data['directory_documents'] = this.directoryDocuments;
    data['directory_locations'] = this.directoryLocations;
    data['directory_services'] = this.directoryServices;
    data['directory_achievements'] = this.directoryAchievements;
    data['directory_certifications'] = this.directoryCertifications;
    data['directory_appointment_slots'] = this.directoryAppointmentSlots;
    data['directory_team_members'] = this.directoryTeamMembers;
    data['directory_partners'] = this.directoryPartners;
    data['directory_gallery_posts'] = this.directoryGalleryPosts;
    data['directory_testimonials'] = this.directoryTestimonials;
    data['directory_faqs'] = this.directoryFaqs;
    return data;
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

class DentalSupplier {
  String? firstName;
  String? lastName;
  String? communityStatus;
  String? communityId;
  List<CommunityMembers>?communityMembers;
  List<CommunityMembers>? partnershipMembers;
  String? sTypename;

  DentalSupplier(
      {this.firstName,
      this.lastName,
      this.communityStatus,
      this.communityId,
      this.communityMembers,
      this.partnershipMembers,
      this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    communityStatus = json['community_status'];
    communityId = json['community_id'];
    if (json['community_members'] != null) {
      communityMembers = (json['community_members'] as List)
          .map((v) => CommunityMembers.fromJson(v))
          .toList();
    }
    if (json['partnership_members'] != null) {
      partnershipMembers =  (json['partnership_members'] as List)
          .map((v) => CommunityMembers.fromJson(v))
          .toList();
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['community_status'] = this.communityStatus;
    data['community_id'] = this.communityId;
    if (this.communityMembers != null) {
      data['community_members'] =
          this.communityMembers?.map((v) => v.toJson()).toList();
    }
    if (this.partnershipMembers != null) {
      data['partnership_members'] =
          this.partnershipMembers?.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoryCategories {
  String? id;
  String? name;
  String? sTypename;

  DirectoryCategories({this.id, this.name, this.sTypename});

  DirectoryCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}


class CommunityMembers {
  String? status;
  String? sTypename;

  CommunityMembers({this.status, this.sTypename});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class LoggedInProfessional {
  String? firstName;
  String? lastName;
  String? sTypename;

  LoggedInProfessional({this.firstName, this.lastName, this.sTypename});

  LoggedInProfessional.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['__typename'] = this.sTypename;
    return data;
  }
}


