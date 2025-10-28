import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_create/constants/job_create_constants.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/toast.dart';
import 'package:di360_flutter/utils/date_utils.dart' as di360_date_utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repo_impl.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repository.dart';
import 'package:di360_flutter/services/navigation_services.dart';

class JobCreateViewModel extends ChangeNotifier with ValidationMixins {
  final JobCreateRepository repo = JobCreateRepoImpl();
  final HttpService _http = HttpService();

  JobCreateViewModel() {
    getUserId();
    fetchJobRoles();
    fetchEmpTypes();
    pageController = PageController(initialPage: _currentStep);
  }

  // Controllers
  String CompanyName = "";
  final TextEditingController jobTitleController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobDescController = TextEditingController();
  final videoLinkController = TextEditingController();
  final websiteController = TextEditingController();
  final facebookController = TextEditingController();
  final instgramController = TextEditingController();
  final linkedInController = TextEditingController();
  final locationSearchController = TextEditingController();
  final stateController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final cityPostCodeController = TextEditingController();
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final countryController = TextEditingController();

  // NEW: Locum date controller
  final TextEditingController locumDateController = TextEditingController();
  final TextEditingController startLocumDateController =
      TextEditingController();
  final TextEditingController endLocumDateController = TextEditingController();
  DateTime? startLocumDate;
  DateTime? endLocumDate;
  bool showLocumDate = false;

  void clearDateFields() {
    locumDateController.clear();
    startLocumDateController.clear();
    endLocumDateController.clear();
  }

  // Selected dropdown values
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectedPayRange;
  String? selectRate;
  String? selectCountry;
  String? selectEducation;
  String? selecteBenefitsType;
  String? selectHire;
  String? selectPositions;
  String? selectExperience;
  String? supplierId;
  String? practiceId;
  String? userID;
  String? logoPath;
  dynamic banner_image;
  bool jobEditOptionEnable = false;
  String? jobId;
  // Date settings
  bool isStartDateEnabled = false;
  bool isEndDateEnabled = false;
  DateTime? startDate;
  DateTime? endDate;

  // Files
  File? logoFile;
  File? bannerFile;
  String? serverBannerImg;
  List<File>? clinicPhotos = [];
  List<String> serverClinicImgs = [];
  bool editMode = false;
  List<CourseBannerImage> selectedClinicImgList = [];

  void setBannerImg(File? value) {
    bannerFile = value;

    notifyListeners();
  }

  void setClinicPhotos(List<File> value) {
    clinicPhotos = value;
    notifyListeners();
  }

  void setServerClinic(List<String> value) {
    serverClinicImgs = value;
    notifyListeners();
  }

  // Form & PageView
  final GlobalKey<FormState> otherLinksFormKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(6, (_) => GlobalKey<FormState>());
  final List<int> stepsWithValidation = stepsWithValidationList;
  final List<String> steps = stepsList;
  late final PageController pageController;
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => steps.length;
  // Static data
/*<<<<<<< HEAD
  final List<String> countryList = ["India", "us", "pk"];
  final List<String> HireList = [
    "urgently",
    "1-2 weeks",
    "2-4 weeks",
    "More than 4 weeks"
  ];
  final List<String> positionsOptions = ["1", "2", "3", "4", "5", "6+"];
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
  final List<String> educationLevels = [
    "High School",
    "Diploma",
    "Graduate",
    "Postgraduate",
    "PhD"
  ];
  final List<String> Benefits = [
    "Performance bonus",
    "Commission",
    "Relocation fees",
    "Tips",
    "Overtime pay",
    "Signing Bonus",
    "Bonus",
    "Annual Bonus",
    "Quarterly bonus",
    "Employee Discount",
    "Visa sponsorship",
    "Employee Mentoring program",
    "Professional Development assistance",
    "Company car",
    "Travel reimbursement",
    "Housingallowance",
    "Other",
  ];
  final List<String> payRanges = ["Range"];
  final List<String> rateTypes = [
    "Per year",
    "Per month",
    "Per week",
    "Per hour",
    "Commission"
  ];
=======*/
  final List<String> countryList = country;
  final List<String> HireList = Hire;
  final List<String> positionsOptions = positionsList;
  final List<String> experienceOptions = experienceList;
  final List<String> educationLevels = educationList;
  final List<String> benefitsList = benifits;
  final List<String> payRanges = payList;
  final List<String> rateTypes = rateList;

