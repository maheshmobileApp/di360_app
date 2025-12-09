class GetDirectoryRes {
  GetDirectoryData? data;

  GetDirectoryRes({this.data});

  GetDirectoryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetDirectoryData.fromJson(json['data']) : null;
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

  GetDirectoryData({this.directoriesByPk});

  GetDirectoryData.fromJson(Map<String, dynamic> json) {
    directoriesByPk = json['directories_by_pk'] != null
        ? new DirectoriesById.fromJson(json['directories_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directoriesByPk != null) {
      data['directories_by_pk'] = this.directoriesByPk!.toJson();
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
  String? professionType;
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
    id = json['id'];
    description = json['description'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    website = json['website'];
    altPhone = json['alt_phone'];
    hobbies = json['hobbies'];
    universitySchool = json['university_school'];
    abnAcn = json['abn_acn'];
    status = json['status'];
    companyName = json['company_name'];
    profession = json['profession'];
    membershipLink = json['membership_link'];
    partnershipLink = json['partnership_link'];
    businessName = json['business_name'];
    communityStatus = json['community_status'];
    communityId = json['community_id'];
    type = json['type'];
    education = json['education'];
    professionType = json['profession_type'];
    designation = json['designation'];
    workingAt = json['working_at'];
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
    directoryAppointmentSlots = json['directory_appointment_slots']?.cast<dynamic>();
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
    data['profession_type'] = this.professionType;
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

  DentalSupplier({this.firstName, this.lastName});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
