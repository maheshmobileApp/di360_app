import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CourseListingViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepoImpl repo = LearningHubRepoImpl();

  List<CoursesListingDetails> coursesListingList = [];
  String selectedStatus = 'All';

  final List<String> statuses = [
    'All',
    'Draft',
    'Pending Approval',
    'Active',
    'InActive',
    'Expired',
    'Reject',
  ];

  final List<String> statusesforapplicatnts = [
    'All',
    'Applied',
    'Shortlisted',
    'Interviews',
    'Accepted',
    'Reject',
    'Declined'
  ];
  List<String>? listingStatus = [];

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      listingStatus = [
        "APPROVE",
        "PENDING",
        "INACTIVE",
        "EXPIRED",
        "REJECT",
        "DRAFT"
      ];
    } else if (status == 'Draft') {
      listingStatus = ['DRAFT'];
    } else if (status == 'Pending Approval') {
      listingStatus = ['PENDING'];
    } else if (status == 'Active') {
      listingStatus = ["APPROVE"];
    } else if (status == 'InActive') {
      listingStatus = ['INACTIVE'];
    } else if (status == 'Expired') {
      listingStatus = ['EXPIRED'];
    } else if (status == 'Reject') {
      listingStatus = ['REJECT'];
    }

    getCoursesListingData();
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


  Future<void> getCoursesListingData() async {
    final res = await repo.getCoursesListing(listingStatus);
    if (res != null) {
      coursesListingList = res;
    }
    notifyListeners();
  }

  /*Future<void> updateJobListingStatus(
      BuildContext context, String? id, String status) async {
    Loaders.circularShowLoader(context);
    final res = await repo.updateJobListing(id, status);
    if (res != null) {
      scaffoldMessenger('CourseListingData update successfully');
      Loaders.circularHideLoader(context);
      getCoursesListingData();
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

   Future<void> removeJobsListingData(BuildContext context, String? id) async {
    Loaders.circularShowLoader(context);
    final res = await repo.removeJobListing(id);
    if (res != null) {
      scaffoldMessenger('JobListingData removed successfully');
      Loaders.circularHideLoader(context);
      getCoursesListingData();
    } else {
      scaffoldMessenger(res);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }*/
}
