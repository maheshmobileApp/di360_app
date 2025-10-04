import 'dart:io';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/header_media_info.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/new_course_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/session_model.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:intl/intl.dart';

class NewCourseViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepository repo = LearningHubRepoImpl();
  final HttpService _http = HttpService();

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
  final meetingLinkController = TextEditingController();
  final termsAndConditionsController = TextEditingController();
  final cancellationController = TextEditingController();
  final websiteController = TextEditingController();
  final rsvpDateController = TextEditingController();
  final earlyBirdDateController = TextEditingController();
  final eventDateController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final addressController = TextEditingController();

  bool showLocumDate = false;

  //server
  String? serverPresentedImg;
  MediaInfo?  serverCourseHeaderBanner;
  List<String>? serverGallery;
  List<String>? serverCourseBannerImg;
  List<String>? serverEventImg;
  List<String>? serverEventImgs;
  List<String>? serverSponsoredByImg;
  List<String>? serverSessionImg;
  //imageFields
  File? selectedPresentedImg;
  File? selectedCourseHeaderBanner;
  List<File>? selectedGallery;
  List<File>? selectedCourseBannerImg;
  List<File>? selectedEventImg;
  List<File>? selectedEventImgs;
  List<File>? selectedsponsoredByImg;
  List<File>? selectedSessionImg;
  dynamic presenter_image;
  List<CourseBannerImage> courseBannerImageHeaderList = [];
  List<CourseBannerImage> selectedGalleryList = [];
  List<CourseBannerImage> courseBannerImgList = [];
  List<Images> eventImgList = [];
  List<CourseBannerImage> sponsoredByImgList = [];
  List<Images>? sessionImgList;
  List<CourseEventInfo> courseInfoList = [];
  List<String> courseTypeNames = [];
  List<String> courseCategory = [];

  String? selectedCategory;
  String? selectedCategoryId;
  String? supplierId;
  String? practiceId;
  String? userID;
  String? logoPath;
  String? selectedEvent = "Single Day";
  String? selectedCourseType;
  List<CourseCategories> courseCategoryList = [];

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

  List<JobsRoleList> category = [];
  List<String> roleOptions = [];

  List<JobTypes> EmpTypes = [];
  List<String> empOptions = [];
