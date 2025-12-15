import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/model/certificates.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/repository/create_job_profile_repo_impl.dart';
import 'package:di360_flutter/feature/job_profile/repository/create_job_profile_repository.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class JobProfileCreateViewModel extends ChangeNotifier with ValidationMixins {
  /// Clears all data in the JobProfileViewModel
  void clearAllData() {
    userFullName = "";
    fullNameController.clear();
    mobileNumberController.clear();
    emailAddressController.clear();
    abnNumberController.clear();
    aphraRegistrationNumberController.clear();
    selectedRole = null;
    _selectedEmploymentChips.clear();
    aboutMeController.clear();
    profileFile = null;
    selectworkRight = null;
    selectExperience = null;
    jobDesignationController.clear();
    currentCompanyController.clear();
    languages.clear();
    expertise.clear();
    skillsController.clear();
    joiningDateController.clear();
    availabilityDateController.clear();
    jobTitleController.clear();
    companyController.clear();
    descriptionController.clear();
    QualificationController.clear();
    InstitutionController.clear();
    FinishDateController.clear();
    ExpectedFinishDateController.clear();
    courseHighlightsController.clear();
    selectskills.clear();
    selectedStartMonth = null;
    selectedStartYear = null;
    selectedEndMonth = null;
    selectedEndYear = null;
    isStillWorking = false;
    selectedQualification = null;
    resumeFile = null;
    coverLetterFile = null;
    certificateFile = null;
    _documents.clear();
    finishedDate = null;
    expectedFinishDate = null;
    locationController.clear();
    stateController.clear();
    cityPostCodeController.clear();
    countryController.clear();
    DistanceController.clear();
    selectCountry = null;
    selectedAvailabilityType = "Select Day";
    jobRoles.clear();
    roleOptions.clear();
    isWillingToTravel = false;
    isJoiningImmediate = false;
    joiningDate = null;
    joiningDates.clear();
    availabilityDates.clear();
    selectedDays.clear();
    selectedDates.clear();
    experiences.clear();
    educations.clear();
    notifyListeners();
  }

  final CreateJobProfileRepository repo = CreateJobProfileRepoImpl();
  final HttpService _http = HttpService();

  JobProfileCreateViewModel() {
    fetchJobRoles();
  }

  //Job info Controllers
  String userFullName = "";
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController abnNumberController = TextEditingController();
  String? selectedRole;
  final TextEditingController aphraRegistrationNumberController =
      TextEditingController();
  final TextEditingController percentageController =
      TextEditingController();
  List<String> _selectedEmploymentChips = [];
  final TextEditingController aboutMeController = TextEditingController();
  File? profileFile;
  String? serverProfileFile;
  String profile_img = "";
  String profile_img_name = "";
  List<String> get selectedEmploymentChips =>
      List.unmodifiable(_selectedEmploymentChips);
//Professional info Controllers
  String? selectworkRight;
  String? selectExperience = null;
  final TextEditingController jobDesignationController =
      TextEditingController();
  final TextEditingController currentCompanyController =
      TextEditingController();