  // Chips values..
  final List<String> _selectedEmploymentChips = [];
  List<String> get selectedEmploymentChips =>
      List.unmodifiable(_selectedEmploymentChips);
  final List<String> _selectedBenefits = [];
  List<String> get selectedBenefits => List.unmodifiable(_selectedBenefits);
  List<JobsRoleList> jobRoles = [];
  List<String> roleOptions = [];
  List<JobTypes> empTypes = [];
  List<String> empOptions = [];

  // ───── Navigation Methods ─────
  void goToNextStep() {
    if (!validateCurrentStep()) return;
    if (_currentStep == 1) {
      (bannerFile != null) ? validateLogoAndBanner() : null;
      (clinicPhotos != null) ? validateClinic() : null;
    }
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
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

  initializeTheData() {
    getCompanyName();
  }

  void setJobEditOption(bool value) {
    jobEditOptionEnable = value;
    editMode = value;
    notifyListeners();
  }

  void setJobId(String value) {
    jobId = value;
    notifyListeners();
  }

  getCompanyName() async {
    CompanyName = await LocalStorage.getStringVal(LocalStorageConst.name);
    companyNameController.text = CompanyName;
    notifyListeners();
  }

  // ───── Validation Methods ─────
  bool validateCurrentStep() {
    if (_currentStep == 5) return validateOtherLinksStep();
    return formKeys[_currentStep].currentState?.validate() ?? false;
  }

  void validateLogoAndBanner() async {
    if (serverBannerImg == null) {
      var value = await _http.uploadImage(bannerFile?.path);
      banner_image = value['url'];
      print(banner_image);
      notifyListeners();
    } else {
      banner_image = serverBannerImg ?? "";
      notifyListeners();
    }
  }

  Future<void> validateClinic() async {
    if (editMode) {
      selectedClinicImgList = await uploadFiles(
        clinicPhotos,
        (file, res) => CourseBannerImage(
          name: file.path.split('/').last,
          url: res['url'],
          type: res['type'] ?? "image/jpeg",
          size: res['size'] ?? file.lengthSync(),
        ),
      );
      final newUrls = selectedClinicImgList
          .map((img) => img.url)
          .whereType<String>()
          .toList();
      if (serverClinicImgs == null) {
        serverClinicImgs = newUrls;
      } else {
        serverClinicImgs = [...serverClinicImgs!, ...newUrls];
      }

      selectedClinicImgList = serverClinicImgs!
          .map(
            (url) => CourseBannerImage(
              name: url.split('/').last,
              url: url,
              type: "image/jpeg", // you can adjust if you have type info
              size: 0, // since we don’t know original file size
            ),
          )
          .toList();
    } else {
      // Otherwise upload the new images
      selectedClinicImgList = await uploadFiles(
        clinicPhotos,
        (file, res) => CourseBannerImage(
          name: file.path.split('/').last,
          url: res['url'],
          type: res['type'] ?? "image/jpeg",
          size: res['size'] ?? file.lengthSync(),
        ),
      );
    }

    notifyListeners();
  }

  Future<List<T>> uploadFiles<T>(
    List<File>? files,
    T Function(File, Map<String, dynamic>) builder,
  ) async {
    if (files == null || files.isEmpty) return [];

    final List<T> uploaded = [];

    for (var file in files) {
      final response = await _http.uploadImage(file.path);

      uploaded.add(builder(file, response));
    }
    return uploaded;
  }

  bool validateOtherLinksStep() {
    return otherLinksFormKey.currentState?.validate() ?? false;
  }

  String? validateMinSalary() =>
      validateSalaryField(minSalaryController.text, field: 'minimum');
  String? validateMaxSalary() =>
      validateSalaryField(maxSalaryController.text, field: 'maximum');
  String? validateVideoLink(String? _) =>
      validateOptionalUrl(videoLinkController.text);
  String? validateWebsite(String? _) =>
      validateOptionalUrl(websiteController.text);
  String? validateFacebook(String? _) =>
      validateOptionalUrl(facebookController.text);
  String? validateInstagram(String? _) =>
      validateOptionalUrl(instgramController.text);
  String? validateLinkedIn(String? _) =>
      validateOptionalUrl(linkedInController.text);
  String? validateStartDateField(String? _) =>
      validateStartDate(isStartDateEnabled, startDate);
  String? validateEndDateField(String? _) =>
      validateEndDate(isEndDateEnabled, endDate);

  // ───── Dropdown setters ─────
  void setSelectedRole(String? value) {
    selectedRole = value;
    notifyListeners();
  }

  void setSelectedCountry(String value) {
    selectCountry = value;
    notifyListeners();
  }

  void setSelectedEmpType(String emp) {
    selectedEmploymentType = emp;
    notifyListeners();
  }

  void setSelectedPayRange(String? value) {
    selectedPayRange = value;
    notifyListeners();
  }

  void setSelectedRateRange(String? value) {
    selectRate = value;
    notifyListeners();
  }

  void setSelectedHireRange(String? value) {
    selectHire = value;
    notifyListeners();
  }

  void setSelectedPositions(String? value) {
    selectPositions = value;
    notifyListeners();
  }

  void setSelectedExperience(String? value) {
    selectExperience = value;
    notifyListeners();
  }

  void setSelectedEducation(String? value) {
    selectEducation = value;
    notifyListeners();
  }

  // ───── Benefits  ─────
  void setSelectedBenefits(List<String> values) {
    _selectedBenefits
      ..clear()
      ..addAll(values);
    notifyListeners();
  }

  void addBenefit(String benefit) {
    if (!_selectedBenefits.contains(benefit)) {
      _selectedBenefits.add(benefit);
      notifyListeners();
    }
  }

  void removeBenefit(String benefit) {
    _selectedBenefits.remove(benefit);
    notifyListeners();
  }

  // ───── Date togglers ─────
  void toggleStartDate(bool value) {
    isStartDateEnabled = value;
    notifyListeners();
  }

  void toggleEndDate(bool value) {
    isEndDateEnabled = value;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
  }

  // ───── Locum Toggle ─────
  String _formatDate(DateTime date) {
    return di360_date_utils.DateFormatUtils.formatToDayMonthYear(date);
  }

  void setStartLocumDate(DateTime date) {
    startLocumDate = date;
    startLocumDateController.text =
        di360_date_utils.DateFormatUtils.formatToYyyyMmDd(date);
    updateLocumSummary();
    notifyListeners();
  }

  void setEndLocumDate(DateTime date) {
    endLocumDate = date;
    endLocumDateController.text =
        di360_date_utils.DateFormatUtils.formatToYyyyMmDd(date);
    updateLocumSummary();
    notifyListeners();
  }

  void clearDates() {
    startLocumDate = null;
    endLocumDate = null;
    startLocumDateController.clear();
    endLocumDateController.clear();
    locumDateController.clear();
    notifyListeners();
  }

  void updateLocumSummary() {
    if (startLocumDate != null && endLocumDate != null) {
      locumDateController.text =
          "${_formatDate(startLocumDate!)} – ${_formatDate(endLocumDate!)}";
    } else {
      locumDateController.clear();
    }
  }

  void toggleLocumDateVisibility(bool value) {
    showLocumDate = value;
    if (!value) {
      clearDates();
    }
    notifyListeners();
  }

  /// Employment chip management
  void _updateLocumVisibility() {
    final hasLocum = _selectedEmploymentChips.contains("Locum");
    toggleLocumDateVisibility(hasLocum);
  }

  void addEmploymentTypeChip(String empType) {
    if (!_selectedEmploymentChips.contains(empType)) {
      _selectedEmploymentChips.add(empType);
      _updateLocumVisibility();
    }
  }

  void removeEmploymentTypeChip(String empType) {
    _selectedEmploymentChips.remove(empType);
    _updateLocumVisibility();
  }

  void clearEmploymentTypeChips() {
    _selectedEmploymentChips.clear();
    _updateLocumVisibility();
  }

  List<String> getSelectedEmploymentTypes() =>
      List.from(_selectedEmploymentChips);
  //Image Pickers...
  Future<void> pickBannerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      bannerFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  void removeBanner() {
    bannerFile = null;
    notifyListeners();
  }

  /* Future<void> pickClinicPhoto(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      clinicPhotos.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  void removeClinicPhoto(File file) {
    clinicPhotos.remove(file);
    notifyListeners();
  }

  void clearClinicPhotos() {
    clinicPhotos.clear();
    notifyListeners();
  }*/

  /* Future<Map<String, dynamic>> uploadFiless(
    Map<String, String?> filePaths, {
    List<File>? clinicPhotos,
  }) async {
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
      }
    }
    if (clinicPhotos != null && clinicPhotos.isNotEmpty) {
      final clinicResponses = await Future.wait(
        clinicPhotos.map((file) => _http.uploadImage(file.path)),
      );
      responses['clinic_logo'] = clinicResponses.map((res) {
        final fileName =
            clinicPhotos[clinicResponses.indexOf(res)].path.split('/').last;
        return {
          "url": res["url"],
          "name": fileName,
          "type": "image",
          "extension": "jpeg",
        };
      }).toList();
    } else {
      responses['clinic_logo'] = [];
    }
    return responses;
  }*/

  // ───── Data Fetching ─────
  Future<void> fetchJobRoles() async {
    jobRoles = await repo.getJobRoles();
    roleOptions = jobRoles.map((role) => role.roleName ?? "").toList();
    notifyListeners();
  }

  Future<void> fetchEmpTypes() async {
    empTypes = await repo.getEmpTypes();
    empOptions = empTypes.map((emp) => emp.employeeTypeName ?? "").toList();
    notifyListeners();
  }

  getUserId() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final logo = await LocalStorage.getStringVal(LocalStorageConst.profilePic);
    userID = userId;
    logoPath = logo;
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    if (type == 'SUPPLIER') {
      supplierId = userId;
    } else if (type == 'PRACTICE') {
      practiceId = userId;
    }
    notifyListeners();
  }

// #region ... Create Job
  Future<void> createdJobListing(BuildContext context, bool isDraft) async {
    Loaders.circularShowLoader(context);
    /*Map<String, String?> filePaths = {
      'banner': bannerFile?.path,
    };
    final uploadedFiles = await uploadFiless(
      filePaths,
      clinicPhotos: clinicPhotos,
    );*/
    final result = await repo.createJobListing({
      "postjobObj": {
        "title": jobTitleController.text, // String
        "j_type": "", //
        "j_role": selectedRole,
        "roles_and_responsibilities": "",
        "address": {}, //As per Api this is empty object
        "days_of_week": {}, //As per Api this is empty object
        "is_featured": false, // Default is false -> for now we are not using it
        "number_of_positions": 1, //TODO: Need to change it to dynamic
        "description": jobDescController.text,
        "closing_message": "",
        "experience": "",
        "skills": [],
        "jobexperiences": [],
        "upload_resume": [],
        "current_company": "",
        "job_location": "", //Need to discuss with backend
        "job_designation": "", //Need to discuss with backend
        "offered_supplement": "", //Need to discuss with backend
        "TypeofEmployment": selectedEmploymentChips,
        "availability_date": [
          startLocumDateController.text,
          endLocumDateController.text
        ],
        "years_of_experience": selectExperience,
        "dental_supplier_id": supplierId,
        "dental_practice_id": practiceId,
        "location": locationSearchController.text,
        "logo": logoPath,
        "state": stateController.text,
        "city": cityPostCodeController.text,
        "salary": "Range", //Need to discuss with backend
        "pay_min": minSalaryController.text,
        "pay_max": maxSalaryController.text,
        "company_name": companyNameController.text,
        "pay_range":
            selectedPayRange, //Getting fron Dropdown, this is static data for now
        "education":
            selectEducation, // Getting fron Dropdown, this is static data for now
        "video": videoLinkController.text,
        "banner_image": bannerFile != null
            ? [
                {
                  "url": banner_image,
                  "name": bannerFile!.path.split("/").last,
                  "type": "image",
                  "extension": "jpeg",
                }
              ]
            : [],

        "clinic_logo": selectedClinicImgList,

        // {
        //   "url":
        //       "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/9c67fdf5-c331-47d3-ae30-24be740056c3",
        //   "type": "image",
        //   "extension": "jpeg"
        // }
        //TODO: need to send array of object

        "closed_at": endDate?.toUtc().toIso8601String(),
        "status": isDraft
            ? "DRAFT"
            : "PENDING", // REJECT,APPROVE,PENDING,EXPIRED,DRAFT,
        "active_status":
            "ACTIVE", // This is default ACTIVE, Backend team ask me to send this value
        "website_url": websiteController.text,
        "country": selectCountry,
        "endDateToggle": isEndDateEnabled == true ? "YES" : "NO",
        "offered_benefits": selectedBenefits,
        //[ "Performance bonus", "Commission", "relcation fees" ]// TODO: Need to send array of string
        "hiring_period": selectHire,
        "no_of_people": selectPositions,
        "rate_billing": selectRate,
        "facebook_url": facebookController.text,
        "instagram_url": instgramController.text,
        "linkedin_url": linkedInController.text,
        "twitter_url": "", // No option from the UI for now this field is empty
        "timings": startDate?.toUtc().toIso8601String(),
        "timingtoggle": isStartDateEnabled == true ? "YES" : "NO",
        //"auto_expiry_date": null,
        "active_status_feed": isDraft ? null : "PENDING",
        "feed_type": "JOBS"
      }
    });
    if (result != null) {
      ToastMessage.show('Job  Created Successfully!');
      NavigationService().goBack();
    }
  }

