class JobProfileEnquiriesRes {
  JobProfileEnquiriesResList? data;

  JobProfileEnquiriesRes({this.data});

  JobProfileEnquiriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new JobProfileEnquiriesResList.fromJson(json['data'])
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

class JobProfileEnquiriesResList {
  List<TalentEnquiriesData>? talentEnquiries;

  JobProfileEnquiriesResList({this.talentEnquiries});

  JobProfileEnquiriesResList.fromJson(Map<String, dynamic> json) {
    if (json['talent_enquiries'] != null) {
      talentEnquiries = <TalentEnquiriesData>[];
      json['talent_enquiries'].forEach((v) {
        talentEnquiries!.add(new TalentEnquiriesData.fromJson(v));
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

class TalentEnquiriesData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? talentId;
  String? enquiryDescription;
  String? enquiryFrom;
  String? enquirySenderId;
  DentalSuppliers?  dentalPractices;
  DentalSuppliers? dentalSuppliers;
  JobhiringsFindSupplier? jobhiringsFindPractice;
  JobhiringsFindSupplier? jobhiringsFindSupplier;
  String? sTypename;

  TalentEnquiriesData(
      {this.id,
      this.createdAt,
      this.talentId,
      this.enquiryFrom,
      this.enquirySenderId,
      this.enquiryDescription,
      this.updatedAt,
      this.dentalPractices,
      this.dentalSuppliers,
      this.jobhiringsFindPractice,
      this.jobhiringsFindSupplier,
      this.sTypename});

  TalentEnquiriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    talentId = json['talent_id'];
    enquiryFrom = json['enquiry_from'];
    enquirySenderId = json['enq_sender_id'];
    dentalPractices = json['dental_practices'] != null
        ? new DentalSuppliers.fromJson(json['dental_practices'])
        : null;
    dentalSuppliers = json['dental_suppliers'] != null
        ? new DentalSuppliers.fromJson(json['dental_suppliers'])
        : null;
    jobhiringsFindPractice = json['jobhirings_find_practice'] != null
        ? new JobhiringsFindSupplier.fromJson(json['jobhirings_find_practice'])
        : null;
    jobhiringsFindSupplier = json['jobhirings_find_supplier'] != null
        ? new JobhiringsFindSupplier.fromJson(json['jobhirings_find_supplier'])
        : null;
    sTypename = json['__typename'];
    enquiryDescription = json['enquiry_description'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['talent_id'] = this.talentId;
    data['enquiry_from'] = this.enquiryFrom;
    data['enq_sender_id'] = this.enquirySenderId;
    if (this.dentalPractices != null) {
      data['dental_practices'] = this.dentalPractices!.toJson();
    }
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] = this.dentalSuppliers!.toJson();
    }
    if (this.jobhiringsFindPractice != null) {
      data['jobhirings_find_supplier'] = this.jobhiringsFindPractice?.toJson();
    }
    if (this.jobhiringsFindSupplier != null) {
      data['jobhirings_find_supplier'] = this.jobhiringsFindSupplier?.toJson();
    }
    data['__typename'] = this.sTypename;
    data['enquiry_description'] = this.enquiryDescription;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DentalSuppliers {
  String? id;
  String? name;
  Logo? logo;
  List<Directories>? directories;
  String? sTypename;

  DentalSuppliers(
      {this.id, this.name, this.logo, this.directories, this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
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

class Directories {
  String? id;
  String? email;
  String? phone;
  String? sTypename;

  Directories({this.id, this.email, this.phone, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }

  
}

class JobhiringsFindSupplier {
  String? id;
  String? sTypename;

  JobhiringsFindSupplier({this.id, this.sTypename});

  JobhiringsFindSupplier.fromJson(Map<String, dynamic> json) {
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
