import 'dart:convert';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';

TalentFilterResponse talentFilterResponseFromJson(String str) =>
    TalentFilterResponse.fromJson(json.decode(str));
String talentFilterResponseToJson(TalentFilterResponse data) =>
    json.encode(data.toJson());

class TalentFilterResponse {
  final List<JobProfile> jobProfiles;
  TalentFilterResponse({
    required this.jobProfiles,
  });

  factory TalentFilterResponse.fromJson(Map<String, dynamic> json) =>
      TalentFilterResponse(
        jobProfiles: json["data"]?["job_profiles"] == null
            ? []
            : List<JobProfile>.from(
                json["data"]["job_profiles"].map((x) => JobProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": {
          "job_profiles": List<dynamic>.from(jobProfiles.map((x) => x.toJson())),
        },
      };
}