  Future<void> updateJobListing(
      BuildContext context, bool isDraft, String jobId) async {
    Loaders.circularShowLoader(context);
    Map<String, String?> filePaths = {
      'banner': bannerFile?.path,
    };
    /* final uploadedFiles = await uploadFiles(
      filePaths,
      clinicPhotos: clinicPhotos,
    );*/
    final result = await repo.updateJobListing({
      "id": jobId,
      "postjobObj": {
        "title": jobTitleController.text, // String
        "j_type": "", //
        "j_role": selectedRole,
        "roles_and_responsibilities": "",
        "address": {}, //As per Api this is empty object
        "days_of_week": {}, //As per Api this is empty object
        "is_featured": false, // Default is false -> for now we are not using it
        "number_of_positions": 1,
        "description": jobDescController.text,
        "closing_message": "",
        "experience": "",
        "skills": [],
        "jobexperiences": [],
        "upload_resume": [],
        "current_company": "",
        "job_location": "", //Need to discuss with backend
        "job_designation": "", //Need to discuss with backend
        "offered_supplement": "", //Need to discuss with backend
        "TypeofEmployment": selectedEmploymentChips,
        "availability_date": [
          startLocumDateController.text,
          endLocumDateController.text
        ],
        "years_of_experience": selectExperience,
        "dental_supplier_id": supplierId,
        "dental_practice_id": practiceId,
        "location": locationSearchController.text,
        "logo": logoPath,
        "state": stateController.text,
        "city": cityPostCodeController.text,
        "salary": "Range", //Need to discuss with backend
        "pay_min": minSalaryController.text,
        "pay_max": maxSalaryController.text,
        "company_name": companyNameController.text,
        "pay_range":
            selectedPayRange, //Getting fron Dropdown, this is static data for now
        "education":
            selectEducation, // Getting fron Dropdown, this is static data for now
        "video": videoLinkController.text,
        "banner_image": bannerFile != null
            ? [
                {
                  "url": banner_image,
                  "name": bannerFile!.path.split("/").last,
                  "type": "image",
                  "extension": "jpeg",
                }
              ]
            : [],

        "clinic_logo": selectedClinicImgList,

        // {
        //   "url":
        //       "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/9c67fdf5-c331-47d3-ae30-24be740056c3",
        //   "type": "image",
        //   "extension": "jpeg"
        // }
        //TODO: need to send array of object

        "closed_at": endDate?.toUtc().toIso8601String(),
        "status": isDraft
            ? "DRAFT"
            : "PENDING", // REJECT,APPROVE,PENDING,EXPIRED,DRAFT,
        "active_status":
            "ACTIVE", // This is default ACTIVE, Backend team ask me to send this value
        "website_url": websiteController.text,
        "country": selectCountry,
        "endDateToggle": isEndDateEnabled == true ? "YES" : "NO",
        "offered_benefits": selectedBenefits,
        //[ "Performance bonus", "Commission", "relcation fees" ]// TODO: Need to send array of string
        "hiring_period": selectHire,
        "no_of_people": selectPositions,
        "rate_billing": selectRate,
        "facebook_url": facebookController.text,
        "instagram_url": instgramController.text,
        "linkedin_url": linkedInController.text,
        "twitter_url": "", // No option from the UI for now this field is empty
        "timings": startDate?.toUtc().toIso8601String(),
        "timingtoggle": isStartDateEnabled == true ? "YES" : "NO",
        //"auto_expiry_date": null,
        "active_status_feed": isDraft ? null : "PENDING",
        "feed_type": "JOBS"
      }
    });
    if (result != null) {
      navigationService.goBack();
      Loaders.circularHideLoader(context);
      scaffoldMessenger("Course is updated Successfully");
    } else {
      Loaders.circularHideLoader(context);
    }
  }

