 import '../../talents/model/job_profile.dart';
class GetTaltentModel {
  final TalentsData? data;

  GetTaltentModel({this.data});

  factory GetTaltentModel.fromJson(Map<String, dynamic> json) {
    return GetTaltentModel(
      data: json['data'] != null ? TalentsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class TalentsData {
  final List<JobProfile> jobProfiles;

  TalentsData({required this.jobProfiles});

  factory TalentsData.fromJson(Map<String, dynamic> json) {
    return TalentsData(
      jobProfiles: json['job_profiles'] != null
          ? (json['job_profiles'] as List)
              .map((item) => JobProfile.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_profiles': jobProfiles.map((profile) => profile.toJson()).toList(),
    };
  }
}

