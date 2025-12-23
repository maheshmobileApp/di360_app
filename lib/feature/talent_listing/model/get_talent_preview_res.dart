import 'package:di360_flutter/feature/talents/model/talents_res.dart';

class GetTalentPreviewRes {
  TalentPreviewData? data;

  GetTalentPreviewRes({this.data});

  GetTalentPreviewRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentPreviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentPreviewData {
  List<JobProfiles>? jobProfiles;

  TalentPreviewData({this.jobProfiles});

  TalentPreviewData.fromJson(Map<String, dynamic> json) {
    if (json['job_profiles'] != null) {
      jobProfiles = <JobProfiles>[];
      json['job_profiles'].forEach((v) {
        jobProfiles!.add(new JobProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobProfiles != null) {
      data['job_profiles'] = this.jobProfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
