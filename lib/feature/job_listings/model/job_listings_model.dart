import 'package:di360_flutter/feature/job_seek/model/job.dart';

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
  List<Jobs>? jobs;

  JobListing({this.jobs});

  JobListing.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
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