  Future<void> loadJobData(Jobs? jobData) async {
    //print("printinnnnn $jobData");
    jobTitleController.text = jobData?.title ?? "";
    companyNameController.text = jobData?.companyName ?? "";
    selectedRole = jobData?.jRole ?? "";
    jobDescController.text = jobData?.description ?? "";
    videoLinkController.text = jobData?.video ?? "";
    countryController.text = jobData?.country ?? "";
    serverBannerImg = jobData?.bannerImage?.url;

    serverClinicImgs =
        jobData?.clinicLogo?.map((e) => e.url).whereType<String>().toList() ??
            [];
    selectExperience = jobData?.yearsOfExperience ?? "";
    websiteController.text = jobData?.websiteUrl ?? "";
    facebookController.text = jobData?.facebookUrl ?? "";
    instgramController.text = jobData?.instagramUrl ?? "";
    linkedInController.text = jobData?.linkedinUrl ?? "";
    locationSearchController.text = jobData?.location ?? "";
    stateController.text = jobData?.state ?? "";
    cityPostCodeController.text = jobData?.city ?? "";
    minSalaryController.text = jobData?.payMin?.toString() ?? "";
    maxSalaryController.text = jobData?.payMax?.toString() ?? "";

    selectedEmploymentType = jobData?.typeofEmployment?.isNotEmpty == true
        ? jobData?.typeofEmployment!.first
        : null;
    _selectedEmploymentChips
      ..clear()
      ..addAll(jobData?.typeofEmployment ?? []);
    _updateLocumVisibility();

    selectEducation = jobData?.education;
    selectCountry = jobData?.location;
    selectHire = jobData?.hiringPeriod;
    selectPositions = jobData?.noOfPeople;
    selectRate = jobData?.rateBilling;
    selectedPayRange = jobData?.payRange;

    // Benefits (if any)
    _selectedBenefits
      ..clear()
      ..addAll(jobData?.offeredBenefits ?? []);

    // Locum dates
    if (jobData?.availabilityDate != null &&
        jobData?.availabilityDate!.length == 2) {
      startLocumDateController.text = jobData?.availabilityDate![0] ?? "";
      endLocumDateController.text = jobData?.availabilityDate![1] ?? "";
      locumDateController.text =
          "${startLocumDateController.text} - ${endLocumDateController.text}";
      //updateLocumSummary();
    }

    notifyListeners();
  }

  // #endregion

  @override
  void dispose() {
    jobTitleController.dispose();
    companyNameController.dispose();
    jobDescController.dispose();
    videoLinkController.dispose();
    websiteController.dispose();
    facebookController.dispose();
    instgramController.dispose();
    linkedInController.dispose();
    locationSearchController.dispose();
    stateController.dispose();
    cityPostCodeController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    locumDateController.dispose();
    startLocumDateController.dispose();
    endLocumDateController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
