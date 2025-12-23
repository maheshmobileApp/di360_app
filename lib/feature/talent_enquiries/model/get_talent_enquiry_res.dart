class GetTalentEnquiryRes {
  TalentEnquiryData? data;

  GetTalentEnquiryRes({this.data});

  GetTalentEnquiryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentEnquiryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentEnquiryData {
  List<TalentEnquiries>? talentEnquiries;

  TalentEnquiryData({this.talentEnquiries});

  TalentEnquiryData.fromJson(Map<String, dynamic> json) {
    if (json['talent_enquiries'] != null) {
      talentEnquiries = <TalentEnquiries>[];
      json['talent_enquiries'].forEach((v) {
        talentEnquiries!.add(new TalentEnquiries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.talentEnquiries != null) {
      data['talent_enquiries'] =
          this.talentEnquiries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentEnquiries {
  String? id;
  String? createdAt;
  String? talentId;
  String? enquiryFrom;
  dynamic? dentalPractices;
  JobProfilesEnquiry? jobProfiles;
  dynamic? jobhiringsFindPractice;
  dynamic? jobhiringsFindSupplier;
  String? sTypename;

  TalentEnquiries(
      {this.id,
      this.createdAt,
      this.talentId,
      this.enquiryFrom,
      this.dentalPractices,
      this.jobProfiles,
      this.jobhiringsFindPractice,
      this.jobhiringsFindSupplier,
      this.sTypename});

  TalentEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    talentId = json['talent_id'];
    enquiryFrom = json['enquiry_from'];
    dentalPractices = json['dental_practices'];
    jobProfiles = json['job_profiles'] != null
        ? new JobProfilesEnquiry.fromJson(json['job_profiles'])
        : null;
    jobhiringsFindPractice = json['jobhirings_find_practice'];
    jobhiringsFindSupplier = json['jobhirings_find_supplier'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['talent_id'] = this.talentId;
    data['enquiry_from'] = this.enquiryFrom;
    data['dental_practices'] = this.dentalPractices;
    if (this.jobProfiles != null) {
      data['job_profiles'] = this.jobProfiles!.toJson();
    }
    data['jobhirings_find_practice'] = this.jobhiringsFindPractice;
    data['jobhirings_find_supplier'] = this.jobhiringsFindSupplier;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class JobProfilesEnquiry {
  String? id;
  String? fullName;
  String? professionType;
  String? state;
  List<ProfileImage>? profileImage;
  List<String>? workType;
  String? dentalProfessionalId;
  bool? postAnonymously;
  DentalProfessional? dentalProfessional;
  String? sTypename;

  JobProfilesEnquiry(
      {this.id,
      this.fullName,
      this.professionType,
      this.state,
      this.profileImage,
      this.workType,
      this.dentalProfessionalId,
      this.postAnonymously,
      this.dentalProfessional,
      this.sTypename});

  JobProfilesEnquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    professionType = json['profession_type'];
    state = json['state'];
    if (json['profile_image'] != null) {
      profileImage = <ProfileImage>[];
      if (json['profile_image'] is List) {
        json['profile_image'].forEach((v) {
          profileImage!.add(new ProfileImage.fromJson(v));
        });
      }
    }
    workType = json['work_type'] != null ? json['work_type'].cast<String>() : null;
    dentalProfessionalId = json['dental_professional_id'];
    postAnonymously = json['post_anonymously'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['profession_type'] = this.professionType;
    data['state'] = this.state;
    if (this.profileImage != null) {
      data['profile_image'] =
          this.profileImage!.map((v) => v.toJson()).toList();
    }
    data['work_type'] = this.workType;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['post_anonymously'] = this.postAnonymously;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProfileImage {
  String? url;
  String? name;
  String? type;
  String? extension;

  ProfileImage({this.url, this.name, this.type, this.extension});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}

class DentalProfessional {
  Null? profileImage;
  String? gender;
  String? sTypename;

  DentalProfessional({this.profileImage, this.gender, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    gender = json['gender'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['gender'] = this.gender;
    data['__typename'] = this.sTypename;
    return data;
  }
}
