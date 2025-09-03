import 'package:di360_flutter/feature/job_seek/model/job.dart';

class GetJobsListModel {
  JobdList? data;

  GetJobsListModel({this.data});

  GetJobsListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? JobdList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobdList {
  List<Jobs>? jobs;

  JobdList({this.jobs});

  JobdList.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null && json['jobs'] is List) {
      jobs = (json['jobs'] as List).map((v) => Jobs.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class JobApplicantsAggregate {
  Aggregate? aggregate;

  JobApplicantsAggregate({this.aggregate});

  JobApplicantsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (aggregate != null) {
      data['aggregate'] = aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {'count': count};
  }
}

class ClinicLogo {
  String? url;
  String? type;
  String? extension;

  ClinicLogo({this.url, this.type, this.extension});

  ClinicLogo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
      'extension': extension,
    };
  }
}

class JobEnquiry {
  String? id;
  String? enquiryUserid;
  String? enquiryDescription;
  String? jobId;

  JobEnquiry(
      {this.id, this.enquiryUserid, this.enquiryDescription, this.jobId});

  factory JobEnquiry.fromJson(Map<String, dynamic> json) {
    return JobEnquiry(
      id: json['id'],
      enquiryUserid: json['enquiry_userid'],
      enquiryDescription: json['enquiry_description'],
      jobId: json['job_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enquiry_userid': enquiryUserid,
      'enquiry_description': enquiryDescription,
      'job_id': jobId,
    };
  }
}
