import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile/constants/create_profile_constants.dart';
import 'package:di360_flutter/feature/job_profile/model/job_experience.dart';
import 'package:di360_flutter/feature/job_profile/model/job_education.dart';
import 'package:di360_flutter/feature/job_profile/model/job_profile_role_response.dart';
import 'package:di360_flutter/feature/job_profile/repository/create_job_profile_repo_impl.dart';
import 'package:di360_flutter/feature/job_profile/repository/create_job_profile_repository.dart';
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
    AphraRegistrationNumberController.clear();
    selectedRole = null;
    _selectedEmploymentChips.clear();
    aboutMeController.clear();
    profileFile = null;
    selectworkRight = null;
    selectExperience = null;
    jobDesignationController.clear();
    currentCompanyController.clear();
    languagesSpokenController.clear();
    areaOfExpertise.clear();
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
  final TextEditingController AphraRegistrationNumberController =
      TextEditingController();
  final List<String> _selectedEmploymentChips = [];
  final TextEditingController aboutMeController = TextEditingController();
  File? profileFile;
  List<String> get selectedEmploymentChips =>
      List.unmodifiable(_selectedEmploymentChips);
//Professional info Controllers
  String? selectworkRight;
  String? selectExperience;
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
  final Map<String, File> _documents = {};
  Map<String, File> get documents => _documents;
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

  initializeTheData() {
    getUserFullName();
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
  final List<String> employmentTypeList = employmentTypes;
  final List<String> experienceOptions = experienceOptionsList;
  final List<String> skillsList = skills;
  final List<String> workRightList = workRights;
  List<String> weekDays = weekDaysList;
  final List<String> months =monthsList;
  final List<String> years =
      List.generate(30, (index) => (2000 + index).toString());

  List<String> availabilityTypes = availability;
  List<String> qualificationTypes = qualification;

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
    _selectedEmploymentChips
      ..clear()
      ..addAll(selected);

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

  final List<Experience> experiences = [];
  void addExperience(Experience exp) {
    experiences.add(exp);
    notifyListeners();
  }

  void updateExperience(int index, Experience exp) {
    experiences[index] = exp;
    notifyListeners();
  }

  void removeExperience(int index) {
    experiences.removeAt(index);
    notifyListeners();
  }

  final List<Education> educations = [];

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

  void removeDocument(String title) {
    _documents.remove(title);
    if (title == "Resume") resumeFile = null;
    if (title == "Cover Letter") coverLetterFile = null;
    if (title == "Certificate") certificateFile = null;
    notifyListeners();
  }

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
Future<void> createJobProfile(BuildContext context, bool isDraft) async {
    Loaders.circularShowLoader(context);
    Map<String, String?> filePaths = {
      'profile': profileFile?.path,
      'resume': resumeFile?.path,
      'coverLetter': coverLetterFile?.path,
      'certificate': certificateFile?.path,
    };
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
            "city": cityPostCodeController.text,
            "radius": "0", //no option in mobile design, default to 0
            "availabilityType": selectedAvailabilityType,
            "profile_image": profileFile != null
                ? [
                    {
                      "url": uploadedFiles['profile'] != null
                          ? uploadedFiles['profile']["url"]
                          : profileFile!.path,
                      "name": profileFile!.path.split("/").last,
                      "type": "image",
                      "extension": "jpeg",
                    }
                  ]
                : [],
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
                      "company_name": e.company,
                      "job_title": e.jobTitle,
                      "ejobdesp": e.description,
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
            "languages_spoken": languagesSpokenController.text,
            "areas_expertise": areaOfExpertise.text,
            "skills": selectskills.map((toElement) => toElement).toList(),
            "salary_amount": 120000, // need to send dynamically
            "salary_type": "Per Year", // need to send dynamically
            "travel_distance":
                DistanceController.text, // need to send dynamically
            "percentage": "10",
            "aphra_number": AphraRegistrationNumberController.text,
            "willing_to_travel": isWillingToTravel,
            "about_yourself": aboutMeController.text,
            "availabilityDay": selectedDays,
            "availabilityDate":
                availabilityDates.map((d) => d.toIso8601String()).toList(),
            "fromDate":
                joiningDate != null ? [joiningDate!.toIso8601String()] : [],
          }
        ]
      });

      if (result != null) {
        clearAllData();
        ToastMessage.show('Job Profile Created Successfully!');
        NavigationService().goBack();
      }
    } catch (e) {
      debugPrint("Error in jobProfileListing: $e");
      ToastMessage.show('Job Profile Creation error $e ');
      NavigationService().goBack();
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    emailAddressController.dispose();
    abnNumberController.dispose();
    AphraRegistrationNumberController.dispose();
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
