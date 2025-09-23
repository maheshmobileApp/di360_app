import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CourseListingViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepoImpl repo = LearningHubRepoImpl();

  List<CoursesListingDetails> coursesListingList = [];
  List<CoursesListingDetails> courseDetails = [];
  List<CourseRegisteredUsers> registeredUsers = [];
  String selectedStatus = "All";
  final searchController = TextEditingController();
  bool searchBarOpen = false;
  String? courseId;

  /********************************** */
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userPhoneNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final userDescriptionController = TextEditingController();

  void setSearchBar(bool value) {
    searchBarOpen = value;
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
  String? listingStatus = "";

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      listingStatus = "All";
    } else if (status == 'Draft') {
      listingStatus = 'DRAFT';
    } else if (status == 'Pending Approval') {
      listingStatus = 'PENDING';
    } else if (status == 'Active') {
      listingStatus = "APPROVE";
    } else if (status == 'InActive') {
      listingStatus = 'INACTIVE';
    } else if (status == 'Expired') {
      listingStatus = 'EXPIRED';
    } else if (status == 'Reject') {
      listingStatus = 'REJECT';
    }

    getCoursesListingData(context, searchController.text);
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

  Map<String, int?> get statusCountMap => {
        'All': allJobTalentCount,
        'Draft': draftTalentCount,
        'Pending Approval': pendingApprovalCount,
        'Active': activeCount,
        'InActive': inActiveCount,
        'Expired': expiredStatusCount,
        'Reject': rejectStatusCount,
      };

  Future<void> getCoursesListingData(
      BuildContext context, String? searchText) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getCoursesListing(listingStatus, userId, searchText);

    fetchCourseStatusCounts(context);
    if (res != null) {
      coursesListingList = res;
    }
    notifyListeners();
  }

  Future<void> fetchCourseStatusCounts(BuildContext context) async {
    final res = await repo.courseListingStatusCount();
    allJobTalentCount = res.all?.aggregate?.count ?? 0;
    activeCount = res.approve?.aggregate?.count ?? 0;
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
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> getCourseRegisteredUsers(
      BuildContext context, String courseId) async {
    final res = await repo.getCourseRegisteredUsers(courseId);
    if (res != null) {
      registeredUsers = res;
    }
    notifyListeners();
  }

  Future<void> deleteCourse(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);

    final res = await repo.deleteCourse(courseId);
    if (res != null) {
      getCoursesListingData(context, searchController.text);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> userRegisterToCourse(BuildContext context) async {
    Loaders.circularShowLoader(context);

    final res = await repo.userRegisterToCourse({
      "object": {
        "course_id": courseId,
        "first_name": userFirstNameController.text,
        "last_name": userLastNameController.text,
        "phone_number": userPhoneNumberController.text,
        "email": userEmailController.text,
        "description": userDescriptionController.text
      }
    });
    if (res != null) {
      getCoursesListingData(context, searchController.text);
      scaffoldMessenger("User Successfully Registered");
      clearAll();
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  clearAll() {
    userFirstNameController.text = "";
    userLastNameController.text = "";
    userEmailController.text = "";
    userPhoneNumberController.text = "";
    userDescriptionController.text = "";
  }
}
