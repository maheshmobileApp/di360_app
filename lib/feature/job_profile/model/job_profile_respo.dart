import 'dart:convert';

import 'package:di360_flutter/feature/talents/model/job_profile.dart';


JobProfileResponse jobProfileResponseFromJson(String str) =>
    JobProfileResponse.fromJson(json.decode(str));

String jobProfileResponseToJson(JobProfileResponse data) =>
    json.encode(data.toJson());

class JobProfileResponse {
  final List<JobProfile>? jobProfile;

  JobProfileResponse({this.jobProfile});

  factory JobProfileResponse.fromJson(Map<String, dynamic> json) =>
      JobProfileResponse(
        jobProfile: json["jobProfile"] == null
            ? []
            : List<JobProfile>.from(
                json["jobProfile"]!.map((x) => JobProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobProfile":
            jobProfile == null ? [] : jobProfile!.map((x) => x.toJson()).toList(),
      };
}


class JobExperience {
  final String? company;
  final String? designation;
  final String? fromDate;
  final String? toDate;

  JobExperience({
    this.company,
    this.designation,
    this.fromDate,
    this.toDate,
  });

  factory JobExperience.fromJson(Map<String, dynamic> json) => JobExperience(
        company: json["company"],
        designation: json["designation"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "designation": designation,
        "fromDate": fromDate,
        "toDate": toDate,
      };
}

class Education {
  final String? school;
  final String? degree;
  final String? yearOfCompletion;

  Education({
    this.school,
    this.degree,
    this.yearOfCompletion,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        school: json["school"],
        degree: json["degree"],
        yearOfCompletion: json["year_of_completion"],
      );

  Map<String, dynamic> toJson() => {
        "school": school,
        "degree": degree,
        "year_of_completion": yearOfCompletion,
      };
}
