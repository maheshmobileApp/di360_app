class JobProfileResponse {
  final List<JobProfileListing>? jobProfiles;

  JobProfileResponse({this.jobProfiles});

  factory JobProfileResponse.fromJson(Map<String, dynamic> json) {
    return JobProfileResponse(
      jobProfiles: (json['job_profiles'] as List<dynamic>?)
          ?.map((e) => JobProfileListing.fromJson(e))
          .toList(),
    );
  }
}

class JobProfileListing {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? jobDesignation;
  final String? currentCompany;
  final String? dentalProfessionalId;
  final bool? postAnonymously;
  final String? adminStatus;
  final String? activeStatus;
  final List<ProfileImage>? profileImage; 
  final String? fullName;
  final List<String>? workType; 
  final String? professionType;
  final String? availabilityOption;
  final List<String>? availabilityDate; 
  final List<String>? fromDate; 
  final List<String>? availabilityDay; 
  final String? availabilityType;
  final List<String>? unavailabilityDate;
  final DentalProfessional? dentalProfessional;

  JobProfileListing({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.jobDesignation,
    this.currentCompany,
    this.dentalProfessionalId,
    this.postAnonymously,
    this.adminStatus,
    this.activeStatus,
    this.profileImage,
    this.fullName,
    this.workType,
    this.professionType,
    this.availabilityOption,
    this.availabilityDate,
    this.fromDate,
    this.availabilityDay,
    this.availabilityType,
    this.unavailabilityDate,
    this.dentalProfessional,
  });

  factory JobProfileListing.fromJson(Map<String, dynamic> json) {
    return JobProfileListing(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      jobDesignation: json['job_designation'],
      currentCompany: json['current_company'],
      dentalProfessionalId: json['dental_professional_id'],
      postAnonymously: json['post_anonymously'],
      adminStatus: json['admin_status'],
      activeStatus: json['active_status'],
      profileImage: (json['profile_image'] as List<dynamic>?)
          ?.map((e) => ProfileImage.fromJson(e))
          .toList(),
      fullName: json['full_name'],
      workType: (json['work_type'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      professionType: json['profession_type'],
      availabilityOption: json['availabilityOption'],
      availabilityDate: (json['availabilityDate'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      fromDate: (json['fromDate'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      availabilityDay: (json['availabilityDay'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      availabilityType: json['availabilityType'],
      unavailabilityDate: (json['unavailabilityDate'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      dentalProfessional: json['dental_professional'] != null
          ? DentalProfessional.fromJson(json['dental_professional'])
          : null,
    );
  }
}

class ProfileImage {
  final String? url;
  final String? name;
  final int? size;
  final String? status;
  final String? fileId;
  final bool? isPublic;
  final String? directory;

  ProfileImage({
    this.url,
    this.name,
    this.size,
    this.status,
    this.fileId,
    this.isPublic,
    this.directory,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
      name: json['name'],
      size: json['size'],
      status: json['status'],
      fileId: json['file_id'],
      isPublic: json['isPublic'],
      directory: json['directory'],
    );
  }
}

class DentalProfessional {
  final String? id;
  final String? name;
  final String? email;
  final String? professionType;
  final ProfileImage? profileImage;

  DentalProfessional({
    this.id,
    this.name,
    this.email,
    this.professionType,
    this.profileImage,
  });

  factory DentalProfessional.fromJson(Map<String, dynamic> json) {
    return DentalProfessional(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      professionType: json['profession_type'],
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
    );
  }
}
