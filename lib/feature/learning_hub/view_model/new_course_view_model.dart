import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repo_impl.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/new_course_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/post_course_request.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/session_day.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repository.dart';
import 'package:di360_flutter/services/navigation_services.dart';

class NewCourseViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepository repo = LearningHubRepoImpl();
  final HttpService _http = HttpService();

  NewCourseViewModel() {
    getUserId();
    fetchCategory();
    fetchEmpTypes();
  }

  //newly added
  final courseNameController = TextEditingController();
  final presenterNameController = TextEditingController();
  final cpdPointsController = TextEditingController();
  final numberOfSeatsController = TextEditingController();
  final totalPriceController = TextEditingController();
  final birdPriceController = TextEditingController();
  final courseDescController = TextEditingController();
  final topicsIncludedDescController = TextEditingController();
  final learningObjectivesDescController = TextEditingController();
  final day1SessionNameController = TextEditingController();
  final sessioInfoController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteUrlController = TextEditingController();
  final registerLinkController = TextEditingController();
  final termsAndConditionsController = TextEditingController();
  final cancellationController = TextEditingController();

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
  //final locumDateController = TextEditingController();
  final rsvpDateController = TextEditingController();
  final earlyBirdDateController = TextEditingController();
  bool showLocumDate = false;

  //imageFields
  File? selectedPresentedImg;
  List<File>? selectedCourseHeaderBanner;
  List<File>? selectedGallery;
  List<File>? selectedCourseBannerImg;
  List<File>? selectedEventImg;
  List<File>? selectedEventImgs;
  List<File>? selectedsponsoredByImg;
  dynamic presenter_image;

  List<CourseBannerImage> courseBannerImageHeaderList = [];
  List<CourseGallery> selectedGalleryList = [];
  List<CourseBannerVideo> courseBannerImgList = [];
  List<Images> eventImgList = [];
  List<SponsorByImage> sponsoredByImgList = [];

  List<CourseEventInfo> courseInfoList = [];

  void setCourseHeaderBaner(List<File>? value) {
    selectedCourseHeaderBanner = value;
    notifyListeners();
  }

  void setPresentedImg(File? value) {
    selectedPresentedImg = value;
    notifyListeners();
  }

  void setGallery(List<File>? value) {
    selectedGallery = value;
    notifyListeners();
  }

  void setCourseBannerImg(List<File>? value) {
    selectedCourseBannerImg = value;
    notifyListeners();
  }

  void setEventImg(List<File>? value) {
    selectedEventImg = value;
    notifyListeners();
  }

  void setSponsoredBy(List<File>? value) {
    selectedsponsoredByImg = value;
    notifyListeners();
  }

  // Selected dropdown values
  String? selectedCategory;
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
  String? selectedEvent;

  // Date settings
  bool isStartDateEnabled = false;
  bool isEndDateEnabled = false;
  DateTime? startDate;
  DateTime? endDate;

  // Files
  File? logoFile;
  //File? bannerFile;
  File? ClinicPhotofile;

  List<SessionDay> days = [SessionDay()];

  void addNewDay() {
    days.add(SessionDay());
    notifyListeners();
  }

  void removeDay(int index) {
    days[index].dispose();
    days.removeAt(index);
    notifyListeners();
  }

  void setEventImgs(int dayIndex, List<File> files) {
    selectedEventImgs = files;
    notifyListeners();
  }

  void disposeControllers() {
    for (var day in days) {
      day.dispose();
    }
  }

  void setSelectedEvent(String value) {
    selectedEvent = value;
    notifyListeners();
  }

  // Form & PageView
  final GlobalKey<FormState> otherLinksFormKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> formKeys =
      List.generate(6, (_) => GlobalKey<FormState>());

  final List<int> stepsWithValidation = [0, 2, 4];
  final List<String> steps = [
    'Add Course',
    'Course Info',
    'Terms & Conditions',
    'Contacts'
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
    if (_currentStep == 0 && selectedPresentedImg != null) {
      validatePresenterImg();
    } else if (_currentStep == 0 && selectedCourseHeaderBanner != null) {
      validateCourseHeaderBanner();
    } else if (_currentStep == 0 && selectedGallery != null) {
      validateGallery();
    } else if (_currentStep == 0 && selectedCourseBannerImg != null) {
      validateCourseBanner();
    } else if (_currentStep == 1 && selectedEventImg != null) {
      validateEventImgList();
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

  void validatePresenterImg() async {
    var value = await _http.uploadImage(selectedPresentedImg?.path);
    presenter_image = value['url'];
    print(presenter_image);
    notifyListeners();
  }

  Future<void> validateCourseHeaderBanner() async {
    if (selectedCourseHeaderBanner == null ||
        selectedCourseHeaderBanner!.isEmpty) return;

    courseBannerImageHeaderList.clear(); // reset before uploading new ones

    for (var file in selectedCourseHeaderBanner!) {
      // Upload image
      var response = await _http.uploadImage(file.path);

      // Assuming API response: { "url": "...", "type": "...", "size": ... }
      String url = response['url'];
      String type = response['type'] ?? "image/jpeg";
      int size = response['size'] ?? file.lengthSync();

      // Add to list
      courseBannerImageHeaderList.add(
        CourseBannerImage(
          name: file.path.split('/').last, // file name
          url: url,
          type: type,
          size: size,
        ),
      );
    }

    print(courseBannerImageHeaderList.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> validateGallery() async {
    if (selectedGallery == null || selectedGallery!.isEmpty) return;

    selectedGalleryList.clear(); // reset before uploading new ones

    for (var file in selectedGallery!) {
      // Upload image
      var response = await _http.uploadImage(file.path);

      // Assuming API response: { "url": "...", "type": "...", "size": ... }
      String url = response['url'];
      String type = response['type'] ?? "image/jpeg";
      int size = response['size'] ?? file.lengthSync();

      // Add to list
      selectedGalleryList.add(
        CourseGallery(
          name: file.path.split('/').last, // file name
          url: url,
          type: type,
          size: size,
        ),
      );
    }

    print(selectedGalleryList.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> validateCourseBanner() async {
    if (selectedCourseBannerImg == null || selectedCourseBannerImg!.isEmpty)
      return;

    courseBannerImgList.clear(); // reset before uploading new ones

    for (var file in selectedCourseBannerImg!) {
      // Upload image
      var response = await _http.uploadImage(file.path);

      // Assuming API response: { "url": "...", "type": "...", "size": ... }
      String url = response['url'];
      String type = response['type'] ?? "image/jpeg";
      int size = response['size'] ?? file.lengthSync();

      // Add to list
      courseBannerImgList.add(
        CourseBannerVideo(
          name: file.path.split('/').last, // file name
          url: url,
          type: type,
          size: size,
        ),
      );
    }

    print(courseBannerImgList.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> validateEventImgList() async {
    if (selectedEventImg == null || selectedEventImg!.isEmpty) return;

    eventImgList.clear(); // reset before uploading new ones

    for (var file in selectedEventImg!) {
      // Upload image
      var response = await _http.uploadImage(file.path);

      // Assuming API response: { "url": "...", "type": "...", "size": ... }
      String url = response['url'];
      String type = response['type'] ?? "image/jpeg";
      int size = response['size'] ?? file.lengthSync();

      // Add to list
      eventImgList.add(
        Images(
          name: file.path.split('/').last, // file name
          url: url,
          type: type,
          size: size,
        ),
      );
    }

    print(eventImgList.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  Future<void> validateSponsoredByImg() async {
    if (selectedsponsoredByImg == null || selectedsponsoredByImg!.isEmpty)
      return;

    sponsoredByImgList.clear(); // reset before uploading new ones

    for (var file in selectedsponsoredByImg!) {
      // Upload image
      var response = await _http.uploadImage(file.path);

      // Assuming API response: { "url": "...", "type": "...", "size": ... }
      String url = response['url'];
      String type = response['type'] ?? "image/jpeg";
      int size = response['size'] ?? file.lengthSync();

      // Add to list
      sponsoredByImgList.add(
        SponsorByImage(
          name: file.path.split('/').last, // file name
          url: url,
          type: type,
          size: size,
        ),
      );
    }

    print(sponsoredByImgList.map((e) => e.toJson()).toList());
    notifyListeners();
  }

  void buildCourseInfoList() {
    courseInfoList.clear();

    if (selectedEvent == "Single Day") {
      courseInfoList.add(
        CourseEventInfo(
          date: "",
          name: day1SessionNameController.text,
          info: sessioInfoController.text,
          images: eventImgList,
        ),
      );
    } else if (selectedEvent == "Multiple Day") {
      for (var day in days) {
        courseInfoList.add(
          CourseEventInfo(
            date: "",
            name: day.sessionNameController.text,
            info: day.sessionInfoController.text,
            images: eventImgList,
          ),
        );
      }
    }
  }

  bool validateOtherLinksStep() {
    return otherLinksFormKey.currentState?.validate() ?? false;
  }

  // ───── Dropdown setters ─────
  void setSelectedCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  // ───── Data Fetching ─────
  Future<void> fetchCategory() async {
    jobRoles = await repo.getCategory();
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

  Future<void> createdCourseListing(BuildContext context, bool isDraft) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);
    final result = await repo.createCourseListing({
      "object": CourseObject(
        courseName: courseNameController.text,
        courseCategoryId: "93de7602-d5ca-4f94-b4ca-eaeb003479c7",
        rsvpDate: rsvpDateController.text,
        presentedByName: presenterNameController.text,
        presentedByImage: PresentedByImage(url: presenter_image),
        courseBannerImage: courseBannerImageHeaderList,
        courseGallery: selectedGalleryList,
        courseBannerVideo: courseBannerImgList,
        description: courseDescController.text,
        cpdPoints: double.parse(cpdPointsController.text),
        numberOfSeats: int.parse(numberOfSeatsController.text),
        priceInAud: int.parse(totalPriceController.text),
        priceInUsd: int.parse(birdPriceController.text),
        earlyBirdPrice: int.parse(birdPriceController.text),
        earlyBirdEndDate: earlyBirdDateController.text,
        topicsIncluded: topicsIncludedDescController.text,
        learningObjectives: learningObjectivesDescController.text,
        eventType: selectedEvent,
        courseEventInfo: courseInfoList,
        sponsorByImage: sponsoredByImgList,
        terms: termsAndConditionsController.text,
        refundPolicy: cancellationController.text,
        contactName: nameController.text,
        contactEmail: emailController.text,
        contactPhone: phoneController.text,
        contactWebsite: websiteController.text,
        afterwardsPrice: 0,
        registerLink: registerLinkController.text,
        activeStatusFeed: "",
        userRole: "SUPPLIER",
        startDate: "2025-09-12",
        endDate: "2025-09-26",
        image:
            "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/course/sample-image.jpg",
        video:
            "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/course/sample-video.mp4",
        completeDetails: "Full details about the course...",
        attachments: Attachments(name: "foo"),
        isFeatured: false,
        activeStatus: "PENDING",
        address: "42 Marine Parade, Southport QLD 4215, Australia",
        scheduledAt: "2025-09-15T02:31:20.225Z",
        maxSubscribers: 1000,
        seoMetadata: SeoMetadata(keywords: ["dental", "medicine"]),
        webinarLink: "https://zoom.us/j/123456789",
        createdById: userId,
        companyName: "Texting ",
        status: isDraft ? "DRAFT" : "PENDING",
        type: "Event",
        feedType: "LEARNHUB",
        startTime: "02:31:20Z",
        shortId: "CSE-1001",
        shortInfo: "Basics of Dental Medicine",
      ).toJson(),
    });

    if (result != null) {
      scaffoldMessenger("Course is successfully added");
      navigationService.goBack();

      Loaders.circularHideLoader(context);
      resetForm();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  void resetForm() {
    // Reset dropdowns & selections

    selectedPresentedImg = null;
    selectedCourseHeaderBanner = null;
    selectedGallery = null;
    selectedCourseBannerImg = null;
    selectedEventImg = null;
    selectedsponsoredByImg = null;

    // Clear all controllers (set to empty string)
    courseNameController.text = "";
    presenterNameController.text = "";
    cpdPointsController.text = "";
    numberOfSeatsController.text = "";
    totalPriceController.text = "";
    birdPriceController.text = "";
    courseDescController.text = "";
    topicsIncludedDescController.text = "";
    learningObjectivesDescController.text = "";
    day1SessionNameController.text = "";
    sessioInfoController.text = "";
    nameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    websiteUrlController.text = "";
    registerLinkController.text = "";
    termsAndConditionsController.text = "";
    cancellationController.text = "";
    rsvpDateController.text = "";
    _currentStep = 0;
    earlyBirdDateController.text = "";
    sessioInfoController.text = "";
    day1SessionNameController.text = "";
    courseInfoList = [];

    // Page controller reset
    pageController.jumpToPage(
        0); // or pageController.animateToPage(...) if you want animation
  }
}