// Skills
  final TextEditingController languagesSpokenController =
      TextEditingController();
  final TextEditingController areaOfExpertise = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController availabilityDateController =
      TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController QualificationController = TextEditingController();
  final TextEditingController InstitutionController = TextEditingController();
  final TextEditingController FinishDateController = TextEditingController();
  final TextEditingController DistanceController = TextEditingController();
  final TextEditingController ExpectedFinishDateController =
      TextEditingController();
  final TextEditingController courseHighlightsController =
      TextEditingController();

  List<String> languages = [];
  List<String> expertise = [];
  List<String> selectskills = [];
  String? selectedStartMonth;
  String? selectedStartYear;
  String? selectedEndMonth;
  String? selectedEndYear;
  bool isStillWorking = false;
  String? selectedQualification;
  File? resumeFile;
  File? coverLetterFile;
  File? certificateFile;
  List<FileUpload> serverResumeDocs = [];
  List<FileUpload> serverCertDocs = [];
  List<FileUpload> serverCoverLetter = [];
  Map<String, FileUpload?> serverDocuments = {
    "Resume": null,
    "Certificate": null,
    "Cover Letter": null,
  };

  List<String> removedServerDocKeys = [];

  void removeDocument(String key) {
    if (localDocs.containsKey(key)) {
      localDocs.remove(key);
    } else if (serverDocuments.containsKey(key) &&
        serverDocuments[key] != null) {
      serverDocuments[key] = null; // remove from UI
      removedServerDocKeys.add(key); // store for API
    }
    notifyListeners();
  }

  Map<String, Object?> get combinedDocuments {
    final result = <String, Object?>{};

    // priority 1 → local uploaded
    result.addAll(_documents);

    // priority 2 → server
    serverDocuments.forEach((key, value) {
      if (!result.containsKey(key) && value != null) {
        result[key] = value;
      }
    });

    return result;
  }

  final Map<String, File> _documents = {};
  Map<String, File> get localDocs => _documents;
  DateTime? finishedDate;
  DateTime? expectedFinishDate;

  //
  //Location
  final locationController = TextEditingController();
  final stateController = TextEditingController();
  final cityPostCodeController = TextEditingController();
  final countryController = TextEditingController();
  //
  //Foam valodation
  final GlobalKey<FormState> location = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(6, (_) => GlobalKey<FormState>());
  final List<int> stepsWithValidation = [0];
  final List<String> steps = [
    'Personal ',
    'Professional ',
    'Skills',
    'Availability',
    'Location',
  ];
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => steps.length;

  initializeTheData({required JobProfiles? profile, bool isEdit = false}) {
    getUserFullName();
    if (isEdit) {
      setTheProfileUpdateData(profile);
    }
  }

  getUserFullName() async {
    userFullName = await LocalStorage.getStringVal(LocalStorageConst.name);
    fullNameController.text = userFullName;
    notifyListeners();
  }

  bool validateCurrentStep() {
    if (_currentStep != 0) return true;
    return formKeys[0].currentState?.validate() ?? false;
  }

//
// Selected dropdown values

  String? selectCountry;
  String selectedAvailabilityType = "Select Day";
// Files
//
// Static data
  final List<String> employmentTypeList = [
    "Contractor",
    "Temporary Contractor",
    "Locum",
    "Full Time",
    "Part Time",
    "Casual"
  ];
  final List<String> countryList = ["India", "US", "PK"];
  final List<String> experienceOptions = [
    "0",
    "1-2",
    "3-5",
    "5-10",
    "10-15",
    "15-20",
    "20-25",
    "25-30",
    "30-35",
    "35-40",
    "40+"
  ];
  final List<String> skillsList = ["Skill A", "Skill B", "Skill C"];
  List<String> workRightList = [
    "Australian citizen",
    "Permanent resident",
    "Temporary resident",
    "Overseas Student with work permit"
  ];
  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final List<String> months = const [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<String> years = List.generate(
      DateTime.now().year - 2000 + 1, 
      (index) => (2000 + index).toString()
    ).reversed.toList();

  List<String> availabilityTypes = ["Select Day", "Select Date"];
  List<String> QualificationTypes = ["Yes", "No"];

  // Employment types;
  bool get shouldShowABNField => _selectedEmploymentChips.any(
        (type) =>
            type == "Contractor" ||
            type == "Temporary Contractor" ||
            type == "Locum",
      );
  List<String> getSelectedEmploymentTypes() =>
      List.from(_selectedEmploymentChips);
  //
  //Roles types
  List<JobsRoleLists> jobRoles = [];
  List<String> roleOptions = [];
  //
  //Willing to travel
  bool isWillingToTravel = false;
  //
  //Availability
  bool isJoiningImmediate = false;
  DateTime? joiningDate;
  List<DateTime> joiningDates = [];
  //
  //Availability Type
  List<DateTime> availabilityDates = [];
  List<String> selectedDays = [];
  List<DateTime> selectedDates = [];
  //

  // ───── Navigation Methods ─────
  //stepview navigations...
  void goToNextStep() {
    if (!validateCurrentStep()) return;
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      _currentStep = step;
      pageController.jumpToPage(step);
      notifyListeners();
    }
  }

