import 'package:di360_flutter/feature/job_seek/model/job.dart';

class AppliedJobRespo {
  AppliedJobData? data;

  AppliedJobRespo({this.data});

  factory AppliedJobRespo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      return AppliedJobRespo(
        data: json['data'] != null
            ? AppliedJobData.fromJson(json['data'])
            : null,
      );
    } else if (json.containsKey('job_applicants')) {
      return AppliedJobRespo(
        data: AppliedJobData.fromJson(json),
      );
    } else {
      return AppliedJobRespo(data: AppliedJobData(jobApplicants: []));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}
class AppliedJobData {
  List<AppliedJob>? jobApplicants;

  AppliedJobData({this.jobApplicants});

  factory AppliedJobData.fromJson(Map<String, dynamic> json) {
    return AppliedJobData(
      jobApplicants: json['job_applicants'] != null
          ? List<AppliedJob>.from(
              json['job_applicants'].map((x) => AppliedJob.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_applicants': jobApplicants?.map((x) => x.toJson()).toList(),
    };
  }
}
class AppliedJob {
  String? id;
  String? jobId;
  Attachments? attachments;
  String? status;
  String? message;
  String? dentalProfessionalId;
  Jobs? job;

  AppliedJob({
    this.id,
    this.jobId,
    this.attachments,
    this.status,
    this.message,
    this.dentalProfessionalId,
    this.job,
  });

  factory AppliedJob.fromJson(Map<String, dynamic> json) {
    return AppliedJob(
      id: json['id'],
      jobId: json['job_id'],
      attachments: json['attachments'] != null
          ? Attachments.fromJson(json['attachments'])
          : null,
      status: json['status'],
      message: json['message'],
      dentalProfessionalId: json['dental_professional_id'],
      job: json['job'] != null ? Jobs.fromJson(json['job']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'attachments': attachments?.toJson(),
      'status': status,
      'message': message,
      'dental_professional_id': dentalProfessionalId,
      'job': job?.toJson(),
    };
  }
}

class Attachments {
  String? url;
  String? name;
  String? type;

  Attachments({this.url, this.name, this.type});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      url: json['url'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'type': type,
    };
  }
}


class ClinicLogo {
  String? url;
  String? type;
  String? extension;

  ClinicLogo({this.url, this.type, this.extension});

  factory ClinicLogo.fromJson(Map<String, dynamic> json) {
    return ClinicLogo(
      url: json['url'],
      type: json['type'],
      extension: json['extension'],
    );
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

  JobEnquiry({this.id, this.enquiryUserid, this.enquiryDescription, this.jobId});

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
