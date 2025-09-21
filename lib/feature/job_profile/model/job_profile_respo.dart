import 'dart:convert';

import '../../../common/model/certificates.dart';

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

class JobProfile {
  final String? dentalProfessionalId;
  final String? fullName;
  final String? mobileNumber;
  final String? emailAddress;
  final String? professionType;
  final String? workType;
  final String? currentCompany;
  final String? jobDesignation;
  final String? state;
  final String? location;
  final String? country;
  final String? city;
  final String? radius;
  final String? availabilityType;
  final List<FileUpload>? profileImage;
  final List<FileUpload>? uploadResume;
  final String? abnNumber;
  final String? availabilityOption;
  final String? currentCtc;
  final bool? postAnonymously;
  final String? adminStatus;
  final List<JobExperience>? jobExperiences;
  final List<Education>? educations;
  final String? workRights;
  final String? yearOfExperience;
  final String? languagesSpoken;
  final String? areasExpertise;
  final List<String>? skills;
  final String? salaryAmount;
  final String? salaryType;
  final String? travelDistance;
  final String? percentage;
  final String? aphraNumber;
  final bool? willingToTravel;
  final String? aboutYourself;
  final List<String>? availabilityDay;
  final List<String>? availabilityDate;
  final List<String>? fromDate;

  JobProfile({
    this.dentalProfessionalId,
    this.fullName,
    this.mobileNumber,
    this.emailAddress,
    this.professionType,
    this.workType,
    this.currentCompany,
    this.jobDesignation,
    this.state,
    this.location,
    this.country,
    this.city,
    this.radius,
    this.availabilityType,
    this.profileImage,
    this.uploadResume,
    this.abnNumber,
    this.availabilityOption,
    this.currentCtc,
    this.postAnonymously,
    this.adminStatus,
    this.jobExperiences,
    this.educations,
    this.workRights,
    this.yearOfExperience,
    this.languagesSpoken,
    this.areasExpertise,
    this.skills,
    this.salaryAmount,
    this.salaryType,
    this.travelDistance,
    this.percentage,
    this.aphraNumber,
    this.willingToTravel,
    this.aboutYourself,
    this.availabilityDay,
    this.availabilityDate,
    this.fromDate,
  });

  factory JobProfile.fromJson(Map<String, dynamic> json) => JobProfile(
        dentalProfessionalId: json["dental_professional_id"],
        fullName: json["full_name"],
        mobileNumber: json["mobile_number"],
        emailAddress: json["email_address"],
        professionType: json["profession_type"],
        workType: json["work_type"],
        currentCompany: json["current_company"],
        jobDesignation: json["job_designation"],
        state: json["state"],
        location: json["location"],
        country: json["country"],
        city: json["city"],
        radius: json["radius"],
        availabilityType: json["availabilityType"],
        profileImage: json["profile_image"] == null
            ? []
            : List<FileUpload>.from(
                json["profile_image"]!.map((x) => FileUpload.fromJson(x))),
        uploadResume: json["upload_resume"] == null
            ? []
            : List<FileUpload>.from(
                json["upload_resume"]!.map((x) => FileUpload.fromJson(x))),
        abnNumber: json["abn_number"],
        availabilityOption: json["availabilityOption"],
        currentCtc: json["current_ctc"],
        postAnonymously: json["post_anonymously"],
        adminStatus: json["admin_status"],
        jobExperiences: json["jobexperiences"] == null
            ? []
            : List<JobExperience>.from(
                json["jobexperiences"]!.map((x) => JobExperience.fromJson(x))),
        educations: json["educations"] == null
            ? []
            : List<Education>.from(
                json["educations"]!.map((x) => Education.fromJson(x))),
        workRights: json["work_rights"],
        yearOfExperience: json["Year_of_experiance"],
        languagesSpoken: json["languages_spoken"],
        areasExpertise: json["areas_expertise"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        salaryAmount: json["salary_amount"],
        salaryType: json["salary_type"],
        travelDistance: json["travel_distance"],
        percentage: json["percentage"],
        aphraNumber: json["aphra_number"],
        willingToTravel: json["willing_to_travel"],
        aboutYourself: json["about_yourself"],
        availabilityDay: json["availabilityDay"] == null
            ? []
            : List<String>.from(json["availabilityDay"]!.map((x) => x)),
        availabilityDate: json["availabilityDate"] == null
            ? []
            : List<String>.from(json["availabilityDate"]!.map((x) => x)),
        fromDate: json["fromDate"] == null
            ? []
            : List<String>.from(json["fromDate"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "dental_professional_id": dentalProfessionalId,
        "full_name": fullName,
        "mobile_number": mobileNumber,
        "email_address": emailAddress,
        "profession_type": professionType,
        "work_type": workType,
        "current_company": currentCompany,
        "job_designation": jobDesignation,
        "state": state,
        "location": location,
        "country": country,
        "city": city,
        "radius": radius,
        "availabilityType": availabilityType,
        "profile_image": profileImage == null
            ? []
            : profileImage!.map((x) => x.toJson()).toList(),
        "upload_resume": uploadResume == null
            ? []
            : uploadResume!.map((x) => x.toJson()).toList(),
        "abn_number": abnNumber,
        "availabilityOption": availabilityOption,
        "current_ctc": currentCtc,
        "post_anonymously": postAnonymously,
        "admin_status": adminStatus,
        "jobexperiences": jobExperiences == null
            ? []
            : jobExperiences!.map((x) => x.toJson()).toList(),
        "educations":
            educations == null ? [] : educations!.map((x) => x.toJson()).toList(),
        "work_rights": workRights,
        "Year_of_experiance": yearOfExperience,
        "languages_spoken": languagesSpoken,
        "areas_expertise": areasExpertise,
        "skills": skills == null ? [] : skills!.map((x) => x).toList(),
        "salary_amount": salaryAmount,
        "salary_type": salaryType,
        "travel_distance": travelDistance,
        "percentage": percentage,
        "aphra_number": aphraNumber,
        "willing_to_travel": willingToTravel,
        "about_yourself": aboutYourself,
        "availabilityDay":
            availabilityDay == null ? [] : availabilityDay!.map((x) => x).toList(),
        "availabilityDate": availabilityDate == null
            ? []
            : availabilityDate!.map((x) => x).toList(),
        "fromDate": fromDate == null ? [] : fromDate!.map((x) => x).toList(),
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