//validation methods.....
  bool validateJobProfileLocation() {
    return location.currentState?.validate() ?? false;
  }

  // ───── Dropdown setters ─────
  void setSelectedRole(String? value) {
    selectedRole = value;
    notifyListeners();
  }

  void setSelectedCountry(String value) {
    selectCountry = value;
    notifyListeners();
  }

  void setSelectedEmploymentTypes(List<String> selected) {
    if (selected.contains("Locum")) {
      // If Locum is selected, clear all and keep only Locum
      _selectedEmploymentChips.clear();
      _selectedEmploymentChips.add("Locum");
    } else {
      // If other types are selected, clear all and add only non-Locum types
      _selectedEmploymentChips.clear();
      _selectedEmploymentChips.addAll(selected);
    }

    if (!shouldShowABNField) {
      abnNumberController.clear();
    }

    notifyListeners();
  }

  void setSelectedExperience(String? value) {
    selectExperience = value;
    notifyListeners();
  }

  void setSelectedWorkRight(String? value) {
    selectworkRight = value;
    notifyListeners();
  }

  void setSelectedSkills(List<String> value) {
    selectskills = value;
    notifyListeners();
  }

  void toggleStillWorking(bool? value) {
    isStillWorking = value ?? false;
    notifyListeners();
  }

  void setStartMonth(String? month) {
    selectedStartMonth = month;
    notifyListeners();
  }

  void selectedQualifications(String? QualificationTypes) {
    selectedQualification = QualificationTypes;
    notifyListeners();
  }

  void setStartYear(String? year) {
    selectedStartYear = year;
    notifyListeners();
  }

  void setEndMonth(String? month) {
    selectedEndMonth = month;
    notifyListeners();
  }

  void setEndYear(String? year) {
    selectedEndYear = year;
    notifyListeners();
  }

  void setFinishedDate(DateTime date) {
    finishedDate = date;
    notifyListeners();
  }

  void setExpectedFinishDate(DateTime date) {
    expectedFinishDate = date;
    notifyListeners();
  }

  // ───── Employment Chips ─────
  void addEmploymentTypeChip(String empType) {
    if (!_selectedEmploymentChips.contains(empType)) {
      _selectedEmploymentChips.add(empType);
    }
  }

  void removeEmploymentTypeChip(String type) {
    _selectedEmploymentChips.remove(type);

    if (!shouldShowABNField) {
      abnNumberController.clear();
    }

    notifyListeners();
  }

  void clearEmploymentTypeChips() {
    _selectedEmploymentChips.clear();
    abnNumberController.clear();
    notifyListeners();
  }

  // ─────WillingToTravel ─────
  void toggleWillingToTravel(bool value) {
    isWillingToTravel = value;
    notifyListeners();
  }

  //─────ImmediateORJoining─────
  void toggleJoiningImmediate(bool value) {
    isJoiningImmediate = value;
    if (value) {
      joiningDate = null;
    }
    notifyListeners();
  }

  //─────SelectabilityType─────
  void setAvailabilityType(String type) {
    selectedAvailabilityType = type;
    selectedDays.clear();
    selectedDates.clear();
    notifyListeners();
  }

  //─────SelectDay─────
  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  //─────SelectDate─────
  //─────SelectAvailabilityDate─────
  void toggleAvailabilityDate(DateTime date) {
    if (availabilityDates.any((d) => isSameDate(d, date))) {
      availabilityDates.removeWhere((d) => isSameDate(d, date));
    } else {
      availabilityDates.add(date);
    }
    updateAvailabilityDateControllerText();
  }

  void removeAvailabilityDate(DateTime date) {
    availabilityDates.removeWhere((d) => isSameDate(d, date));
    updateAvailabilityDateControllerText();
  }

  void updateAvailabilityDateControllerText() {
    if (availabilityDates.isEmpty) {
      availabilityDateController.clear();
    } else {
      final formatted = availabilityDates
          .map((d) => DateFormat('MMM d, yyyy').format(d))
          .toList();
      availabilityDateController.text = formatted.join(", ");
    }
    notifyListeners();
  }

  bool isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // ───── Data Fetching ─────
  //getjobrolesfromjson....
  Future<void> fetchJobRoles() async {
    jobRoles = await repo.getJobProfiles();
    roleOptions = jobRoles.map((role) => role.roleName ?? "").toList();
    notifyListeners();
  }

  void setProfileImg(File? value) {
    profileFile = value;
    serverProfileFile = null;

    notifyListeners();
  }

  //imagepickers...
  Future<void> pickProfileImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      profileFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickResumePdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      resumeFile = File(result.files.single.path!);
      _documents["Resume"] = resumeFile!;

      notifyListeners();
    }
  }

  Future<void> pickCoverLetterPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      coverLetterFile = File(result.files.single.path!);
      _documents["Cover Letter"] = coverLetterFile!;

      notifyListeners();
    }
  }

  Future<void> pickCertificatePdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      certificateFile = File(result.files.single.path!);
      _documents["Certificate"] = certificateFile!;

      notifyListeners();
    }
  }

  List<JobExperience> experiences = [];
  void addExperience(JobExperience exp) {
    experiences.add(exp);
    notifyListeners();
  }

  void updateExperience(int index, JobExperience exp) {
    experiences[index] = exp;
    notifyListeners();
  }

  void removeExperience(int index) {
    experiences.removeAt(index);
    notifyListeners();
  }

  List<Education> educations = [];

  void addEducation(Education edu) {
    educations.add(edu);
    notifyListeners();
  }

  void updateEducation(int index, Education edu) {
    educations[index] = edu;
    notifyListeners();
  }

  void removeEducation(int index) {
    educations.removeAt(index);
    notifyListeners();
  }

  /*void removeDocument(String title) {
    _documents.remove(title);
    if (title == "Resume") resumeFile = null;
    if (title == "Cover Letter") coverLetterFile = null;
    if (title == "Certificate") certificateFile = null;
    notifyListeners();
  }*/

  /*void removeDocument(String title) {
    /// remove if exists locally
    if (_documents.containsKey(title)) {
      _documents.remove(title);

      if (title == "Resume") resumeFile = null;
      if (title == "Cover Letter") coverLetterFile = null;
      if (title == "Certificate") certificateFile = null;
    } else if (serverDocuments.containsKey(title)) {
      // server doc exists → set to null
      serverDocuments[title] = null;
    }

    notifyListeners();
  }*/

  void addOrUpdateDocument(String title, File file) {
    _documents[title] = file;
    notifyListeners();
  }

  Future<Map<String, dynamic>> uploadFiles(
      Map<String, String?> filePaths) async {
    final entries = filePaths.entries.where((e) => e.value != null).toList();
    final responsesList =
        await Future.wait(entries.map((e) => _http.uploadImage(e.value!)));
    Map<String, dynamic> responses = {};
    for (int i = 0; i < entries.length; i++) {
      responses[entries[i].key] = responsesList[i];
      print(
          "Uploaded ${entries[i].key}: ${entries[i].value} → ${responsesList[i]}");
    }
    for (var entry in filePaths.entries) {
      if (entry.value == null) {
        responses[entry.key] = null;
        print("No file for ${entry.key}");
      }
    }
    return responses;
  }

  Map<String, String> _getFileTypeAndExtension(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    String type;
    
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        type = 'image';
        break;
      case 'mp4':
      case 'mov':
      case 'avi':
        type = 'video';
        break;
      case 'pdf':
        type = 'document';
        break;
      default:
        type = 'file';
    }
    
    return {'type': type, 'extension': extension};
  }

  Future<void> validateProfileImg() async {
    if (serverProfileFile == null) {
      if (profileFile?.path != null) {
        var value = await _http.uploadImage(profileFile?.path);
        print("***********Profile Image Upload Response: $value");
        profile_img = value['url'];
        profile_img_name = value['name'];
        print(profile_img);
        notifyListeners();
      }
    } else {
      profile_img = serverProfileFile ?? "";
      notifyListeners();
    }
    print("***********************Profile Image URL: $profile_img");
  }

  Future<void> createJobProfile(BuildContext context, bool isDraft) async {
    Loaders.circularShowLoader(context);
    Map<String, String?> filePaths = {
      'resume': resumeFile?.path,
      'coverLetter': coverLetterFile?.path,
      'certificate': certificateFile?.path,
    };
    await validateProfileImg();
    final uploadedFiles = await uploadFiles(filePaths);
    try {
      final String? dentalProfessionalId =
          await LocalStorage.getStringVal(LocalStorageConst.userId);
      final result = await repo.createJobProfileListing({
        "jobProfile": [
          {
            "dental_professional_id": dentalProfessionalId,
            "full_name": fullNameController.text,
            "mobile_number": mobileNumberController.text,
            "email_address": emailAddressController.text,
            "profession_type": selectedRole,
            "work_type":
                selectedEmploymentChips.map((toElement) => toElement).toList(),
            "current_company": currentCompanyController.text,
            "job_designation": jobDesignationController.text,
            "state": stateController.text,
            "location": locationController.text,
            "country": selectCountry,
            // "Year_of_experience": selectExperience ?? "",
            "city": cityPostCodeController.text,
            "radius": "0", //no option in mobile design, default to 0
            "availabilityType": selectedAvailabilityType,
            "profile_image": {
              "url": profile_img,
              "name": profile_img_name,
              ..._getFileTypeAndExtension(profileFile?.path ?? profile_img),
            },
            "upload_resume": resumeFile != null
                ? [
                    {
                      "url": uploadedFiles['resume'] != null
                          ? uploadedFiles['resume']["url"]
                          : resumeFile!.path,
                      "name": resumeFile!.path.split("/").last,
                      "type": "pdf",
                      "extension": "pdf",
                    }
                  ]
                : [],
            "certificate": certificateFile != null
                ? [
                    {
                      "url": uploadedFiles['certificate'] != null
                          ? uploadedFiles['certificate']["url"]
                          : profileFile!.path,
                      "name": profileFile!.path.split("/").last,
                      "type": "document",
                      "extension": "pdf",
                    }
                  ]
                : [],
            "cover_letter": coverLetterFile != null
                ? [
                    {
                      "url": uploadedFiles['coverLetter'] != null
                          ? uploadedFiles['coverLetter']["url"]
                          : profileFile!.path,
                      "name": profileFile!.path.split("/").last,
                      "type": "image",
                      "extension": "jpeg",
                    }
                  ]
                : [],
            "abn_number": abnNumberController.text,
            "availabilityOption": selectedAvailabilityType,
            "current_ctc": "100000",
            "post_anonymously":
                false, // we need to send toggle value dynamically
            "admin_status": isDraft ? "DRAFT" : "PENDING",
            "jobexperiences": experiences
                .map((e) => {
                      "company_name": e.companyName,
                      "job_title": e.jobTitle,
                      "ejobdesp": e.jobDescription,
                      "startMonth": e.startMonth,
                      "startYear": e.startYear,
                      "isStillWorking": isStillWorking,
                      "endMonth": e.endMonth,
                      "endYear": e.endYear
                    })
                .toList(),
            "educations": educations
                .map((e) => {
                      "institution": e.institution,
                      "qualification": e.qualification,
                      "selectedQualification": e.selectedQualification,
                      "finishDate": e.finishDate,
                      "qualificationFinished": false,
                      "courseHighlights": e.courseHighlights,
                    })
                .toList(),
            "work_rights": selectworkRight,
            "languages_spoken": languages,
            "areas_expertise": expertise,
            "skills": selectskills.map((toElement) => toElement).toList(),
            "salary_amount": 120000, // need to send dynamically
            "salary_type": "Per Year", // need to send dynamically
            "travel_distance":
                DistanceController.text, // need to send dynamically
            "percentage": "10",
            "aphra_number": aphraRegistrationNumberController.text,
            "willing_to_travel": isWillingToTravel,
            "about_yourself": aboutMeController.text,
            "availabilityDay": selectedDays,
            "Year_of_experiance": selectExperience,
            "availabilityDate":
                availabilityDates.map((d) => d.toIso8601String()).toList(),
            "fromDate":
                joiningDate != null ? [joiningDate!.toIso8601String()] : [],
          }
        ]
      });

      if (result != null) {
        ToastMessage.show('Job Profile Created Successfully!');
      }
    } catch (e) {
      debugPrint("Error in jobProfileListing: $e");
      ToastMessage.show('Job Profile Creation error $e ');
      NavigationService().goBack();
    } finally {
      //Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> updateJobProfile(
      BuildContext context, bool isDraft, String jobProfileId) async {
    Loaders.circularShowLoader(context);
    Map<String, String?> filePaths = {};

    if (serverDocuments["Resume"]?.url == null && resumeFile?.path != null) {
      filePaths['Resume'] = resumeFile!.path;
    }

    if (serverDocuments["Cover Letter"]?.url == null &&
        coverLetterFile?.path != null) {
      filePaths['Cover Letter'] = coverLetterFile!.path;
    }

    if (serverDocuments["Certificate"]?.url == null &&
        certificateFile?.path != null) {
      filePaths['Certificate'] = certificateFile!.path;
    }

    await validateProfileImg();
    final uploadedFiles = await uploadFiles(filePaths);
    try {
      final String? dentalProfessionalId =
          await LocalStorage.getStringVal(LocalStorageConst.userId);
      final result = await repo.updateJobProfileListing({
        "id": jobProfileId,
        "postjobObj": {
          "dental_professional_id": dentalProfessionalId,
          "full_name": fullNameController.text,
          "mobile_number": mobileNumberController.text,
          "email_address": emailAddressController.text,
          "profession_type": selectedRole,
          "work_type":
              selectedEmploymentChips.map((toElement) => toElement).toList(),
          "current_company": currentCompanyController.text,
          "job_designation": jobDesignationController.text,
          "state": stateController.text,
          "location": locationController.text,
          "country": selectCountry,
          // "Year_of_experience": selectExperience ?? "",
          "city": cityPostCodeController.text,
          "radius": "0", //no option in mobile design, default to 0
          "availabilityType": selectedAvailabilityType,
          "profile_image": {
            "url": profile_img,
            "name": profile_img_name,
            ..._getFileTypeAndExtension(profileFile?.path ?? profile_img),
          },
          "upload_resume": [
            {
              "url": serverDocuments["Resume"]?.url ??
                  uploadedFiles["Resume"]?["url"],
              "name": serverDocuments["Resume"]?.name ??
                  uploadedFiles["Resume"]?["name"],
              "type": "pdf",
              "extension": "pdf",
            }
          ],
          "certificate": [
            {
              "url": serverDocuments["Certificate"]?.url ??
                  uploadedFiles["Certificate"]?["url"],
              "name": serverDocuments["Certificate"]?.name ??
                  uploadedFiles["Certificate"]?["name"],
              "type": "document",
              "extension": "pdf",
            }
          ],
          "cover_letter": [
            {
              "url": serverDocuments["Cover Letter"]?.url ??
                  uploadedFiles["Cover Letter"]?["url"],
              "name": serverDocuments["Cover Letter"]?.name ??
                  uploadedFiles["Cover Letter"]?["name"],
              "type": "image",
              "extension": "jpeg",
            }
          ],
          "Year_of_experiance": selectExperience,

          "abn_number": abnNumberController.text,
          "availabilityOption": selectedAvailabilityType,
          "current_ctc": "100000",
          "post_anonymously": false, // we need to send toggle value dynamically
          "admin_status": isDraft ? "DRAFT" : "PENDING",
          "jobexperiences": experiences
              .map((e) => {
                    "company_name": e.companyName,
                    "job_title": e.jobTitle,
                    "ejobdesp": e.jobDescription,
                    "startMonth": e.startMonth,
                    "startYear": e.startYear,
                    "isStillWorking": isStillWorking,
                    "endMonth": e.endMonth,
                    "endYear": e.endYear
                  })
              .toList(),
          "educations": educations
              .map((e) => {
                    "institution": e.institution,
                    "qualification": e.qualification,
                    "selectedQualification": e.selectedQualification,
                    "finishDate": e.finishDate,
                    "qualificationFinished": false,
                    "courseHighlights": e.courseHighlights,
                  })
              .toList(),
          "work_rights": selectworkRight,
          "languages_spoken": languages,
          "areas_expertise": expertise,
          "skills": selectskills.map((toElement) => toElement).toList(),
          "salary_amount": 120000, // need to send dynamically
          "salary_type": "Per Year", // need to send dynamically
          "travel_distance":
              DistanceController.text, // need to send dynamically
          "percentage": "10",
          "aphra_number": aphraRegistrationNumberController.text,
          "willing_to_travel": isWillingToTravel,
          "about_yourself": aboutMeController.text,
          "availabilityDay": selectedDays,
          "availabilityDate":
              availabilityDates.map((d) => d.toIso8601String()).toList(),
          "fromDate":
              joiningDate != null ? [joiningDate!.toIso8601String()] : [],
        }
      });

      if (result != null) {
        ToastMessage.show('Job Profile Updated Successfully!');
      }
    } catch (e) {
      debugPrint("Error in jobProfileListing: $e");
      ToastMessage.show('Job Profile Creation error $e ');
      NavigationService().goBack();
    } finally {
      //Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  setTheProfileUpdateData(JobProfiles? profile) {
    mobileNumberController.text = profile?.mobileNumber ?? "";
    emailAddressController.text = profile?.emailAddress ?? "";
    selectedRole = profile?.professionType;
    _selectedEmploymentChips = profile?.workType ?? [];
    abnNumberController.text = profile?.abnNumber ?? "";
    jobDesignationController.text = profile?.jobDesignation ?? "";
    currentCompanyController.text = profile?.currentCompany ?? "";
    selectworkRight = profile?.workRights ?? "";
    selectExperience =
        profile?.yearOfExperience != null ? profile?.yearOfExperience : "0";
    languages = profile?.languagesSpoken ?? [];
    expertise = profile?.areasExpertise ?? [];
    selectskills = profile?.skills ?? [];
    locationController.text = profile?.location ?? "";
    countryController.text = profile?.country ?? "";
    stateController.text = profile?.state ?? "";
    cityPostCodeController.text = profile?.city ?? "";
    experiences = profile?.jobExperiences ?? [];
    aphraRegistrationNumberController.text = profile?.aphraNumber ?? "";
    educations = profile?.educations ?? [];

    isWillingToTravel = profile?.willingToTravel ?? false;
    DistanceController.text = profile?.travelDistance ?? "";
    serverProfileFile = profile?.profileImage.length != 0
        ? profile?.profileImage.first.url
        : "";
    serverResumeDocs = profile?.uploadResume ?? [];
    serverCertDocs = profile?.certificate ?? [];
    serverCoverLetter = profile?.coverLetter ?? [];
    serverDocuments = {
      "Resume": serverResumeDocs.isNotEmpty ? serverResumeDocs.first : null,
      "Certificate": serverCertDocs.isNotEmpty ? serverCertDocs.first : null,
      "Cover Letter":
          serverCoverLetter.isNotEmpty ? serverCoverLetter.first : null,
    };
    selectedAvailabilityType = profile?.availabilityType ?? "";
    selectedDays = profile?.availabilityDay ?? [];

    availabilityDates = profile?.availabilityDate
            ?.map((dateStr) => DateTime.parse(dateStr))
            .toList() ??
        [];
    availabilityDateController.text = availabilityDates
        .map((d) => DateFormat('MMM d, yyyy').format(d))
        .toList()
        .join(", ");
    //isJoiningImmediate = profile?.i

    aboutMeController.text = profile?.aboutYourself ?? "";

    notifyListeners();
  }

  JobProfiles? jobProfilePreviewData;

  Future<void> setJobProfilePreviewData() async {
    Map<String, String?> filePaths = {};

    if (serverDocuments["Resume"]?.url == null && resumeFile?.path != null) {
      filePaths['Resume'] = resumeFile!.path;
    }

    if (serverDocuments["Cover Letter"]?.url == null &&
        coverLetterFile?.path != null) {
      filePaths['Cover Letter'] = coverLetterFile!.path;
    }

    if (serverDocuments["Certificate"]?.url == null &&
        certificateFile?.path != null) {
      filePaths['Certificate'] = certificateFile!.path;
    }

    await validateProfileImg();
    final uploadedFiles = await uploadFiles(filePaths);
    jobProfilePreviewData = JobProfiles(
        id: "",
        fullName: fullNameController.text,
        mobileNumber: mobileNumberController.text,
        emailAddress: emailAddressController.text,
        professionType: selectedRole,
        workType:
            selectedEmploymentChips.map((toElement) => toElement).toList(),
        currentCompany: currentCompanyController.text,
        jobDesignation: jobDesignationController.text,
        state: stateController.text,
        location: locationController.text,
        country: selectCountry,
        city: cityPostCodeController.text,
        radius: "0",
        availabilityType: selectedAvailabilityType,
        profileImage: [
          FileUpload(
              url: profile_img,
              name: profile_img_name,
              type: "image",
              extension: "jpeg")
        ],
        uploadResume: [
          FileUpload(
              url: serverDocuments["Resume"]?.url ??
                  uploadedFiles["Resume"]?["url"],
              name: serverDocuments["Resume"]?.name ??
                  uploadedFiles["Resume"]?["name"],
              type: "pdf",
              extension: "pdf")
        ],
        certificate: [
          FileUpload(
              url: serverDocuments["Certificate"]?.url ??
                  uploadedFiles["Certificate"]?["url"],
              name: serverDocuments["Certificate"]?.name ??
                  uploadedFiles["Certificate"]?["name"],
              type: "pdf",
              extension: "pdf")
        ],
        coverLetter: [
          FileUpload(
              url: serverDocuments["Cover Letter"]?.url ??
                  uploadedFiles["Cover Letter"]?["url"],
              name: serverDocuments["Cover Letter"]?.name ??
                  uploadedFiles["Cover Letter"]?["name"],
              type: "pdf",
              extension: "pdf")
        ],
        yearOfExperience: selectExperience,
        abnNumber: abnNumberController.text,
        availabilityOption: selectedAvailabilityType,
        currentCtc: "100000",
        postAnonymously: false,
        adminStatus: "",
        jobExperiences: experiences
            .map((e) => JobExperience(
                companyName: e.companyName,
                jobTitle: e.jobTitle,
                jobDescription: e.jobDescription,
                startMonth: e.startMonth,
                startYear: e.startYear,
                stillInRole: isStillWorking,
                endMonth: e.endMonth,
                endYear: e.endYear))
            .toList(),
        educations: [],
        workRights: selectworkRight,
        languagesSpoken: languages,
        areasExpertise: expertise,
        skills: selectskills.map((toElement) => toElement).toList(),
        salaryAmount: 0,
        salaryType: "Per Year",
        travelDistance: DistanceController.text,
        percentage: "10",
        aphraNumber: aphraRegistrationNumberController.text,
        willingToTravel: isWillingToTravel,
        aboutYourself: aboutMeController.text,
        availabilityDay: selectedDays,
        availabilityDate:
            availabilityDates.map((d) => d.toIso8601String()).toList(),
        fromDate: joiningDate != null ? [joiningDate!.toIso8601String()] : [],
        unavailabilityDate: [],
        jobHirings: []);

    notifyListeners();
  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    emailAddressController.dispose();
    abnNumberController.dispose();
    aphraRegistrationNumberController.dispose();
    aboutMeController.dispose();
    jobDesignationController.dispose();
    currentCompanyController.dispose();
    languagesSpokenController.dispose();
    areaOfExpertise.dispose();
    pageController.dispose();
    jobTitleController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    QualificationController.dispose();
    InstitutionController.dispose();
    FinishDateController.dispose();
    ExpectedFinishDateController.dispose();
    courseHighlightsController.dispose();
    DistanceController.dispose();
    availabilityDateController.dispose();
    locationController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityPostCodeController.dispose();
    super.dispose();
  }
}
