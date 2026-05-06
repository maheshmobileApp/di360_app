import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart'
    hide CourseRegisteredUsers;
import 'package:di360_flutter/feature/learning_hub/model_class/get_register_user_tab_count_res.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CourseListingViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepoImpl repo = LearningHubRepoImpl();

  List<CoursesListingDetails> coursesListingList = [];
  List<CoursesListingDetails> marketPlaceCoursesList = [];
  CoursesByPk? courseDetails;
  RegisteredUsersData? registeredUsers;
  String selectedStatus = "All";
  String selectedRegUsersStatus = "All";
  final searchController = TextEditingController();
  bool searchBarOpen = false;
  String? courseId;
  String? selectedCategory;
  List<CourseCategories> courseCategoryList = [];
  String? selectedCategoryId;
  bool editOptionEnable = false;
  bool courseRegistered = false;

  String? currentUserId;

  int currentModuleIndex = 0;
  int currentSectionIndex = 0;

  void nextModule() {
    final total =
        courseDetails?.courseRegisteredUsers?.first.moduleSection?.length ?? 0;
    if (currentModuleIndex < total - 1) {
      currentModuleIndex++;
      currentSectionIndex = 0;
      notifyListeners();
    }
  }

  void previousModule() {
    if (currentModuleIndex > 0) {
      currentModuleIndex--;
      currentSectionIndex = 0;
      notifyListeners();
    }
  }

  void nextSection() {
    final sections =
        courseDetails?.moduleSection?[currentModuleIndex].sectionList;
    if (currentSectionIndex < (sections?.length ?? 1) - 1) {
      currentSectionIndex++;
      notifyListeners();
    }
  }

  void previousSection() {
    if (currentSectionIndex > 0) {
      currentSectionIndex--;
      notifyListeners();
    }
  }

  // Quiz
  int currentQuizIndex = 0;
  int? selectedSingleAnswer;
  Set<int> selectedMultipleAnswers = {};

  void nextQuiz() {
    final total = courseDetails?.questionSection?.length ?? 0;
    if (currentQuizIndex < total - 1) {
      currentQuizIndex++;
      _clearQuizSelection();
      notifyListeners();
    }
  }

  void previousQuiz() {
    if (currentQuizIndex > 0) {
      currentQuizIndex--;
      _clearQuizSelection();
      notifyListeners();
    }
  }

  void selectSingleAnswer(int index) {
    if (areAllSectionsCompleted() == false) {
      scaffoldMessenger("Please complete all modules before taking the quiz.");
      return;
    }
    selectedSingleAnswer = index;
    notifyListeners();
  }

  void toggleMultipleAnswer(int index) {
    if (areAllSectionsCompleted() == false) {
      scaffoldMessenger("Please complete all modules before taking the quiz.");
      return;
    }
    if (selectedMultipleAnswers.contains(index)) {
      selectedMultipleAnswers.remove(index);
    } else {
      selectedMultipleAnswers.add(index);
    }
    notifyListeners();
  }

  void _clearQuizSelection() {
    selectedSingleAnswer = null;
    selectedMultipleAnswers = {};
  }

  int _courseListingLimit = 10;
  int _courseListingOffset = 0;
  bool isLoadingMoreCourses = false;
  bool hasMoreCourses = true;

  final int _marketPlaceLimit = 10;
  int _marketPlaceOffset = 0;
  bool isLoadingMoreMarketPlace = false;
  bool hasMoreMarketPlace = true;

  /********************************** */
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userPhoneNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final userDescriptionController = TextEditingController();

  String? validateEmailField(String? _) =>
      validateEmail(userEmailController.text);
  String? validatePhoneNum(String? _) =>
      validatePhoneNumber(userPhoneNumberController.text);

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  void setEditOption(bool value) {
    editOptionEnable = value;
    notifyListeners();
  }

  String courseStatus = "";

  void setCourseStatus(String value) {
    courseStatus = value;
    notifyListeners();
  }

  void setCourseId(String value) {
    courseId = value;
    notifyListeners();
  }

  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Active',
    'InActive',
    'Expired',
    'Reject',
  ];

  final List<String> regUserStatus = [
    'All',
    'Pending',
    'Approved',
    'Completed',
    'Cancelled'
  ];

  String? listingRegUsersStatus = "";
  String? activeRegUsersStatus = "";

  void changeRegUsersStatus(
      String status, BuildContext context, String courseId) {
    selectedRegUsersStatus = status;
    if (status == 'All') {
      listingRegUsersStatus = "";
    } else if (status == 'Pending') {
      listingRegUsersStatus = 'PENDING';
    } else if (status == 'Approved') {
      listingRegUsersStatus = 'APPROVED';
    } else if (status == 'Completed') {
      listingRegUsersStatus = 'COMPLETED';
    } else if (status == 'Cancelled') {
      listingRegUsersStatus = 'CANCELLED';
    }
    //
    getCourseRegisteredUsers(context, courseId);

    notifyListeners();
  }

  String? listingStatus = "";
  String? activeStatus = "";

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      listingStatus = "All";
      activeStatus = "";
    } else if (status == 'Draft') {
      listingStatus = 'DRAFT';
      activeStatus = "";
    } else if (status == 'Pending Approval') {
      listingStatus = 'PENDING';
      activeStatus = "";
    } else if (status == 'Active') {
      listingStatus = "APPROVE";
      activeStatus = "ACTIVE";
    } else if (status == 'InActive') {
      listingStatus = 'APPROVE';
      activeStatus = "INACTIVE";
    } else if (status == 'Expired') {
      listingStatus = 'EXPIRED';
      activeStatus = "";
    } else if (status == 'Reject') {
      listingStatus = 'REJECT';
      activeStatus = "";
    }

    getCoursesListingData(context);
    notifyListeners();
    //INACTIVE
  }

  int? allJobTalentCount = 0;
  int? draftTalentCount = 0;
  int? pendingApprovalCount = 0;
  int? activeCount = 0;
  int? inActiveCount = 0;
  int? expiredStatusCount = 0;
  int? rejectStatusCount = 0;
  /**************** */
  int? allRegUsersCount = 0;
  int? pendingRegUsersCount = 0;
  int? approvedRegUsersCount = 0;
  int? completedRegUsersCount = 0;
  int? cancelledRegUsersCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': allJobTalentCount,
        'Draft': draftTalentCount,
        'Pending Approval': pendingApprovalCount,
        'Active': activeCount,
        'InActive': inActiveCount,
        'Expired': expiredStatusCount,
        'Reject': rejectStatusCount,
      };

  Map<String, int?> get statusRegUsersCountMap => {
        'All': allRegUsersCount,
        'Pending': pendingRegUsersCount,
        'Approved': approvedRegUsersCount,
        'Completed': completedRegUsersCount,
        'Cancelled': cancelledRegUsersCount,
      };

  Future<void> getCoursesListingData(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMoreCourses || !hasMoreCourses) return;
      isLoadingMoreCourses = true;
    } else {
      Loaders.circularShowLoader(context);
      _courseListingOffset = 0;
      hasMoreCourses = true;
    }

    notifyListeners();

    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getCoursesListing(
        listingStatus,
        activeStatus,
        userId,
        searchController.text,
        _courseListingLimit,
        _courseListingOffset);

    if (!loadMore) {
      await fetchCourseStatusCounts(context);
    }

    if (loadMore) {
      coursesListingList.addAll(res ?? []);
      coursesListingList
          .sort((a, b) => (b.updatedAt ?? '').compareTo(a.updatedAt ?? ''));
      isLoadingMoreCourses = false;
    } else {
      coursesListingList = res ?? [];
      coursesListingList
          .sort((a, b) => (b.updatedAt ?? '').compareTo(a.updatedAt ?? ''));
    }

    hasMoreCourses = (res?.length ?? 0) >= _courseListingLimit;
    _courseListingOffset += res?.length ?? 0;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getAllLearningHubData(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMoreMarketPlace || !hasMoreMarketPlace) return;
      isLoadingMoreMarketPlace = true;
    } else {
      currentUserId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      _marketPlaceOffset = 0;
      hasMoreMarketPlace = true;
    }
    notifyListeners();

    final res = await repo.getMarketPlaceLearningHubData(
        _marketPlaceLimit, _marketPlaceOffset);

    if (loadMore) {
      marketPlaceCoursesList.addAll(res ?? []);
      isLoadingMoreMarketPlace = false;
    } else {
      marketPlaceCoursesList = res ?? [];
    }

    hasMoreMarketPlace = (res?.length ?? 0) >= _marketPlaceLimit;
    _marketPlaceOffset += res?.length ?? 0;
    notifyListeners();
  }

  Future<void> fetchCourseStatusCounts(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.courseListingStatusCount(userId);
    allJobTalentCount = res.all?.aggregate?.count ?? 0;
    activeCount = res.active?.aggregate?.count ?? 0;
    inActiveCount = res.inactive?.aggregate?.count ?? 0;
    pendingApprovalCount = res.pending?.aggregate?.count ?? 0;
    draftTalentCount = res.draft?.aggregate?.count ?? 0;
    rejectStatusCount = res.rejected?.aggregate?.count ?? 0;
    expiredStatusCount = res.expired?.aggregate?.count ?? 0;
    notifyListeners();
  }

  Future<void> getCourseDetails(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getCourseDetails(courseId);
    if (res != null) {
      courseDetails = res;
      currentModuleIndex = 0;
      currentSectionIndex = 0;
      currentQuizIndex = 0;
      _clearQuizSelection();
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }
// Registered Users

  Future<void> getCourseRegisteredUsers(
      BuildContext context, String courseId) async {
    if (courseId.isEmpty) return;
    Loaders.circularShowLoader(context);
    final res = await repo.getCourseRegisteredUsers(
        courseId, listingRegUsersStatus ?? "");
    registeredUsers = res;
    await getCourseRegisteredUsersTabCount(context, courseId);
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> updateRegUserStatus(BuildContext context, String regUserId,
      String status, String courseId) async {
    if (courseId.isEmpty) return;
    Loaders.circularShowLoader(context);
    final variables = {
      "id": regUserId,
      "fields": {"webinar_status": status, "status": status}
    };
    final res = await repo.updateRegUserStatus(variables);
    if (res != null) {
      await getCourseRegisteredUsers(context, courseId);
      scaffoldMessenger("Status Updated Successfully");
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  RegisterUserTabCountData? registerUserTabCount;
  Future<void> getCourseRegisteredUsersTabCount(
      BuildContext context, String courseId) async {
    if (courseId.isEmpty) return;
    final variables = {
      "where": {
        "course_id": {"_eq": courseId}
      }
    };
    final res = await repo.getRegisterUserTabCountData(variables);
    if (res != "") {
      registerUserTabCount = res;
      allRegUsersCount = registerUserTabCount?.all?.aggregate?.count ?? 0;
      pendingRegUsersCount =
          registerUserTabCount?.pending?.aggregate?.count ?? 0;
      approvedRegUsersCount =
          registerUserTabCount?.approved?.aggregate?.count ?? 0;
      completedRegUsersCount =
          registerUserTabCount?.completed?.aggregate?.count ?? 0;
      cancelledRegUsersCount =
          registerUserTabCount?.cancelled?.aggregate?.count ?? 0;
    }
    notifyListeners();
  }

  Future<void> registerCourseHandler(
    BuildContext context,
    String createdById,
  ) async {
    final isAlreadyRegistered = registeredUsers?.courseRegisteredUsers?.any(
      (user) => user.fromId == createdById,
    );

    validateRegisterCourse(isAlreadyRegistered ?? false);
  }

  void validateRegisterCourse(bool value) {
    courseRegistered = value;
    notifyListeners();
  }

  Future<void> deleteCourse(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);

    final res = await repo.deleteCourse(courseId);
    if (res != null) {
      getCoursesListingData(context);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> userRegisterToCourse(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);

    final res = await repo.userRegisterToCourse({
      "fields": {
        "course_id": courseId,
        "from_id": userId,
        "type": "SUPPLIER",
        "first_name": userFirstNameController.text,
        "last_name": userLastNameController.text,
        "phone_number": userPhoneNumberController.text,
        "email": userEmailController.text,
        "description": userDescriptionController.text,
        "status": "PENDING",
        "quiz_status": "PENDING",
        "module_section":
            courseDetails?.moduleSection?.map((e) => e.toJson()).toList(),
        "question_section":
            courseDetails?.questionSection?.map((e) => e.toJson()).toList()
      }
    });
    if (res != null) {
      scaffoldMessenger(
        "Successfully Submitted!\nThank you for your interest.\nOur organiser will be in touch with you soon.",
      );
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getMarketPlaceCoursesWithFilters(
      BuildContext context,
      String type,
      String courseCategoryId,
      String startDate,
      String address) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getMarketPlaceCoursesWithFilters(
        type, courseCategoryId, startDate, address);

    if (res != null) {
      coursesListingList = res;
      marketPlaceCoursesList = res;
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  void setSelectedCourseCategory(String? name) {
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

  Future<void> updateCourseStatus(
      BuildContext context, String courseId, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.updateCourseStatus(courseId, status);
    if (res != null) {
      getCoursesListingData(context);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  bool isRegisteredCheck(List<CourseRegisteredUsers>? courseRegisteredUsers) {
    return courseRegisteredUsers?.any((user) => user.fromId == currentUserId) ??
        false;
  }

  bool isCourseDetailRegisteredCheck(
      List<CourseDetailRegisteredUsers>? courseRegisteredUsers) {
    return courseRegisteredUsers?.any((user) => user.fromId == currentUserId) ??
        false;
  }

  Future<void> completeAndContinue(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final regUser = courseDetails?.courseRegisteredUsers?.firstOrNull;
    if (regUser?.id == null || regUser?.moduleSection == null) return;

    final section = regUser!
        .moduleSection![currentModuleIndex].sectionList?[currentSectionIndex];
    if (section == null || section.status == 'Completed') return;

    // Update locally first
    section.status = 'Completed';
    notifyListeners();

    // Build payload from the typed model (status is already updated)
    final moduleSectionPayload = regUser.moduleSection!
        .asMap()
        .entries
        .map((entry) => {
              "expanded":
                  entry.key == currentModuleIndex ? true : entry.value.expanded,
              "id": entry.value.id,
              "module_name": entry.value.moduleName,
              "section_list": (entry.value.sectionList ?? [])
                  .map((s) => {
                        "attachment": s.attachment,
                        "course_topic": s.courseTopic,
                        "description": s.description,
                        "expanded": s.expanded,
                        "id": s.id,
                        "image": s.image,
                        "status": s.status,
                        "youtube_link": s.youtubeLink,
                      })
                  .toList(),
            })
        .toList();

    final res = await repo.updatedTheCourseCompletedStatus({
      "id": regUser.id,
      "fields": {"module_section": moduleSectionPayload},
    });

    if (res['insert_course_registered_users_one'] != null) {
      final sections =
          regUser.moduleSection![currentModuleIndex].sectionList ?? [];
      final totalModules = regUser.moduleSection!.length;

      if (currentSectionIndex < sections.length - 1) {
        currentSectionIndex++;
      } else if (currentModuleIndex < totalModules - 1) {
        currentModuleIndex++;
        currentSectionIndex = 0;
      }
      if (areAllSectionsCompleted()) {
        scaffoldMessenger("Congratulations! You have completed the course.");
      }
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  bool areAllSectionsCompleted() {
    final modules =
        courseDetails?.courseRegisteredUsers?.firstOrNull?.moduleSection;
    if (modules == null || modules.isEmpty) return false;
    return modules.every((module) =>
        (module.sectionList ?? []).every((s) => s.status == 'Completed'));
  }

  clearAll() {
    userFirstNameController.text = "";
    userLastNameController.text = "";
    userEmailController.text = "";
    userPhoneNumberController.text = "";
    userDescriptionController.text = "";
  }
}
