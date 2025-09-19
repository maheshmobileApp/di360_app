import 'package:di360_flutter/feature/talents/model/job_profile.dart';

class JobProfileResponse {
  JobData? data;

  JobProfileResponse({this.data});

  JobProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new JobData.fromJson(json['data']) : null;
  }
}

class JobData {
  List<JobProfile>? jobProfiles;

  JobData({this.jobProfiles});

  JobData.fromJson(Map<String, dynamic> json) {
    if (json['job_profiles'] != null) {
      jobProfiles = <JobProfile>[];
      json['job_profiles'].forEach((v) {
        jobProfiles!.add(new JobProfile.fromJson(v));
      });
    }
  }
}

