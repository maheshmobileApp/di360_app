import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart'
    hide CourseRegisteredUsers;
import 'package:di360_flutter/feature/learning_hub/model_class/get_register_user_tab_count_res.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CourseListingViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepoImpl repo = LearningHubRepoImpl();
  
  List<CoursesListingDetails> coursesListingList = [];
  List<CoursesListingDetails> marketPlaceCoursesList = [];
  RegisteredUsersData? registeredUsers;
  String selectedStatus = "All";
  String selectedRegUsersStatus = "All";
  final searchController = TextEditingController();
  bool searchBarOpen = false;
  bool editOptionEnable = false;
  String? courseId;

  String? selectedCategory;
  List<CourseCategories> courseCategoryList = [];
  String? selectedCategoryId;
  

  String? currentUserId;  

  int _courseListingLimit = 10;
  int _courseListingOffset = 0;
  bool isLoadingMoreCourses = false;
  bool hasMoreCourses = true;

  String courseStatus = "";

  void setCourseStatus(String value) {
    courseStatus = value;
    notifyListeners();
  }

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  void setCourseId(String value) {
    courseId = value;
    notifyListeners();
  }

  void setEditOption(bool value) {
    editOptionEnable = value;
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
          .sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
      isLoadingMoreCourses = false;
    } else {
      coursesListingList = res ?? [];
      coursesListingList
          .sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
    }

    hasMoreCourses = (res?.length ?? 0) >= _courseListingLimit;
    _courseListingOffset += res?.length ?? 0;
    Loaders.circularHideLoader(context);
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

  Future<void> deleteCourse(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);

    final res = await repo.deleteCourse(courseId);
    if (res != null) {
      getCoursesListingData(context);
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
      // coursesListingList = res;
      // marketPlaceCoursesList = res;
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

}