//------------------------Set Values-------------------------------
  void setCourseHeaderBaner(File? value) {
    selectedCourseHeaderBanner = value;
    serverCourseHeaderBanner = null;
    notifyListeners();
  }

  void setPresentedImg(File? value) {
    selectedPresentedImg = value;
    serverPresentedImg = null;

    notifyListeners();
  }

  void setGallery(List<File>? value) {
    selectedGallery = value;
    serverGallery = [];
    notifyListeners();
  }

  void setServerGallery(List<String>? value) {
    serverGallery = [];
    notifyListeners();
  }

  void setServerCourseBannerImg(List<String>? value) {
    serverCourseBannerImg = [];
    notifyListeners();
  }

  void setCourseBannerImg(List<File>? value) {
    selectedCourseBannerImg = value;
    serverCourseBannerImg = [];
    notifyListeners();
  }

  void setEventImg(List<File>? value) {
    selectedEventImg = value;
    notifyListeners();
  }

  void setSponsoredBy(List<File>? value) {
    selectedsponsoredByImg = value;
    serverSponsoredByImg = [];
    notifyListeners();
  }

  void setSelectedCourseType(String? value) {
    selectedCourseType = value;
    notifyListeners();
  }

  void setSelectedCourseCategory(String? name) async {
    await fetchCourseCategory();
    selectedCategory = name;

    if (name != null) {
      final match = courseCategoryList.firstWhere(
        (course) => course.name == name,
        orElse: () => CourseCategories(),
      );
      selectedCategoryId = match.id;
    } else {
      selectedCategoryId = null;
    }

    notifyListeners();
  }

  Future<void> setSelectedCourseCategoryName(String? id) async {
    await fetchCourseCategory();
    selectedCategoryId = id;

    if (id != null) {
      final match = courseCategoryList.firstWhere(
        (course) => course.id == id,
        orElse: () => CourseCategories(),
      );
      selectedCategory = match.name;
    } else {
      selectedCategory = null;
    }

    notifyListeners();
  }

  // -------------------Navigation-------------------------
  void goToNextStep() {
    if (!validateCurrentStep()) return;

    // Step-specific validations
    if (_currentStep == 0) {
      validatePresenterImg();
      validateCourseHeaderBanner();
      validateGallery();
      validateCourseBanner();
    } else if (_currentStep == 1) {
      buildCourseInfoList();
    } else if (_currentStep == 2) {
      validateSponsoredByImg();
    }

    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
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

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  // ───── Validation Methods ─────
  bool validateCurrentStep() {
    //  if (_currentStep == 1) return validateLogoAndBanner();
    if (_currentStep == 5) return validateOtherLinksStep();
    return formKeys[_currentStep].currentState?.validate() ?? false;
  }

  Future<void> validatePresenterImg() async {
    if (serverPresentedImg!.isEmpty) {
      var value = await _http.uploadImage(selectedPresentedImg?.path);
      presenter_image = value['url'];
      print(presenter_image);
      notifyListeners();
    } else {
      presenter_image = serverPresentedImg ?? "";
      notifyListeners();
    }
  }

  Future<void> validateCourseHeaderBanner() async {
    // If server already has a header banner, just use it
    if (serverCourseHeaderBanner != null &&
        serverCourseHeaderBanner!.url.isNotEmpty) {
      courseBannerImageHeaderList = [
        CourseBannerImage(
          name: serverCourseHeaderBanner!.url.split('/').last,
          url: serverCourseHeaderBanner?.url,
          type:
              "image", // default as image (you can refine if you know it’s video)
          size: 0, // unknown server-side size
        )
      ];
    } else {
      // Otherwise upload new banner if selected
      if (selectedCourseHeaderBanner == null) return;

      final file = selectedCourseHeaderBanner?.path;
      if (file == null || file.isEmpty) return;

      // detect type from file extension
      final lower = file.toLowerCase();
      final bool isVideo = lower.endsWith(".mp4") ||
          lower.endsWith(".mov") ||
          lower.endsWith(".avi") ||
          lower.endsWith(".mkv") ||
          lower.endsWith(".wmv");

      // Upload via API
      final res = await _http.uploadImage(file);

      courseBannerImageHeaderList = [
        CourseBannerImage(
          name: res['name'],
          url: res['url'],
          type: isVideo ? "video" : "image",
          size: res['size'],
        )
      ];
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

  Future<void> validateGallery() async {
    if (serverGallery != null && serverGallery!.isNotEmpty) {
      // If serverGallery already has values, just map them to CourseBannerImage
      selectedGalleryList = serverGallery!
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
      selectedGalleryList = await uploadFiles(
        selectedGallery,
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

  Future<void> validateCourseBanner() async {
    if (serverCourseBannerImg != null && serverCourseBannerImg!.isNotEmpty) {
      // If serverGallery already has values, just map them to CourseBannerImage
      courseBannerImgList = serverCourseBannerImg!
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
      courseBannerImgList = await uploadFiles(
        selectedCourseBannerImg,
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

  Future<void> validateSponsoredByImg() async {
    if (serverSponsoredByImg != null && serverSponsoredByImg!.isNotEmpty) {
      // If serverGallery already has values, just map them to CourseBannerImage
      sponsoredByImgList = serverSponsoredByImg!
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
      sponsoredByImgList = await uploadFiles(
        selectedsponsoredByImg,
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

  List<SessionModel> sessions = [
    SessionModel(), // Always start with one session
  ];

  /// Change event type
  void setSelectedEvent(String? value) {
    if (value == null) return;
    selectedEvent = value;

    // Reset sessions
    sessions = [SessionModel()];
    notifyListeners();
  }

  /// Add new day/session
  void addNewDay() {
    sessions.add(SessionModel());
    notifyListeners();
  }

  /// Remove a day/session
  void removeDay(int index) {
    if (sessions.length > 1) {
      sessions.removeAt(index);
      notifyListeners();
    }
  }

  /// Set images for a session
  void setEventImgs(int index, List<File>? files) {
    if (index < sessions.length) {
      sessions[index].images = files;
      selectedEventImg = files;
      sessions[index].serverImages = [];

      notifyListeners();
    }
  }

  /// Get session details as plain data (ready for API)
  List<Map<String, dynamic>> getSessionDetails() {
    return sessions.map((session) {
      return {
        "session_name": session.sessionNameController.text,
        "session_info": session.sessionInfoController.text,
        "event_date": session.eventDateController.text,
        "images": session.images?.map((f) => f.path).toList() ?? [],
      };
    }).toList();
  }

  Future<List<CourseEventInfo>> buildCourseInfoList() async {
    courseInfoList.clear(); // in case you call this multiple times

    for (var session in sessions) {
      // Decide whether to reuse serverImages or upload new ones
      final images = session.serverImages.isNotEmpty
          ? session.serverImages
              .map((url) => Images(
                    name: url.split('/').last,
                    url: url,
                    type: "image/jpeg", // adjust if you have type info
                    size: 0, // unknown size for server-side images
                  ))
              .toList()
          : await uploadSessionImages(session.images);

      courseInfoList.add(
        CourseEventInfo(
          date: session.eventDateController.text,
          name: session.sessionNameController.text,
          info: session.sessionInfoController.text,
          images: images,
        ),
      );
    }

    return courseInfoList;
  }

  /// Upload images for a specific session and return uploaded list
  Future<List<Images>> uploadSessionImages(List<File>? files) async {
    if (files == null || files.isEmpty) return [];

    List<Images> uploaded = [];

    for (var file in files) {
      var response = await _http.uploadImage(file.path);

      uploaded.add(
        Images(
          name: file.path.split('/').last,
          url: response['url'],
          type: response['type'] ?? "image/jpeg",
          size: response['size'] ?? file.lengthSync(),
        ),
      );
    }
    return uploaded;
  }

  bool validateOtherLinksStep() {
    return otherLinksFormKey.currentState?.validate() ?? false;
  }

  //--------------------------API Calls------------------------
  Future<void> fetchCourseCategory() async {
    final result = await repo.getCourseCategory();
    courseCategoryList = result.courseCategories ?? [];
    courseCategoryList.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
    courseCategory = courseCategoryList.map((e) => e.name ?? "").toList();
    notifyListeners();
  }

  Future<void> fetchCourseType() async {
    final result = await repo.getCourseType();
    courseTypeNames =
        result.courseType?.map((e) => e.name ?? "").toList() ?? [];
    notifyListeners();
  }

  Future<void> createdCourseListing(BuildContext context, bool isDraft) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    String? rsvpDate = rsvpDateController.text.isEmpty
        ? null
        : DateFormat("yyyy-MM-dd").format(
            DateFormat("d/M/yyyy").parse(rsvpDateController.text),
          );
    String? startDate = startDateController.text.isEmpty
        ? null
        : DateFormat("yyyy-MM-dd").format(
            DateFormat("d/M/yyyy").parse(startDateController.text),
          );

    String? endDate = endDateController.text.isEmpty
        ? null
        : DateFormat("yyyy-MM-dd").format(
            DateFormat("d/M/yyyy").parse(endDateController.text),
          );

    Loaders.circularShowLoader(context);
    final result = await repo.createCourseListing({
      "object": CourseObject(
              courseName: courseNameController.text,
              courseCategoryId: selectedCategoryId,
              rsvpDate: rsvpDate,
              presentedByName: presenterNameController.text,
              presentedByImage: PresentedByImage(url: presenter_image),
              courseBannerImage: courseBannerImgList,
              courseGallery: selectedGalleryList,
              courseBannerVideo: courseBannerImageHeaderList,
              description: courseDescController.text,
              cpdPoints: (cpdPointsController.text.isEmpty)
                  ? null
                  : double.parse(cpdPointsController.text),
              numberOfSeats: (numberOfSeatsController.text.isEmpty)
                  ? null
                  : int.parse(numberOfSeatsController.text),
              priceInAud: 0,
              priceInUsd: 0,
              earlyBirdPrice: (birdPriceController.text.isEmpty)
                  ? null
                  : int.parse(birdPriceController.text),
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
              contactWebsite: websiteUrlController.text,
              afterwardsPrice: (totalPriceController.text.isEmpty)
                  ? null
                  : int.parse(totalPriceController.text),
              registerLink: registerLinkController.text,
              userRole: type,
              startDate: startDate,
              endDate: endDate,
              isFeatured: false,
              activeStatus: "ACTIVE",
              address: addressController.text,
              maxSubscribers: 1000,
              createdById: userId,
              companyName: name,
              status: isDraft ? "DRAFT" : "PENDING",
              type: (selectedCourseType == null) ? "" : selectedCourseType,
              feedType: "LEARNHUB",
              startTime: startTimeController.text,
              endTime: endTimeController.text)
          .toJson(),
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

  Future<void> updateCourseListing(
      BuildContext context, String? courseId, bool isDraft) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final name = await LocalStorage.getStringVal(LocalStorageConst.name);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);

    Loaders.circularShowLoader(context);
    final result = await repo.updateCourseListing({
      "id": courseId,
      "changes": CourseObject(
              courseName: courseNameController.text,
              courseCategoryId: selectedCategoryId,
              rsvpDate: rsvpDateController.text,
              presentedByName: presenterNameController.text,
              presentedByImage: serverPresentedImg!.isNotEmpty
                  ? PresentedByImage(url: serverPresentedImg)
                  : PresentedByImage(url: presenter_image),
              courseBannerImage: courseBannerImgList,
              courseGallery: selectedGalleryList,
              courseBannerVideo: courseBannerImageHeaderList,
              description: courseDescController.text,
              cpdPoints: (cpdPointsController.text.isEmpty)
                  ? null
                  : double.parse(cpdPointsController.text),
              numberOfSeats: (numberOfSeatsController.text.isEmpty)
                  ? null
                  : int.parse(numberOfSeatsController.text),
              priceInAud: 0,
              priceInUsd: 0,
              earlyBirdPrice: (birdPriceController.text.isEmpty)
                  ? null
                  : int.parse(birdPriceController.text),
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
              contactWebsite: websiteUrlController.text,
              afterwardsPrice: (totalPriceController.text.isEmpty)
                  ? null
                  : int.parse(totalPriceController.text),
              registerLink: registerLinkController.text,
              userRole: type,
              startDate: startDateController.text,
              endDate: endDateController.text,
              isFeatured: false,
              activeStatus: "ACTIVE",
              address: addressController.text,
              maxSubscribers: 1000,
              createdById: userId,
              companyName: name,
              status: isDraft ? "DRAFT" : "PENDING",
              type: (selectedCourseType == null) ? "" : selectedCourseType,
              feedType: "LEARNHUB",
              startTime: startTimeController.text,
              endTime: endTimeController.text)
          .toJson(),
    });

    if (result != null) {
      scaffoldMessenger("Course is updated Successfully");
      navigationService.goBack();

      Loaders.circularHideLoader(context);
      //resetForm();
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
    selectedCategory = null;
    selectedCourseType = null;
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
    startDateController.text = "";
    endDateController.text = "";
    addressController.text = "";
    courseInfoList = [];
    startTimeController.text = "";
    endTimeController.text = "";
    sessions = [];
    selectedEvent = "Single Day";
  }

  void serverImagesClear() {
    serverPresentedImg = "";
    serverCourseHeaderBanner = null;
    serverGallery = [];
    serverCourseBannerImg = [];
    serverEventImg = [];
    serverEventImgs = [];
    serverSponsoredByImg = [];
    serverSessionImg = [];
    for (var session in sessions) {
      session.serverImages.clear();
    }
  }

  void eraseDateFields() {
    startTimeController.text = "";
    endTimeController.text = "";
    rsvpDateController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    earlyBirdDateController.text = "";
    for (var session in sessions) {
      session.eventDateController.text = "";
    }
  }
}
