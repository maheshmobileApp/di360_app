import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/utils/loader.dart';
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
  }

  // Controllers
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
  final cityPostCodeController = TextEditingController();
  final minSalaryController = TextEditingController();
  final maxSalaryController = TextEditingController();
  final countryController = TextEditingController();

  // NEW: Locum date controller
  final locumDateController = TextEditingController();
  bool showLocumDate = false;

  // Selected dropdown values
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectedPayRange;
  String? selectRate;
  String? selectCountry;
  String? selectEducation;
  String? selecteBenefits;
  String? selectHire;
  String? selectPositions;
  String? selectExperience;
  String? supplierId;
  String? practiceId;
  String? userID;
  String? logoPath;
  dynamic banner_image;

  // Date settings
  bool isStartDateEnabled = false;
  bool isEndDateEnabled = false;
  DateTime? startDate;
  DateTime? endDate;

  // Files
  File? logoFile;
  File? bannerFile;
  File? ClinicPhotofile;

  // Form & PageView
  final GlobalKey<FormState> otherLinksFormKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(6, (_) => GlobalKey<FormState>());

  final List<int> stepsWithValidation = [0, 2, 4];
  final List<String> steps = [
    'Job Info',
    'Logo, etc',
    'Location',
    'Other info',
    'Pay',
    'Links'
  ];
  final PageController pageController = PageController();
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int get totalSteps => steps.length;

  // Static data
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

  // Employment types
  final List<String> _selectedEmploymentChips = [];
  List<String> get selectedEmploymentChips => _selectedEmploymentChips;

  List<JobsRoleList> jobRoles = [];
  List<String> roleOptions = [];

  List<JobTypes> EmpTypes = [];
  List<String> empOptions = [];

  // ───── Navigation Methods ─────
  void goToNextStep() {
    if (!validateCurrentStep()) return;
    if (_currentStep == 1 && bannerFile != null) {
      validateLogoAndBanner();
    }
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

  // ───── Validation Methods ─────
  bool validateCurrentStep() {
    //  if (_currentStep == 1) return validateLogoAndBanner();
    if (_currentStep == 5) return validateOtherLinksStep();
    return formKeys[_currentStep].currentState?.validate() ?? false;
  }

  void validateLogoAndBanner() async {
    var value = await _http.uploadImage(bannerFile?.path);
    banner_image = value['url'];
    print(banner_image);
    notifyListeners();
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
    selecteBenefits = value;
    notifyListeners();
  }

  void setSelectedEducation(String? value) {
    selectEducation = value;
    notifyListeners();
  }

  void setSelectedBenefits(String? value) {
    selectEducation = value;
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
  void toggleLocumDateVisibility(bool value) {
    showLocumDate = value;
    if (!value) locumDateController.clear();
    notifyListeners();
  }

  // ───── Employment Chips ─────
  void addEmploymentTypeChip(String empType) {
    if (!_selectedEmploymentChips.contains(empType)) {
      _selectedEmploymentChips.add(empType);
      toggleLocumDateVisibility(empType == "Locum");
      notifyListeners();
    }
  }

  void removeEmploymentTypeChip(String empType) {
    _selectedEmploymentChips.remove(empType);
    if (empType == "Locum") toggleLocumDateVisibility(false);
    notifyListeners();
  }

  void clearEmploymentTypeChips() {
    _selectedEmploymentChips.clear();
    toggleLocumDateVisibility(false);
    notifyListeners();
  }

  List<String> getSelectedEmploymentTypes() =>
      List.from(_selectedEmploymentChips);

  // ───── File Pickers ─────
  // Future<void> pickLogoImage(ImageSource source) async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: source, imageQuality: 85);
  //   if (pickedFile != null) {
  //     final img = await LocalStorage.getStringVal(LocalStorageConst.profilePic);

  //     logoFile = File(pickedFile.path);
  //     NavigationService().goBack();
  //     notifyListeners();
  //   }
  // }

  Future<void> pickBannerImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      bannerFile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  Future<void> pickClinicPhoto(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      ClinicPhotofile = File(pickedFile.path);
      NavigationService().goBack();
      notifyListeners();
    }
  }

  // ───── Data Fetching ─────
  Future<void> fetchJobRoles() async {
    jobRoles = await repo.getJobRoles();
    roleOptions = jobRoles.map((role) => role.roleName ?? "").toList();
    notifyListeners();
  }

  Future<void> fetchEmpTypes() async {
    EmpTypes = await repo.getEmpTypes();
    empOptions = EmpTypes.map((emp) => emp.employeeTypeName ?? "").toList();
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

  Future<void> createdJobListing(BuildContext context, bool isDraft) async {
    Loaders.circularShowLoader(context);
    final result = await repo.createJobListing({
      "postjobObj": {
        "title": jobTitleController.text,
        "j_type": "",
        "j_role": selectedRole,
        "description": jobDescController.text,
        "TypeofEmployment": selectedEmploymentChips,
        "availability_date": [locumDateController.text],
        "years_of_experience": selectExperience,
        "dental_supplier_id": supplierId,
        "dental_practice_id": practiceId,
        "location": locationSearchController.text,
        "logo": logoPath,
        "state": stateController.text,
        "city": cityPostCodeController.text,
        "salary": "Range",
        "pay_min": minSalaryController.text,
        "pay_max": maxSalaryController.text,
        "company_name": companyNameController.text,
        "pay_range": selectedPayRange,
        "education": selectEducation,
        "video": videoLinkController.text,
        "banner_image": banner_image,
        "clinic_logo": [
          // {
          //   "url":
          //       "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/9c67fdf5-c331-47d3-ae30-24be740056c3",
          //   "type": "image",
          //   "extension": "jpeg"
          // }
        ],
        "closed_at": endDate?.toUtc().toIso8601String(),
        "status": isDraft ? "DRAFT" : "PENDING",
        "active_status": "ACTIVE",
        "website_url": websiteController.text,
        "country": selectCountry,
        "endDateToggle": isEndDateEnabled == true ? "YES" : "NO",
        "offered_benefits": [],
        "hiring_period": selectHire,
        "no_of_people": selectPositions,
        "rate_billing": selectRate,
        "facebook_url": facebookController.text,
        "instagram_url": instgramController.text,
        "linkedin_url": linkedInController.text,
        "timings": startDate?.toUtc().toIso8601String(),
        "timingtoggle": isStartDateEnabled == true ? "YES" : "NO",
        //"auto_expiry_date": null,
        "active_status_feed": isDraft ? null : "PENDING",
        "feed_type": "JOBS"
      }
    });
    if (result != null) {
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

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
    pageController.dispose();
    super.dispose();
  }
}
