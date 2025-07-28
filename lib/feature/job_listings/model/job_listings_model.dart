class GetMyJobListingResp {
  JobListing? data;

  GetMyJobListingResp({this.data});

  GetMyJobListingResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new JobListing.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobListing {
  List<JobsListingDetails>? jobs;

  JobListing({this.jobs});

  JobListing.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <JobsListingDetails>[];
      json['jobs'].forEach((v) {
        jobs!.add(new JobsListingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobsListingDetails{
  String? id;
  String? createdAt;
  String? logo;
  String? companyName;
  String? description;
  String? title;
  String? education;
  dynamic experience;
  String? payRange;
  String? jRole;
  String? jType;
  List<String>? typeofEmployment;
  String? location;
  dynamic address;
  dynamic rolesAndResponsibilities;
  dynamic shortId;
  String? status;

  JobsListingDetails(
      {this.id,
      this.createdAt,
      this.logo,
      this.companyName,
      this.description,
      this.title,
      this.education,
      this.experience,
      this.payRange,
      this.jRole,
      this.jType,
      this.typeofEmployment,
      this.location,
      this.address,
      this.rolesAndResponsibilities,
      this.shortId,
      this.status});

  JobsListingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    logo = json['logo'];
    companyName = json['company_name'];
    description = json['description'];
    title = json['title'];
    education = json['education'];
    experience = json['experience'];
    payRange = json['pay_range'];
    jRole = json['j_role'];
    jType = json['j_type'];
    typeofEmployment = json['TypeofEmployment'].cast<String>();
    location = json['location'];
    address = json['address'];
    rolesAndResponsibilities = json['roles_and_responsibilities'];
    shortId = json['short_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['logo'] = this.logo;
    data['company_name'] = this.companyName;
    data['description'] = this.description;
    data['title'] = this.title;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['pay_range'] = this.payRange;
    data['j_role'] = this.jRole;
    data['j_type'] = this.jType;
    data['TypeofEmployment'] = this.typeofEmployment;
    data['location'] = this.location;
    data['address'] = this.address;
    data['roles_and_responsibilities'] = this.rolesAndResponsibilities;
    data['short_id'] = this.shortId;
    data['status'] = this.status;
    return data;
  }
}
