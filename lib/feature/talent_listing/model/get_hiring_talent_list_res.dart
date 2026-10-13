import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';

class GetHiringTalentListRes {
  HiringTalentList? data;

  GetHiringTalentListRes({this.data});

  GetHiringTalentListRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new HiringTalentList.fromJson(json['data'])
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

class HiringTalentList {
  List<Jobhirings>? jobhirings;

  HiringTalentList({this.jobhirings});

  HiringTalentList.fromJson(Map<String, dynamic> json) {
    if (json['jobhirings'] != null) {
      jobhirings = <Jobhirings>[];
      json['jobhirings'].forEach((v) {
        jobhirings!.add(new Jobhirings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobhirings != null) {
      data['jobhirings'] = this.jobhirings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobhirings {
  String? id;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  String? hiringStatus;
  String? updatedAt;
  String? createdAt;
  String? jobProfilesId;
  dynamic dentalPracticeId;
  DentalSupplier? dentalSupplier;
  DentalSupplier? dentalPractice;
  HiringJobProfiles? jobProfiles;
  TalentEnquiriesFindSupplier? talentEnquiriesFindPractice;
  TalentEnquiriesFindSupplier? talentEnquiriesFindSupplier;
  Directories? directories;
  String? sTypename;

  Jobhirings(
      {this.id,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.hiringStatus,
      this.updatedAt,
      this.createdAt,
      this.jobProfilesId,
      this.dentalPracticeId,
      this.dentalSupplier,
      this.dentalPractice,
      this.jobProfiles,
      this.talentEnquiriesFindPractice,
      this.talentEnquiriesFindSupplier,
      this.directories,
      this.sTypename});

  Jobhirings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    hiringStatus = json['hiring_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    jobProfilesId = json['job_profiles_id'];
    dentalPracticeId = json['dental_practice_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalPractice = json['dental_practice'] != null
        ? new DentalSupplier.fromJson(json['dental_practice'])
        : null;
    jobProfiles = json['job_profiles'] != null
        ? new HiringJobProfiles.fromJson(json['job_profiles'])
        : null;
    talentEnquiriesFindPractice = json['talent_enquiries_find_practice'] != null
        ? new TalentEnquiriesFindSupplier.fromJson(
            json['talent_enquiries_find_practice'])
        : null;
    talentEnquiriesFindSupplier = json['talent_enquiries_find_supplier'] != null
        ? new TalentEnquiriesFindSupplier.fromJson(
            json['talent_enquiries_find_supplier'])
        : null;
    directories = json['directories'] != null
        ? new Directories.fromJson(json['directories'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['hiring_status'] = this.hiringStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['job_profiles_id'] = this.jobProfilesId;
    data['dental_practice_id'] = this.dentalPracticeId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.jobProfiles != null) {
      data['job_profiles'] = this.jobProfiles!.toJson();
    }
    if (this.talentEnquiriesFindPractice != null) {
      data['talent_enquiries_find_practice'] =
          this.talentEnquiriesFindPractice?.toJson();
    }
    if (this.talentEnquiriesFindSupplier != null) {
      data['talent_enquiries_find_supplier'] =
          this.talentEnquiriesFindSupplier?.toJson();
    }
    if (this.directories != null) {
      data['directories'] = this.directories!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? id;
  String? name;
  DirectoriesList? directories;
  Null profileImage;
  Logo? logo;
  String? sTypename;

  DentalSupplier(
      {this.id,
      this.name,
      this.directories,
      this.profileImage,
      this.logo,
      this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // Handle directories as either List or Map
    if (json['directories'] != null) {
      if (json['directories'] is List) {
        // If it's a list, take the first item or handle as needed
        final dirList = json['directories'] as List;
        directories = dirList.isNotEmpty
            ? DirectoriesList.fromJson(dirList[0] as Map<String, dynamic>)
            : null;
      } else if (json['directories'] is Map<String, dynamic>) {
        directories = DirectoriesList.fromJson(json['directories']);
      }
    }
    profileImage = json['profile_image'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['directories'] = this.directories?.toJson();
    data['profile_image'] = this.profileImage;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class TalentEnquiriesFindSupplier {
  String? id;
  String? sTypename;

  TalentEnquiriesFindSupplier({this.id, this.sTypename});

  TalentEnquiriesFindSupplier.fromJson(Map<String, dynamic> json) {
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

class HiringJobProfiles {
  String? id;
  String? fullName;
  DirectoryCategories? professionType;
  String? state;
  ProfileImage? profileImage;
  List<String>? workType;
  String? dentalProfessionalId;
  bool? postAnonymously;
  DentalProfessional? dentalProfessional;
  String? sTypename;

  HiringJobProfiles(
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

  HiringJobProfiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    professionType = json['professionType'] != null
        ? new DirectoryCategories.fromJson(json['professionType'])
        : null;

    state = json['state'];
    profileImage = json['profile_image'] != null &&
            json['profile_image'] is List &&
            (json['profile_image'] as List).isNotEmpty
        ? new ProfileImage.fromJson(json['profile_image'][0])
        : null;
    workType =
        json['work_type'] != null ? json['work_type'].cast<String>() : null;
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
    if (this.professionType != null) {
      data['professionType'] = this.professionType!.toJson();
    }

    data['state'] = this.state;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
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
  String? gender;
  List<ProfileImage>? profileImage;
  String? sTypename;

  DentalProfessional({this.gender, this.profileImage, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    if (json['profile_image'] != null) {
      if (json['profile_image'] is List) {
        profileImage = (json['profile_image'] as List)
            .map((v) => ProfileImage.fromJson(v))
            .toList();
      } else if (json['profile_image'] is Map) {
        profileImage = [ProfileImage.fromJson(json['profile_image'])];
      }
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Directories {
  String? dentalSupplierId;
  Logo? logo;
  String? sTypename;

  Directories({this.dentalSupplierId, this.logo, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    dentalSupplierId = json['dental_supplier_id'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoriesList {
  String? id;
  String? email;
  String? phone;
  String? typename;

  DirectoriesList({this.id, this.email, this.phone, this.typename});

  DirectoriesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    typename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__typename'] = this.typename;
    return data;
  }
}
