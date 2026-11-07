import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_by_id.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_promotions_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart'
    hide CourseRegisteredUsers;
import 'package:di360_flutter/feature/learning_hub/model_class/get_notification_campaign_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_register_user_tab_count_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_transaction_detail_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_transactions_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/notification_campaign_detail_res.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/promotion_detail_res.dart';
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
  String? selectedModuleType = "Course Details";
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
  String? userType;

  NotificationCampaignData? notificationCampaignData;
  CoursePromotionData? coursePromotionData;
  CourseByIdData? courseData;
  NotificationCampaignDetailsData? notificationCampaignDetailData;
  PromotionDetailData? promotionDetailData;
  GetTransactionsRes? getTransactionsRes;
  GetTransactionDetailRes? getTransactionDetailRes;

  // Notification pagination
  final int _notifLimit = 10;
  int _notifOffset = 0;
  bool hasMoreNotifications = true;
  bool isLoadingMoreNotifications = false;

  // Promotion pagination
  final int _promoLimit = 10;
  int _promoOffset = 0;
  bool hasMorePromotions = true;
  bool isLoadingMorePromotions = false;

  String selectedFilterStatus = "All";
  String selectedPromotionStatus = "All";
  String selectedFilterType = "All";
  String selectedDiscountType = "All";
  String selectedCourseId = "";
  bool notificationFilter = false;
  bool promotionFilter = false;

  List<String> filterStatus = ["All", "PENDING", "SENT", "FAILED"];
  List<String> promotionStatus = ["All", "ACTIVE", "INACTIVE", "EXPIRED"];
  List<String> filterType = [
    "All",
    "STATIC",
    "DYNAMIC",
  ];
  List<String> discountType = [
    "All",
    "PERCENTAGE",
    "FLAT",
  ];

  void setApplyFilter(bool value) {
    notificationFilter = value;
    notifyListeners();
  }

  void setPromotionApplyFilter(bool value) {
    promotionFilter = value;
    notifyListeners();
  }

  void setSelectedFilterStatus(String value) {
    selectedFilterStatus = value;
    notifyListeners();
  }

  void setSelectedPromotionStatus(String value) {
    selectedPromotionStatus = value;
    notifyListeners();
  }

  void setSelectedFilterContactType(String value) {
    selectedFilterType = value;
    notifyListeners();
  }

  void setSelectedDiscountType(String value) {
    selectedDiscountType = value;
    notifyListeners();
  }

  void setSelectedCourse(String value) {
    selectedCourseId = value;
    notifyListeners();
  }

  final TextEditingController scheduleFromController = TextEditingController();
  final TextEditingController scheduleToController = TextEditingController();
  final TextEditingController notificationSerachController =
      TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();

  void setCourseStatus(String value) {
    courseStatus = value;
    notifyListeners();
  }

  void setSelectedModuleType(
      String value, BuildContext context, String courseId) async {
    selectedModuleType = value;
    if (value == 'Course Bookings') {
      await getCourseRegisteredUsers(context, courseId);
    } else if (value == 'Notification') {
      clearNotificationFilters();
      await notificationCampaigns(context, courseId);
    } else if (value == 'Promotion') {
      await coursePromotions(context, courseId);
    } else if (value == 'Transaction') {
      await getTransactions(context, courseId);
    }

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

  final List<String> moduleTypes = [
    'Course Details',
    'Course Bookings',
    'Notification',
    'Promotion',
    'Transaction'
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
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
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
    userType = type;
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

  Future<void> courseById(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": courseId};
    final res = await repo.getCourseById(variables);
    courseData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  String formatToIso(String date) {
    final parts = date.split('/');
    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}T00:00:00';
  }

  Future<void> notificationCampaigns(BuildContext context, String courseId,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMoreNotifications || !hasMoreNotifications) return;
      isLoadingMoreNotifications = true;
    } else {
      _notifOffset = 0;
      hasMoreNotifications = true;
      notificationCampaignData = null;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    setSelectedCourse(courseId);

    final variables = {
      "where": {
        "course_id": {"_eq": courseId},
        if (notificationSerachController.text.isNotEmpty)
          "_or": [
            {
              "campaign_name": {
                "_ilike": "%${notificationSerachController.text}%"
              }
            },
            {
              "email_subject": {
                "_ilike": "%${notificationSerachController.text}%"
              }
            }
          ],
        if (selectedFilterStatus != "All")
          "status": {"_eq": selectedFilterStatus},
        if (selectedFilterType != "All")
          "notification_type": {"_eq": selectedFilterType},
        if (scheduleFromController.text != "" ||
            scheduleToController.text != "")
          "scheduled_at": {
            if (scheduleFromController.text != "")
              "_gte": formatToIso(scheduleFromController.text),
            if (scheduleToController.text != "")
              "_lte": formatToIso(scheduleToController.text),
          }
      },
      "limit": _notifLimit,
      "offset": _notifOffset,
      "order_by": [
        {"created_at": "desc"}
      ]
    };
    final res = await repo.getNotificationCampaigns(variables);
    final newItems = res.courseNotificationCampaigns ?? [];

    if (loadMore) {
      notificationCampaignData?.courseNotificationCampaigns?.addAll(newItems);
      isLoadingMoreNotifications = false;
    } else {
      notificationCampaignData = res;
      Loaders.circularHideLoader(context);
    }

    hasMoreNotifications = newItems.length >= _notifLimit;
    _notifOffset += newItems.length;
    notifyListeners();
  }

  Future<void> coursePromotions(BuildContext context, String courseId,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMorePromotions || !hasMorePromotions) return;
      isLoadingMorePromotions = true;
    } else {
      _promoOffset = 0;
      hasMorePromotions = true;
      coursePromotionData = null;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();
    setSelectedCourse(courseId);

    final variables = {
      "where": {
        "course_id": {"_eq": courseId},
        if (promoCodeController.text.isNotEmpty)
          "_or": [
            {
              "promotion_name": {"_ilike": "%${promoCodeController.text}%"}
            },
            {
              "promo_code": {"_ilike": "%${promoCodeController.text}%"}
            }
          ],
        if (selectedPromotionStatus != "All")
          "status": {"_eq": selectedPromotionStatus},
        if (selectedDiscountType != "All")
          "discount_type": {"_eq": selectedDiscountType}
      },
      "limit": _promoLimit,
      "offset": _promoOffset,
      "order_by": [
        {"created_at": "desc"}
      ]
    };
    print("variables: $variables");
    final res = await repo.getCoursePromotions(variables);
    final newItems = res.coursePromotions ?? [];

    if (loadMore) {
      coursePromotionData?.coursePromotions?.addAll(newItems);
      isLoadingMorePromotions = false;
    } else {
      coursePromotionData = res;
      Loaders.circularHideLoader(context);
    }

    hasMorePromotions = newItems.length >= _promoLimit;
    _promoOffset += newItems.length;
    notifyListeners();
  }

  Future<void> notificationCampaignDetails(
      BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": courseId};
    final res = await repo.getNotificationCampaignDetails(variables);
    notificationCampaignDetailData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> coursePromotionDetails(
      BuildContext context, String courseId) async {
    print("courseId: $courseId");
    Loaders.circularShowLoader(context);
    final variables = {"id": courseId};
    final res = await repo.getCoursePromotionDetails(variables);
    promotionDetailData = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> getTransactions(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    final variables = {"courseId": courseId};
    final res = await repo.getTransactions(variables);
    getTransactionsRes = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  Future<void> getTransactionDetail(
      BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    print("courseId: $courseId");
    final res = await repo.getTransactionDetail(courseId);
    getTransactionDetailRes = res;
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  void clearNotificationFilters() {
    scheduleFromController.clear();
    scheduleToController.clear();
    notificationSerachController.clear();
    setSelectedFilterStatus("All");
    setSelectedFilterContactType("All");
    notifyListeners();
  }

  void clearPromotionFilters() {
    promoCodeController.clear();
    setSelectedPromotionStatus("All");
    setSelectedDiscountType("All");
  }
}
