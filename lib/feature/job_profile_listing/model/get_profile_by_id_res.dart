import 'package:di360_flutter/feature/talents/model/talents_res.dart';

class getProfileByIdRes {
  getProfileByIdData? data;

  getProfileByIdRes({this.data});

  getProfileByIdRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new getProfileByIdData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class getProfileByIdData {
  JobProfiles? jobProfilesByPk;

  getProfileByIdData({this.jobProfilesByPk});

  getProfileByIdData.fromJson(Map<String, dynamic> json) {
    jobProfilesByPk = json['job_profiles_by_pk'] != null
        ? new JobProfiles.fromJson(json['job_profiles_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobProfilesByPk != null) {
      data['job_profiles_by_pk'] = this.jobProfilesByPk!.toJson();
    }
    return data;
  }
}

