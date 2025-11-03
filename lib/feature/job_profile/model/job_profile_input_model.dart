import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';

class JobProfileInputModel {
  String? dentalProfessionalId;
  String? fullName;
  String? mobileNumber;
  String? emailAddress;
  String? professionType;
  List<String> workType = [];
  String? currentCompany;
  String? jobDesignation;
  String? state;
  String? location;
  String? country;
  String? city;
  String? radius;
  String? availabilityType;
  String? abnNumber;
  String? currentCtc;
  bool postAnonymously = false;
  String? adminStatus;
  List<Map<String, dynamic>> profileImage = [];
  List<Map<String, dynamic>> uploadResume = [];
  List<Map<String, dynamic>> certificate = [];
  List<Map<String, dynamic>> coverLetter = [];
  List<Map<String, dynamic>> jobExperiences = [];
  List<Map<String, dynamic>> educations = [];
  String? workRights;
  String? languagesSpoken;
  String? areasExpertise;
  List<String> skills = [];
  int? salaryAmount;
  String? salaryType;
  String? travelDistance;
  String? percentage;
  String? aphraNumber;
  bool willingToTravel = false;
  String? aboutYourself;
  List<String> availabilityDay = [];
  List<String> availabilityDate = [];
  List<String> fromDate = [];

  Map<String, dynamic> toJobProfileMap() {
    return {
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
      "radius": radius ?? "0",
      "availabilityType": availabilityType,
      "profile_image": profileImage,
      "upload_resume": uploadResume,
      "certificate": certificate,
      "cover_letter": coverLetter,
      "abn_number": abnNumber,
      "availabilityOption": availabilityType,
      "current_ctc": currentCtc ?? "100000",
      "post_anonymously": postAnonymously,
      "admin_status": adminStatus,
      "jobexperiences": jobExperiences,
      "educations": educations,
      "work_rights": workRights,
      "languages_spoken": languagesSpoken,
      "areas_expertise": areasExpertise,
      "skills": skills,
      "salary_amount": salaryAmount ?? 120000,
      "salary_type": salaryType ?? "Per Year",
      "travel_distance": travelDistance ?? "0",
      "percentage": percentage ?? "10",
      "aphra_number": aphraNumber,
      "willing_to_travel": willingToTravel,
      "about_yourself": aboutYourself,
      "availabilityDay": availabilityDay,
      "availabilityDate": availabilityDate,
      "fromDate": fromDate,
    };
  }

  // Populate model from text controllers and variables
  void fromViewModel(JobProfileCreateViewModel vm) {
    dentalProfessionalId = vm.userFullName;
    fullName = vm.fullNameController.text;
    mobileNumber = vm.mobileNumberController.text;
    emailAddress = vm.emailAddressController.text;
    professionType = vm.selectedRole;
    workType = vm.selectedEmploymentChips;
    currentCompany = vm.currentCompanyController.text;
    jobDesignation = vm.jobDesignationController.text;
    state = vm.stateController.text;
    location = vm.locationController.text;
    country = vm.selectCountry;
    city = vm.cityPostCodeController.text;
    radius = vm.DistanceController.text;
    availabilityType = vm.selectedAvailabilityType;
    abnNumber = vm.abnNumberController.text;
    currentCtc = "100000";
    postAnonymously = false;
    adminStatus = "PENDING";
    profileImage = vm.profileFile != null
        ? [
            {
              "url": vm.profileFile!.path,
              "name": vm.profileFile!.path.split("/").last,
              "type": "image",
              "extension": "jpeg",
            }
          ]
        : [];
    uploadResume = vm.resumeFile != null
        ? [
            {
              "url": vm.resumeFile!.path,
              "name": vm.resumeFile!.path.split("/").last,
              "type": "pdf",
              "extension": "pdf",
            }
          ]
        : [];
    certificate = vm.certificateFile != null
        ? [
            {
              "url": vm.certificateFile!.path,
              "name": vm.certificateFile!.path.split("/").last,
              "type": "document",
              "extension": "pdf",
            }
          ]
        : [];
    coverLetter = vm.coverLetterFile != null
        ? [
            {
              "url": vm.coverLetterFile!.path,
              "name": vm.coverLetterFile!.path.split("/").last,
              "type": "image",
              "extension": "jpeg",
            }
          ]
        : [];
    jobExperiences = vm.experiences
        .map((e) => {
              "company_name": e.companyName,
              "job_title": e.jobTitle,
              "ejobdesp": e.jobDescription,
              "startMonth": e.startMonth,
              "startYear": e.startYear,
              "isStillWorking": vm.isStillWorking,
              "endMonth": e.endMonth,
              "endYear": e.endYear
            })
        .toList();
    educations = vm.educations
        .map((e) => {
              "institution": e.institution,
              "qualification": e.qualification,
              "selectedQualification": e.selectedQualification,
              "finishDate": e.finishDate,
              "qualificationFinished": false,
              "courseHighlights": e.courseHighlights,
            })
        .toList();
    workRights = vm.selectworkRight;
    languagesSpoken = vm.languagesSpokenController.text;
    areasExpertise = vm.areaOfExpertise.text;
    skills = vm.selectskills;
    salaryAmount = 120000;
    salaryType = "Per Year";
    travelDistance = vm.DistanceController.text;
    percentage = "10";
    aphraNumber = vm.aphraRegistrationNumberController.text;
    willingToTravel = vm.isWillingToTravel;
    aboutYourself = vm.aboutMeController.text;
    availabilityDay = vm.selectedDays;
    availabilityDate = vm.availabilityDates.map((d) => d.toIso8601String()).toList();
    fromDate = vm.joiningDate != null ? [vm.joiningDate!.toIso8601String()] : [];
  }

  // Update all text controllers in ViewModel from this model
  void updateViewModel(JobProfileCreateViewModel vm) {
    vm.fullNameController.text = fullName ?? "";
    vm.mobileNumberController.text = mobileNumber ?? "";
    vm.emailAddressController.text = emailAddress ?? "";
    vm.abnNumberController.text = abnNumber ?? "";
    vm.aphraRegistrationNumberController.text = aphraNumber ?? "";
    vm.currentCompanyController.text = currentCompany ?? "";
    vm.jobDesignationController.text = jobDesignation ?? "";
    vm.stateController.text = state ?? "";
    vm.locationController.text = location ?? "";
    vm.countryController.text = country ?? "";
    vm.cityPostCodeController.text = city ?? "";
    vm.DistanceController.text = radius ?? "";
    vm.languagesSpokenController.text = languagesSpoken ?? "";
    vm.areaOfExpertise.text = areasExpertise ?? "";
    vm.aboutMeController.text = aboutYourself ?? "";
    // For dropdowns and lists
    vm.selectedRole = professionType;
    vm.selectCountry = country;
    vm.selectedAvailabilityType = availabilityType ?? "Select Day";
    vm.selectworkRight = workRights;
    vm.selectskills = skills;
    vm.selectedDays = availabilityDay;
    vm.availabilityDates = availabilityDate.map((d) => DateTime.parse(d)).toList();
    vm.joiningDate = fromDate.isNotEmpty ? DateTime.parse(fromDate.first) : null;
    vm.selectedEmploymentChips
      ..clear()
      ..addAll(workType);
    // For files
    // You may want to restore files from paths if needed
    // For experiences and educations, you may want to restore objects
    // ...
    // vm.notifyListeners();
  }
}
